#!/bin/bash
# Copyright 2016 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eu

readonly SITE_TARBALL=$1
shift
readonly BUCKET=$1
shift
readonly NOBUILD=$1

# Running `jekyll serve` from the source tree causes Jekyll to construct
# incorrect paths and fail to find template files (see jekyll/jekyll#6060)
# since the bazel-website source tree also looks like a valid Jekyll tree.
# To work around this, we run `jekyll serve` from inside another temporary
# directory.
readonly RUN_JEKYLL_DIR=$(mktemp -d)

function get_gsutil() {
  local gs="${GSUTIL:-$(which gsutil 2>/dev/null || true) -m}"
  if [ ! -x "${gs}" ]; then
    echo "Please set GSUTIL to the path the gsutil binary." >&2
    echo "gsutil (https://cloud.google.com/storage/docs/gsutil/) is the" >&2
    echo "command-line interface to google cloud." >&2
    exit 1
  fi
  echo "${gs}"
}

# Use jekyll build to build the site and then gsutil to copy it to GCS
# Input: $1 tarball to the jekyll site
#        $2 name of the bucket to deploy the site to
#        $3 "nobuild" if only publish without build
# It requires to have gsutil installed. You can force the path to gsutil
# by setting the GSUTIL environment variable
function build_and_publish_site() {
  tmpdir=$(mktemp -d ${TMPDIR:-/tmp}/tmp.XXXXXXXX)
  trap 'rm -fr ${tmpdir}' EXIT
  local gs="$(get_gsutil)"
  local site="$1"
  local bucket="$2"
  local nobuild="$3"

  if [ ! -f "${site}" ] || [ -z "${bucket}" ]; then
    echo "Usage: build_and_publish_site <site-tarball> <bucket>" >&2
    return 1
  fi
  local prod_dir="${tmpdir}"
  tar xf "${site}" --exclude=CNAME -C "${tmpdir}"
  if [ "$nobuild" != "nobuild" ]; then
    # TODO(dzc): Remove this workaround when jekyll/jekyll#6060 is fixed.
    cd $RUN_JEKYLL_DIR && jekyll build -s "${tmpdir}" -d "${tmpdir}/production"
    prod_dir="${tmpdir}/production"
  fi

  # Rsync:
  #   -r: recursive
  #   -c: compute checksum even though the input is from the filesystem
  "${gs}" rsync -r -c "${prod_dir}" "gs://${bucket}"
  "${gs}" web set -m index.html -e 404.html "gs://${bucket}"
  "${gs}" -m acl ch -R -u AllUsers:R "gs://${bucket}"
}

build_and_publish_site "$SITE_TARBALL" "$BUCKET" "$NOBUILD"

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

usage() {
  cat <<EOF
Usage: $0 [--port 12345] [--target DIR [PREFIX]] [--share]
 --port [port]
     Builds docs and starts a web server serving docs on localhost:port. Default
     port is 12345.
 --target <target directory> [<serving prefix>]
     Builds docs as static web pages in <target directory>. Replaces absolute
     paths in the resulting HTML with <serving prefix>, or, if it is not
     specified, with <target directory>.
 --share
     Binds jekyll to the machine's hostname, instead of localhost (useful for
     review).
 --help
     This message.
EOF
}

HOST=localhost
PORT=12345
TARGET=
SERVING_PREFIX=
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --port)
      PORT="$2"
      shift
      ;;
    --share)
      HOST="$HOSTNAME"
      ;;
    --target)
      TARGET="$2"
      shift
      SERVING_PREFIX="${2:-}"
      build_static
      exit 0
      ;;
    --help|help)
      usage
      exit 0
      ;;
    *)
      usage
      exit 1
  esac
  shift
done

readonly WORKING_DIR=$(mktemp -d)
# Running `jekyll serve` from the source tree causes Jekyll to construct
# incorrect paths and fail to find template files (see jekyll/jekyll#6060)
# since the bazel-website source tree also looks like a valid Jekyll tree.
# To work around this, we run `jekyll serve` from inside another temporary
# directory.
readonly RUN_JEKYLL_DIR=$(mktemp -d)

check() {
  which $1 > /dev/null || (echo "$1 not installed. Please install $1."; exit 1)
}

build_tree() {
  bazel build //:jekyll-tree.tar
  rm -rf $WORKING_DIR/*
  tar -xf "$(bazel info bazel-bin)/jekyll-tree.tar" -C $WORKING_DIR
}

build_static() {
  build_tree
  echo "Serving bazel.build site at $HOST:$PORT"
  TMP_TARGET=$(mktemp -d)
  # TODO(dzc): Implement the same workaround below for jekyll/jekyll#6060.
  jekyll build --source $WORKING_DIR --destination "$TMP_TARGET"
  REPLACEMENT=$(echo $SERVING_PREFIX | sed s/\\//\\\\\\//g)
  find $TMP_TARGET -name '*.html' | xargs sed -i s/href=\\\"\\//href=\"$REPLACEMENT\\//g
  find $TMP_TARGET -name '*.html' | xargs sed -i s/src=\\\"\\//src=\"$REPLACEMENT\\//g
  cp -R $TMP_TARGET/* $TARGET
  echo "Static pages copied to $TARGET"
  echo "Should be served from $SERVING_PREFIX"
}

build_and_serve() {
  build_tree
  echo "Serving bazel.build site at $HOST:$PORT"
  # TODO(dzc): Remove this workaround when jekyll/jekyll#6060 is fixed.
  pushd $RUN_JEKYLL_DIR > /dev/null
  jekyll serve --host "$HOST" --detach --port "$PORT" --source "$WORKING_DIR"
  popd > /dev/null
}

main() {
  check jekyll

  old_version="Jekyll 0.11.2"
  if expr match "$(jekyll --version)" "$old_version" > /dev/null; then
    # The ancient version that apt-get has.
    echo "ERROR: Running with an old version of Jekyll, update " \
      "to 2.5.3 with \`sudo gem install jekyll -v 2.5.3\`"
    exit 1
  fi

  kill_jekyll

  while true; do
    build_and_serve

    echo "Type q to quit, r to rebuild docs and restart jekyll"
    read -n 1 -s user_input
    if [ "$user_input" == "q" ]; then
      kill_jekyll
      echo "Quitting"
      exit 0
    elif [ "$user_input" == "r" ]; then
      kill_jekyll
      echo "Rebuilding docs and restarting jekyll"
    fi
  done
}

kill_jekyll() {
  pid="$(lsof "-tiTCP:$PORT" -sTCP:LISTEN)" || true
  if [ ! -z "$pid" ]; then
     kill -9 "$pid"
  fi
  # I found I got bind errors sometimes if I didn't wait a second for the server to
  # actually shut down.
  sleep 2
}

cleanup() {
  rm -rf $WORKING_DIR
  kill_jekyll
}
trap cleanup EXIT

main

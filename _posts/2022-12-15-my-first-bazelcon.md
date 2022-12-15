---
layout: posts
title: My first BazelCon
authors:
  - acbdev
---

# My first BazelCon

## Let's start from the top

Here I am, in my little apartment  in the UK, under my weighted blanket and with a cup of herbal tea (hibiscus if you are curious). Quite the contrast from a couple of weeks ago, when my over-caffeinated self was nervously riding the elevator of the New York Times building with a bunch of strangers, ready to kick off BazelCon with the Community Day.

Record scratch, freeze frame. Yep, that's me. You're probably wondering how I got here.

My name is Anna, I am a software engineer working at Spotify. I would have called myself an iOS developer until quite recently, but I decided to join a mobile infrastructure team so besides a small identity crisis, I have a new job title!

A few months ago, as I was still gleefully onboarding at a team offsite in Sweden, my manager and their manager told me "Anna! You should come to BazelCon"! Mind you, I found out that Bazel existed a couple of weeks before this encounter and my notes were still empty,  judging me from my Documents folder. However, these are the same people that had just convinced me to jump in the 4°C (40°F) waters of the Baltic Sea, so of course I said "Yes! I can't wait!".

And since I agreed to tag along with the rest of the (much more knowledgeable) Spotify team, I had been nervous up until the start of the conference.

Why the nerves, you might ask? Bazel won't bite. I know that now, but back then I really did not know what to expect. From my time online and in iOS circles, I had heard so much about how hard it is to learn Bazel, how gargantuan the learning curve is. I also had people in the past tell me how the open source community can be super scary to navigate as a newcomer looking to participate and contribute. And pair this with the fact that switching from feature work to infra work is quite tough, let's just say my expectation for my BazelCon experience went as follows: me, someone who does not know her CMake from her Maven, doodling little hearts on her iPad for 8 hours a day while much smarter people speak about advanced topics flying over my head like paper planes.

And even if yes, I can be quite dramatic, I won’t berate myself too much for this imagery. Learning something new is scary, and it's even scarier when you keep hearing about how tough it is to learn this new thing. But nerves aside, I agreed to go and I decided that I was going to try to make the best of it.

## BazelCon Community Day

But let's get back to the elevator - or less specifically, to the BazelCon Community Day!

The Community Day was divided into two tracks, beginner and advanced. The discovery that there were other people with limited Bazel knowledge was extremely reassuring. However, the biggest wave of relief came when I started chatting to someone shortly after arriving, and after a bit of small talk they blurted out to me "I literally have no idea what's going on with Bazel by the way". We laughed and encouraged each other, this simple candid interaction broke all the tension I was holding in and I was finally getting to a better frame of mind.

What do I mean with a "better frame of mind"? This is a mindset which, I found in my experience, can maximize learning and positive experiences. It consists of humility, patience, determination, and curiosity. It is (mostly) void of insecurity, fear, and shame. If you manage to internally balance out the fear and insecurity with patience, and the shame with humility, you can overcome those obstacles and be primed to learn and absorb as much as you can. Please don't come at me if you think this is rubbish... I am an engineer with poor emotional awareness, not a psychologist!

Thanks to the better frame of mind, and with a lot less shame and insecurity, I was ready to start the workshops! So off I went to attend the Bazel Bootcamp, led by Benjamin Peterson from EngFlow. It began with an explanation of Bazel fundamentals, followed by a series of exercises. Now, I was naively expecting something akin to the typical tutorials online which baby you every step of the way, so you can imagine my face when I saw this.

-   Edit this file.
    
-   Add a java_binary for this target. Here's the documentation.
    

I felt as if I was on the Great British Bake Off, and Prue Leith gave a technical challenge where the method instructions just read "Bake a lemon merengue pie". If you are a Bazel wizard, you might be confused at how I was struggling with this. But I did struggle, for almost twenty minutes. I read the documentation, I read other resources too, but I was starting to get very frustrated because my "solution" did not make sense and I could not understand why. At some point Benjamin revealed the solution on the screen, and to that I almost laughed, because I quickly saw how much I was overcomplicating it. This shifted my perspective again; it reminded me to be patient and think things through, not over. So with patience and humility at my side, I decided to go through the rest of the workshop a lot more relaxed, asking a million questions in front of everyone without being afraid of sounding dumb. Turns out a lot of people had the same questions as I did, so everyone won in the end.

After a great lunch where I managed to assemble the weirdest salad I had in a while, it was time for the second workshop on Writing Bazel Rules, led by Jay Conrod from EngFlow. Jay explained a lot about rules and actions, and very patiently answered a lot of questions from us. The entire workshop was full of helpful concepts and collective learning, but one thing in particular was very impactful to me. At some point, as Jay was explaining action phases, I shot up my hand and shared a metaphor to try and understand if I was on the right track. He took the metaphor very enthusiastically and continued explaining using it.

Not only did this help me solidify my learnings, but it was also testament to how Jay and the team had managed to make this workshop a really safe and collaborative environment. I often think of metaphors to understand technical concepts, but it is rare that I feel comfortable enough to share them without shame. So, thank you Jay, for your patience and enthusiasm.

These workshops not only prepared me for the days of conference ahead, they also reminded me of the value of learning together. In the past few years, all my learning has been independent reading and practicing, maybe sharing parts of the learning journey but never in a setting like this. Learning as we did in these workshops was so enriching, because  one person's struggles may be silently shared by many, an answer to a question can help several people at once, and so on.

We finished Community Day with Happy Hour, which was a great chance to mingle and get to know other Bazel peeps. Bazelers? Bazelators? Bezels? Anyways, it was brilliant. I took the chance to corner Helen Altshuler (CEO of EngFlow) and snap a selfie together. I took the chance to thank her for her amazing work in the Bazel Community, and she encouraged me to write this very article!

### The Conference

Invigorated from all I learnt at the Community Day, I was finally feeling ready for BazelCon. The morning of the conference,  my colleagues and I walked from downtown Manhattan all the way to Pier 57. It was quite a trek from our hotels, but we had an ongoing steps competition in my team and there was no way Aleks and I were losing to Patrik. 

It's hard to describe the atmosphere that welcomed us when we arrived. I will try anyway. It was "pleasant organized excitement". And no, this is not a genre from my Spotify Wrapped. With that I mean, it was a very relaxed and pleasant environment, it was immaculately organized, and you could sense the excitement buzzing in the air.

The excitement continued as BazelCon started, with Jason Dobies (Developer Advocate at Google) kicking things off and welcoming everyone. On stage, Jason made a point to talk about diversity and inclusion very early in his speech. This meant a lot for me, not just that he mentioned it but the way he did it. It was clear that the importance of diversity and inclusion in the BazelCon community was not an afterthought, a checkbox to tick, but something valuable. This might seem insignificant, but it made me feel so welcomed. And, it did something strange: it encouraged me to think of a way - any way - to contribute to the conference. So I chose my own way, which was to annoy all my Twitter followers by live-tweeting what was happening as the conference continued! I tried to share some resources and info if I could. A lot of my iOS friends reached out afterwards, interested to learn more about Bazel!!

The schedule was very packed, however the rhythm was navigable and there were talks for all experience levels. As someone with a short attention span, I really appreciated the lightning talk marathons. And I especially enjoyed the environment of the Birds of a Feather sessions. I never attended anything like that during a conference, but I found it an incredibly relaxed and collaborative environment. I went to the Android and the iOS sessions and I filled my iPad with notes and observations to bring back to my team.

Another key event in the conference was, for me, the Diversity Equity and Inclusion lunch that was held on the first day. The lunch consisted of a panel of speakers, engaging with the audience in conversation about Bazel, the open source community in general, and of ways to increase diversity and inclusion in these environments. People shared their experiences, and I learnt SO MUCH about things I thought I arrogantly knew everything about. Something really resonated with me, which is when an attendee mentioned that sometimes they feel the pressure of representing their entire gender in the community. I feel like this sometimes, especially when I make mistakes rather than when I accomplish something. It was so refreshing to be part of this conversation. Another thing I brought back from this session was how non inclusive certain behaviors are, such as feigning surprise when someone doesn't know something. I am guilty of doing this, in the past.

What helped make this session so great was the fact that the room was filled with people who are not part of unrepresented groups, but showed up ready to listen as allies. The support of the community is the most important ace we can have in our sleeve, and seeing the numbers in that room filled me with hope.

### The End?

That very descriptive image I had before coming here could not be further from the truth. During the two days of the conference, there were no silly doodles on my iPad. Instead I was able to follow and understand and, much to my surprise, I was able to learn something from every single talk; even the most advanced ones offered plenty of helpful lessons. I love being pleasantly surprised even more than I love free snacks.

It's time to wrap up. So, what did I learn from BazelCon? What did I take home from this? First of all, about 7 t-shirts and eleven stickers, and a great travel mug. Jokes aside, this conference filled me with excitement and curiosity about this great community.

It opened my eyes to how unfounded and ineffectual my fears were; it showed me that no matter how nervous you are about your stage in the Bazel learning curve, you have a place at BazelCon. No matter how much or how little you know, you can still be a part of the community and contribute however you can.

I will now get back to my herbal tea and my weighted blanket, but not before giving thanks to all the wonderful people I met during the conference, to Spotify for helping me get there, and to everyone involved with the organization of the conference. And thanks to you, dear reader, for sticking to the end and finishing this article full of rhetorical questions!!

See you in 2023!!


_PS: HI!! I hope you enjoyed the story of my first BazelCon. Please remember that I am speaking on my behalf and these are my thoughts and views, and not my employers!_
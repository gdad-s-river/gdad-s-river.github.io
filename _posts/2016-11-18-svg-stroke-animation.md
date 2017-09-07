---
title: "Towards a Suprise: SVG Stroke Animations"
date: "2016-11-18"
layout: post
permalink: "/blog/surprise-svg-stroke-animations"
tag: "svg, stroke-animations, Inkscape"
---

TL;DR :

I made [this](https://bhavri.github.io). Go check it out! (Preferrably on a desktop screen browser (oops!)).

Liked what you saw? This is called SVG stroke animations. It should be clear by the name, it has to do with animating any kind of weird svg shapes. In this case, shapes of english alphabets!

So I started to seek how I could do this alphabet - letter type thingy animation without using a video editor. I started with the awesome [Jake Archibald](https://twitter.com/jaffathecake)'s [Article](https://jakearchibald.com/2013/animated-line-drawing-svg/). This articles tells the easiest and most straight forward way to animate a stroked svg  by animating `stroke-dashoffset` property of svg. By _stroke_ I mean **bulk path-ed svg, paths of svg(s) that go through the space with no empty space in between**, as in solid cylinder.

And this is how Jake ends the article.

![Justin Bieber, Christ Our Savior]({{ site.url }}/assets/images/jakethecake-svg-line-anime.png)

Before this I had the idea of using [GSAP DrawSVGPlugin](https://greensock.com/drawSVG). There were two problems

1. It was paid
2. I had to find a way to turn fonts into svg shapes (what!)

Then I saw [this](https://codepen.io/munkholm/pen/EaZJQE) codepen, and I wondered if it was possible to convert font objects in a vector graphics editor to stroke path text svgs. This pen made it seem so (I still don't know how this is done). I have a rough idea that, it might have been done using a technique similar to that shown in this [medium article](https://medium.com/@gordonnl/stylised-line-animations-ded23320ffe5#.jb5a4whlx).

Now I'm no expert in graphics or for that matter web design, but I think this is it. And I'll like to learn how masking is done so seamlessly, and how these text shapes are made at the first place (Do we mask the text object in the graphics editor like inkscape and illustrator, can anybody start me where I could learn that?). Anyway, once I'm done with the projects that I've in mind (which is a lot), this will be the next quest.

Okay wait, yes, that's how it is done! Masking the text shapes in the vector graphics editor. See what I found from one of my searching tweets:

![Erik Dahlström's Tweet]({{site.url}}/assets/images/svg-animated-mast-text-shapes-tweet.png)

The Full Conversation [here](https://twitter.com/erikdahlstrom/status/779022861818290177)

But there still is the same problem - masking so many text objects in a graphics editor is manual work. Could I not automate it somehow?

There was also, I remember, a method to make this work on canvas, but I didn't like it so I left it right there.

I started diving into what actually svg paths are and  how they work by reading [Sitepoint's closer look at svg path](https://www.sitepoint.com/closer-look-svg-path-data/). It was informative, but I couldn't get anything that I wanted, out of it.

And oh, even before anything else, I actually thought there would be a  node module available for this task. I found one, it was called `text-to-svg`, and I thought my work was done there! But ALAS! I was to find, that it would convert the text into svgs which are not stroked svgs but outlined, which were essentially filled with color, and the `fill` property in svg can't be animated.

That's when I stumbed upon an article that explained, [why it is not possible to make such a plugin](http://graphicdesign.stackexchange.com/questions/39178/animate-drawing-of-svg-text/40990#40990?newreg=753c630034d34d3bbf5dca7a9da28ebd). And it made complete sense. So the intention that I had, of automating everything I did wasn't possible (at least yet). I knew I was in for a manual ride.

I didn't explore [opentype](http://opentype.js.org/) much. It sort of gave access to the glyps (svg path points) somehow? I guess? I don't really know.

And oh, by the way, like Jake Archibald, the magician Chris Coyer also had a [smiliar article](https://css-tricks.com/svg-line-animation-works/) on css tricks.

There were a number of stackoverflow questions [like this](http://stackoverflow.com/questions/32060838/svg-handwriting-animation-without-using-stroke-properties), which shared the problem I was trying to solve, but I needed something very quick, and something that would just work. I needn't necessarily had to make it very pretty like the medium article I shared above. I just wanted a long letter to be written online.

Fortunately I messaged [Alyssa](https://twitter.com/AlyssaNicoll) on twitter to ask for her suggestions or advice (whatever she'd have). And fortunately she did have some pointers that would eventually help me. SVG Stroke Fonts to the rescue! Sort of.

I read the [article that talked about Hershey's Text Extension in Inkscape](http://www.evilmadscientist.com/2011/hershey-text-an-inkscape-extension-for-engraving-fonts/)

Then I used [Vivus](https://github.com/maxwellito/vivus) to animate them in a callback hell (which I opened an issue for)

![Issues! Yay!]({{site.url}}/assets/images/bhavri-github-issues.png)

![Unacceptable Manual Callback Chaining]({{site.url}}/assets/images/bhavri-github-callbacks.png)

Also there's a forced jag towards the poem, at the end, which is nothing but forced scrolldown push of the page, so that the [requestAnimationFrame](https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame) remains active, and the animation doesn't stop there, because of being out of the viewport; which I've to improve, by sensing when there is a vertical scroll (when it actual comes, that is), and the smoothly animating the scroll to the next line of svg animation continuation (in the issues as well).

This is the end of the rant. Thank you everybody, whom I could have missed, whose blogposts, I'd have read and learnt from. Really, thank you!

As Big Hero 6's Cartoon Protagonist says:

"BALALALA"

Okay Bye

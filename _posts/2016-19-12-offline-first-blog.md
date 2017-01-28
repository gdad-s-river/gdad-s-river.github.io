---
title: "Getting My Blog Offline First and Other Stuff"
date: "2016-12-19"
layout: post
permalink: "/blog/offline-first-blog"
tag: "service-worker, offline-first, pwa"
---

**UPDATE**: I recently added some small enhancements, and edited the blogpost which was published on [Fossbytes](https://fossbytes) [A friend's startup]. You can read the updated version [here](https://fossbytes.com/get-jekyll-blog-work-offline/)

### **TL;DR**

1. **Why offline first hype makes sense with other concepts like streams etc.**
2. **How I'm stuck in learning just frameworks and not the web platform**
3. **How I'm baffled at my (and others') inability to get lost in web development and not explore more computer science ideas.**
4. **Some sneak peaks from during my campus training program**
5. **How I made my jekyll blog offline first (code snippets)**

Now I know this is not new, service workers landed first in Chrome Canary in 2014, so was the most read Jake Archibald's [offline cookbook](https://jakearchibald.com/2014/offline-cookbook/). But only during the past year, have all the google developer advocates and other software engineers on chrome team publicised offline first experience, and app like launching capabilities of a website powered by service workers! They are investing so much time and money, so as to have enabled a Bangalore PWA summit for free (happened 6 - 7 months back). I got to meet Matt Gaunt, Jake Archibald, and others from the chrome developer relations team! It was like a dream come true, having watched so many of their videos on youtube.

Okay I'm getting carried away. Starting freshman developer last year, our front end training was a quick round of essentials, I can safely fearlessly say, that we simply didn't have time to advocate experience to say that we were experts in either html5, css3 or javascript, or any other technology or infrastructure for that matter, or at least were tending towards any. We were demarcated on three teams: Learning Angular, Learning React, Learning Backbone. I was stupid enough to have gotten the impression from the name of the frameworks, without concept of proof or even shallow diving in any of them. I put them as follows: Backbone > Angular > React, simply for no reason than a not so very instinctive hunch to do so.

My point is, we were put to frameworks before we knew what browser history api was, it worked, and what other kind of legacy / old histories there were, and were introduced to backbone, angular and react routers first. And so on and so forth. Now, I understand those were business requirements. But in retrospect, I seem to go back to that one moment, when Bramesh Madhav regretted (sort of ?) his starting on things late, and how there was so much to computer science than just what we mostly do in the company (I'd then asked him later in the evening for the link to the data structures coursera course he'd talked about). I remember standing in the war room with Mahesh Talada, who by the way is an awesome leader developer, trying to understand what he was trying to make us understand, a kind of input and page flow for the project tracker application we were building with him for our shadow project. It was tough to get all through, especially, and this is not a defying the logic of time, when the project ended and I realised that I'd hardly written 12 lines of code during the whole project! The responsibilities were put on the team (us freshers) to decide the work management. The work was not even remotely equally divided. One person ended up doing much more than the other. And not once, did one person encouraged the other to pick up stuff. That was bad on the part of all of us. It was perhaps, because not everybody was excited about programming the web (neither was I at the time, I was scared).

Just a note of appreciation here, Mahesh constantly pushed us into learning as much of browser native api as we could, but none of us provided much heed to that one mdn link he shared with all of us, before the project started. Frameworks had taken over.

Why is there so much attention towards just frameworks, when there are so many techniques, concepts, and unexplored apis on the web platform that when put to use, could be exploited to take advantage from irrespective of the framework one is using, talking performance specifically. For example [this pretty thing](https://jakearchibald.com/2016/fun-hacks-faster-content/) which challenges single page applications for a completely new page download (subject to different use cases of course). No doubt that frameworks empower the developer, but their true worth of usage is only unclothed by a few. Taking from that, I'm also baffled by my (and others') inability to explore core concepts beyond web development. This flick strengthened very much when I read [this article](https://medium.freecodecamp.com/why-i-studied-full-time-for-8-months-for-a-google-interview-cc662ce9bb13#.1qygey3j1) and watched this [chrome dev summit video of Alex Russel](https://www.youtube.com/watch?v=4bZvq3nodf4). The article presented a self taught web developer and entrepreneur's journey of preparing for a google interview full time, and the reason for it, and the video blew me away by electronic paper references, which essentially taught me right in the face, that there shouldn't be a thing as "Electronics and Communication Engineering" or "Electrical Engineering" or "Computer Science Engineering" but perhaps "Electrical and Computer Science Engineering", and choosing subsets to research and study upon.

I made my blog, offline first, put a pretty web manifest, so that I'd have an Add to Homescreen option on Android Chrome, Firefox, Opera. I started with a [Udacity Course titled Offline Web Applications​](https://www.udacity.com/course/offline-web-applications--ud899) instructed by, again, our very own Jake Archibald (his talk presentations are mind blowing!). I spent a couple of hours for three days on this course, hand writing code while following instead of copy pasting (doing this I figured, I was able to retain new stuff more for future use, than to again copy paste stuff having forgotten either the syntax or exactly what it did). I learnt about service workers, what they really are(web workers on steroids), how to write code for different caching strategies for different types of assets and services (avatar images, vs user post images vs html, css, js etc...). I learnt about when indexDB (the browser database), should be used over browser cache, how to debug and update service workers, and a ton of other stuff.

Before attempting to make my blog offline first, I'd this sticky on my laptop from PWA Summit Bangalore, but I felt a tinge of guilt in never having explored anything after that. That was put to an end.

![PWA Bangalore Sticker]({{ site.url }}/assets/images/pwasticky.jpg)

This is how I made my jekyll blog offline first. On all the relevant pages, this piece of script gets executed. It's just checking for the existence of service worker api in the browser and registering the service worker.

```javascript
if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/sw.js').then(function(reg) {
  if (!reg.installing) return;
      // console.log("[*] ServiceWorker is installing...");
  var worker = reg.installing;
      worker.addEventListener('statechange', function() {
          if (worker.state == 'redundant') {
              console.log('[*] Install failed');
          }
          if (worker.state == 'installed') {
              console.log('[*] Install successful!');
          }
      });
  });
}
```

There are ton of other service worker events, that weren't needed for a static content blog, although they are very interesting and worth checking out.


```javascript
// sw.js 

---
layout: null
--


const staticCacheName = "gdad-s-river-static-v2";


console.log("installing service worker");


const filesToCache = [
  "/",
  {% for page in site.html_pages %}
    '{{ page.url }}',
  {% endfor %}
  {% for post in site.posts %}
    '{{ post.url }}',
  {% endfor %}
  "/assets/images/bhavri-github-callbacks.png",
  "/assets/images/bhavri-github-issues.png",
  "/assets/images/jakethecake-svg-line-anime.png",
  "/assets/images/svg-animated-mast-text-shapes-tweet.png",
  "css/main.css",
  "/about/",
  "/index.html"
];
```

**staticCacheName**, is the cache version which is to be updated every time I make some changes to the cached responses. And I'm just defining what requests I want to intercept and cache in an array (used in the next snippet).

```javascript
self.addEventListener("install", function(e){
  self.skipWaiting();
  e.waitUntil(
    caches.open(staticCacheName).then(function(cache){
      return cache.addAll(filesToCache);
    })
  )
});
```

**self.skipWaiting**, is to say, that every time this *sw.js* file changes, the newer version of the service worker shouldn't be queued, but made active immediately, throwing away the older version.

e.waitUntil quoting from MDN website :

> **The ExtendableEvent.waitUntil()** method extends the lifetime of the event. In service workers, extending the life of an event prevents the browser from terminating the service worker before asynchronous operations within the event have completed.


I open up a cache named **gdad-s-river-static-v2** (I could tell you why this name, if you happen to ask me), which returns a promise with my cache name, and then I call cache.addAll (which uses the fetch API in the background), which fetches all the requests in the array provided and caches them.

On to the next snippet!

```javascript
self.addEventListener("activate", function(e){
  e.waitUntil(
    caches.keys().then(function(cacheNames){
      return Promise.all(
        cacheNames.filter(function(cacheName){
          return cacheName.startsWith("gdad-s-river-static-")
            && cacheName != staticCacheName;
        }).map(function(cacheName){
          return cache.delete(cacheName);
        })
      )ß
    })
  )
});
```

When service worker activates, I'm ensuring that, any service worker which is not the latest version gets deleted. For example, if my latest cache version is say **gdad-s-river-static-v8**, and someone is still on **gdad-s-river-static-v5**, I want that client to not care about pumping one version at a time, but forthrightly delete that version to install the latest one.

```javascript
self.addEventListener("fetch", function(e){
  e.respondWith(
    caches.match(e.request).then(function(response) {
      return response || fetch(e.request);
    })
  )
});
```

In the fetch event I'm simply telling the service worker, how to respond to a particular request made (since we are hijacking the response giving power, service workers only work on secure aka https origin websites). I tell it to match the request to those cached in the browser, and if they don't find that particular response to the request, fetch it through the network, else serve it from the cache. This could be made smarter, that the incidental response to a missed request should be cached also, after fetching, but since cache.addAll will fail (and hence the service worker will fail), if any of the provided requests are not cached, it's probably not needed.

Tada! Service worker made jekyll powered blog offline!

You could see an app like experience demo in this ![gif offline first blog](https://media.giphy.com/media/l4JyWeu74yyEFJDUI/source.gif)
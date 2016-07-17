---
title: Equality Comparisons and Sameness in Javascript
date: "2016-05-27"
layout: post
path: "/blog/equality-comparison-and-samename-in-javascript/"
readPrevious: "/blog/dependent-yeoman-prompts/"
---

This is the piece of code that [CodeChef](https://www.codechef.com/) shared on their [facebook page](https://www.facebook.com/CodeChef/) [here](https://www.facebook.com/CodeChef/photos/a.10150302285647799.346300.53227312798/10153675104012799/?type=3&theater). To write the code snippet down:

```javascript
> var a = [1,2,''];
// undefined
> a.slice(-1)                  //1
// ['']
> a.slice(-1) === ['']
// false
> typeof(a.slice(-1))
'object'
> a.slice(-1) == ''            //2
// true
//WTF!
```

Now I had never had programmed before 1 year, so I still jump in ecastacy on the 'aha!' moments a programming language has to offer. Many of them for javascript came from [Kyle Simpson](http://getify.me/). One came today from the code snippet above, that an [acquaintance](https://www.facebook.com/shreysaroch?fref=ts) happened to share. First I was very surprised by (1), because it was an array with an empty string element being checked for another such array. Turns out they are **two different object references being compared** so obviously they won't come true. Infact

```javascript
> [] == []
// false
> {} = {}
// false
```

Call me stupid, or a slow learner, I didn't know this. Thanks to [Giri Bhai](https://www.facebook.com/giriraj.sharma27?fref=ufi) he told me everything about the code snippet above. The second thing that I didn't know about (2) was that since on the LHS there's an object (```a.slice(-1)```) being compared to RHS's string (```''```), the javascript works such that it automatically calls ```toString``` method over the object over the inbuilt ```==``` function, so that object is converted to string, and so that the comparison could make sense. That's why (2) is correct.

To quote the first line of [More detailed link to : **Equality Comparisons and Sameness: MDN**](https://developer.mozilla.org/en/docs/Web/JavaScript/Equality_comparisons_and_sameness) :

> Briefly, double equals will perform a type conversion when comparing two things; triple equals will do the same comparison without type conversion (by simply always returning false if the types differ)

I became so anxious about knowing why is that the code snippet above was behaving as it was, that like I always do, I started asking on as many platforms and places I could: on javascript IRC channel, twitter, fb, office colleagues etc. [This](https://www.facebook.com/arihantverma/posts/1319880568076896) is the facebook thread of comments that eventually produced the answer.

If you like that I'm exploring things I didn't know and want to give me thumbs up or pats on the back, or if you would just want to bully me for my lack of basic knowledge, please tweet me at [@gdad_s_river](https://twitter.com/gdad_s_river). I'd love to learn about what you are doing and learning, and learn from it, and perhaps I might be able to tell you a thing or two.

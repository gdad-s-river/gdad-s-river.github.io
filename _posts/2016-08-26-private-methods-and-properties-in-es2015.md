---
title: Private Methods and Properties in es2015 Classes
date: "2016-08-25"
layout: post
permalink: '/privates-in-es2015-classes'
tag: "es2015, classes, private-methods"
---

Using function constructors to simulate classes in es5 lets us use private functions and properties at our will, by the virtue of closures / module pattern. It was astonishing to me that es2015 classes didn’t have that privilege ( although there are many other privileges like

- One can’t call a constructor (class) without new keyword
- One can’t attempt to construct methods with new keyword
)

I wrote a simple social share implementation ( an es2015 class ) for a client, since relying on the jquery implementations or other implementations like [addThis](http://www.addthis.com/) was too much. The SocialShare class

1. Keep concerns of what it does separate, in a namespace(no surprise).
2. File (social-share.js), is included in the parent component file only when the social share component is meant to be present on that page (detected by ```data-role="social-share"```) as a separate chunk from the main code of the component itself (which includes a popup and all the eventListeners on separate parts of the parent component ) with the help of webpack's powerful ```require.ensure```. I think (?) it is something similar in concept to jquery’s ```$.getScript()``` function.

But when I started writing test cases for it, I realised how scruffy my code could be. I could have exposed methods on the Class those aren't supposed to be there on the instantiated object for user (dev) to use (*all the methods of a class are added to the class’s prototype by default and are passed onto the instantiated object (provided you haven't over written the return value as as object that is not the one from the instantiation of the class)*). It would simple make for a bad leaky API.  So I searched how I could use private properties and methods in es2015 until there is native support for it. A Simple Google Search Sent me to these two links (in Order), that taught me.

- [What are WeakMaps](http://ilikekillnerds.com/2015/02/what-are-weakmaps-in-es6/)
- [Privates in es2015 in javascript classes](http://ilikekillnerds.com/2015/09/privates-in-es2015-javascript-classes/)

## TL;DR
This is a simple solution which uses module system, weakMaps and normal javascript functions to make use of private methods and variables.

Quick Quiz: Name the new addition to the primitive types in Javascript that was added in es2015. Also find its uses. Post it in the comments below for others to see!

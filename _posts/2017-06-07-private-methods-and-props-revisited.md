---
title: "Private Methods and Props in JS Classes: Revisited"
date: "2017-06-07"
layout: post
permalink: "/blog/private-parts-js-classes"
tag: "js, es2015, fundamentals"
---

In an (earlier post)[https://gdad-s-river.github.io/privates-in-es2015-classes], I had read and then talked about / give references about how one can use javascript modules to enable private methods in javascript class definitions (the need being that since every method on a class goes into the prototype of that class instantiated object, one doesn't really have room for native javascript private method support). Also in the same post, I had shared links which talked about using WeakMaps to enable private properties in the class, without any memory leak possibilities with using normal primmitives or objects being used (even Symbols) [why is this such I'm yet to properly read and discover and will cover it in a future post]. It's probably because objects and [I don't know about symbols] can be held references of and hence could lead to leaky usage. Whereas WeakMaps are instantly garbage collected whenever their mapped object to values are deleted, say inside a javascript class used as a private variable, as explained (here)[https://ilikekillnerds.com/2015/02/what-are-weakmaps-in-es6/] Turns out there is an ecmascript proposal for native javascript ways to do these. 

You can read the proposal (here)[https://github.com/tc39/proposal-private-fields]



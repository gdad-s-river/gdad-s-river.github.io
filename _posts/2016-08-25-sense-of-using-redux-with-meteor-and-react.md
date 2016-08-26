---
title: Sense of Using Redux with Meteor and React
date: "2016-08-25"
layout: post
permalink: '/redux-with-meteor-n-react'
---

The other day, when I gave a talk about Meteor + React in the javascript meetup in Sapient Bangalore, Neha asked what was the need of using redux with Meteor anyway. So I researched after the talk and found these series of [medium articles](https://medium.com/modern-user-interfaces/how-we-redux-part-1-introduction-18a24c3b7efe#.g2fof11i7) by the awesome [Abhi Ayer](https://twitter.com/AbhiAiyer). The series aren't complete, I think he forgot to or is too busy to write the last one. But the [code](https://github.com/abhiaiyer91/How-We-Redux-Todos)  makes everything understood.

# TL;DR

All the client side state is handled by redux's data flow with its [three principles](https://github.com/reactjs/redux/blob/master/docs/introduction/ThreePrinciples.md). Redux handles the **UI state**. Meteor by default has the ability to handle the **Domain state** ( server side mutable state, since ultimately data in the database has to change ). First article in the series explains it perfectly. What we leverage through Redux is distinct two types of actions only applicable

- Actions that return the new state, where reducer handles the business logic.
- Actions that handles the server side Domain State mutability namely inserting, updating, deleting date from the database.

It might seem silly (the second point ) coming from understanding Redux, but it becomes clearer when one reads the code of the github repo provided.

P.S: To Make sense of how react-paginate component is working : [React Paginate Example](https://github.com/AdeleD/react-paginate/blob/master/demo/js/demo.js)

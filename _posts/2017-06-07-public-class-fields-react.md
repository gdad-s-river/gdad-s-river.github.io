---
title: "Public Class Fields in React"
date: "2017-06-07"
layout: post
permalink: "/blog/react-public-class-fields"
tag: "react, js, classes"
---

Til now I had been conjuring up a constructor to bind the dom event handlers like so

```javascript
import React, { Component }
class Blala extends Component {
  constructor(props) {
    super(props);
    this.state = { clicks: 0 }
    this.onClickHandler = this.onClickHandler.bind(this)
  }

  onClickHandler() {
    this.setState(prevState => {clicks: prevState.clicks + 1})
  }

  render() {
    <button onClick={onClick} />
  }
}
```

But turns out we do not need constructor function at all for this, we could use javascript public class fields like so :

```javascript
import React, { Component }
class Blala extends Component {
  state = { clicks: 0 }
  handleClick = () => {
    this.setState(prevState => {clicks: prevState.clicks + 1})
  } // if you use a `function` keyword then you'd have to explicitly bind it.

  onClickHandler() {
    this.setState(prevState => {clicks: prevState.clicks + 1})
  }

  render() {
    <button onClick={onClick} />
  }
}
```

That's it!

I learnt this from [Ken Dodds Free Egg Head Tutorial](https://egghead.io/lessons/javascript-public-class-fields-with-react-components)

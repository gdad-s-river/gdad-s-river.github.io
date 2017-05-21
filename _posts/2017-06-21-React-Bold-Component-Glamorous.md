---
title: "A Bold React Component"
date: "2017-05-21"
layout: post
permalink: "/blog/react-bold-component-glamorous"
tag: "react, component, css-in-js, glamorous"
---

I'm working on a basic alumni search index app using [Vulcan](http://docs.vulcanjs.org/). It uses React. I'm using [glamorous](https://github.com/paypal/glamorous) for styling. It's really clean and easy to use. It's inspired from glamor, which is another very popular css in js solution built by the awesome Mad Scientist Sunil Pai. 

I wanted to make a component which basically just takes a bunch of strings, wrap it in an HTML element of choice and bold its text nodes. It seemed easy, but it needs knowledge of some of the fundamentals of React, a thing I never really dived in until now. It's funny I just kept using it minimally. Only now, when I'm working on something of my own for long in React, I've started to learn the better nuances of React. Okay let's go with the component now.

Following are the strings that I wanted to wrap in a span whose fontWeight is bold. 

```javascript
const labelStrings = new Set([
  "Twitter Handle",
  "Facebook Profile",
  "Website",
  "Linkedin ID",
  "Roll No",
  "Branch",
  "Graduating Year",
  "Degree Type",
  "Company Or University",
  "Bio"
])
```

Normally it's preferrable that you keep your react components in separate modules / files. But in this usecase, in order to be able to make the render method cleaner I made a namespace to store all these similar react components (_basically bolded spans_).

```javascript
const LabelComponents = {}; // namespace
```

Now since I'm wanting a span (and this could be made more generic by passing the type of HTML element in the props itself), I'm wrapping it in a glamorous higher order component (which is just wrapping the bare span tag with `fontWeight` style), I'm taking a `text` prop for the textNode of the span, and I'm just returning the styled span. No biggie, all basics.

```javascript
const BoldSpanComponent = ({text, fontWeight}) => {
  const StyledSpan = glamorous.span({
    fontWeight: fontWeight
  })
  return (
    <StyledSpan>{text}: </StyledSpan>
  )
}
```

Now I'll loop over the set of strings in the set and return a BoldSpan for each of them and make them sit in a component in the namespace, like so:

```javascript
for (let label of labelStrings) {
  const noSpaceLabel = label.replace(/\s/g,''); // remove the white spaces in the string
  LabelComponents[noSpaceLabel] = () => {
    return <BoldSpanComponent text={label} fontWeight="bold" />
  }
}
```

you can read more on what is `\s` in regex [here](http://www.regular-expressions.info/shorthand.html).

And now I'm simply using all of them like so:

```javascript
<ul>
      {user.twitterUsername ? 
        <li>
          <LabelComponents.TwitterHandle />
          <a href={"http://twitter.com/" + user.twitterUsername}>@{user.twitterUsername}</a>
        </li> : null }

      {user.services.fbProfileLink ? 
        <li> 
          <LabelComponents.FacebookProfile />
          <a href={user.services.fbProfileLink}>FB Profile Link</a>
        </li> : null}

      {user.website ? 
        <li>
          <LabelComponents.Website />
          <a href={user.website}>{user.website}</a>
        </li> : null }

      <li>
        <LabelComponents.LinkedinID />
        <a href={user.linkedinId}>{user.linkedinId}</a>
      </li>

      <li>
        <LabelComponents.RollNo />
        {user.rollNoOrRegNo}
      </li>

      <li>
        <LabelComponents.Branch />
        {user.branch}
      </li>

      <li>
        <LabelComponents.GraduatingYear />
        {user.classOf}
      </li>

      <li>
        <LabelComponents.DegreeType />
        {user.levelOfDegree}
      </li>

      <li>
         <LabelComponents.CompanyOrUniversity />
        {user.currentUniCompOccu}
      </li>
    </ul>
```
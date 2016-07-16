---
title: Dependent Yeoman Prompts
date: "2016-05-21"
layout: post
path: "/blog/dependent-yeoman-prompts/"
readPrevious: "/blog/my-first-talk/"
total_time: Around 20 minutes
highlight: true
---

In my current project (at the point of writing this blogpost), there was a requirement that I struggled with for 3 days (not all of the time of course, only the time I spent in the office and home trying to solve it).

**THE REQUIREMENT**: was to ask the user for a URL in the first yeoman input prompt (yeoman uses [Inquirer.js](https://github.com/SBoudrias/Inquirer.js/) internally), then make an http get request which returned a JSON, extract an array from a property in it, and then pass it to next checkbox prompt which takes an array of strings in its *choices* property to reflect as command line checkboxes for the user to choose from.

If you know about yeoman, you know that there's something called [*running context*](http://yeoman.io/authoring/running-context.html), which is basically yeoman saying : "*I'm going to run these 10 methods in sequence, no matter what!* ".

So I guess, no betting there, the problem I faced was with this run context:

**THE PROBLEM**: Because of the automatic running context, if I used any of the methods like *filter, validate* of the prompts object(can't use *when* or *choices* because they don't take the user input as the parameter, rather they take in the previous prompts' answers hash) passed to the ```this.prompt``` yeoman method, as an array of many such prompts, to make the http request; the next prompt would be fired before the response came from http get request. This pretty much screwed with my requirement, since **I wanted the response from the http request to feed the choices array in the next checkbox prompt!**

Thankfully this great guy named [Bindu Wavell](https://github.com/binduwavell) gave me a possible solution instantly. He said and I'm quoting from the gitter chat :

> “@**gdad-s-river** a bunch of the prompt options can be functions. These can return a promise. Depending on what you want to do with the HTTP request, you can place it in a function on: when, default, choices, validate, filter...

> Say you want to use the answer from one prompt to fetch a choice post for the second prompt. You'd place your HTTP call in the choices function of the second prompt entry."

I was overwhelmed by this [poorly documented page](http://yeoman.io/authoring/user-interactions.html) (for a beginner that is, please don't judge me). Poorly documented in the sense that a beginner wouldn't know how to not use ```this.async()``` and use promises instead (which I struggled with). I first tried to do something with snippet given in the documentation, which showed that the ```this.prompt``` function returns a promise.

{% highlight javascript %}
module.exports = generators.Base.extend({
  prompting: function () {
    return this.prompt([{
      type    : 'input',
      name    : 'name',
      message : 'Your project name',
      default : this.appname // Default to current folder name
    }, {
      type    : 'confirm',
      name    : 'cool',
      message : 'Would you like to enable the Cool feature?'
    }]).then(function (answers) {
      this.log('app name', answers.name);
      this.log('cool feature', answers.cool);
    }.bind(this));
  }
})
{% endhighlight %}

I thought this was the promise (that ```this.prompt``` method/function returns) that Bindu was suggesting me to do something with (which was by far one of the biggest unreasonable assumptions I've ever made). I made this assumptions because

1. I didn't know that the prompts object, that we pass to ```this.prompt``` function, had some methods options like **filter**, **when**, **validate**, etc in it as well.
2. I didn't know what promises could do that callbacks couldn't.

I was silly enough to ask the community if there was a way to make an http call synchronously in node (true story, how silly is that!).

I thought I was doing something wrong in the http get request syntax in node, but I wasn't. The problem was that I wasn't being able to return the choices array extracted from the JSON response, to the choices method of the checkbox prompt from inside the http get callback function (I don't that's even possible).

**Promises to the rescue**: That's where the promises came to the rescue.

```javascript
var generators = require('yeoman-generator'),
    http = require('http');

module.exports = generators.Base.extend({
  constructor(){
    generators.Base.apply(this, arguments);
  },

  prompting(){
    this.prompt([{
      type: 'input',
      name: 'url',
      message: 'enter url',
      default: "http://api.myjson.com/bins/4b83a"
    }, {
      type: 'checkbox',
      name: 'components',
      message: 'select components',
      choices: (answers) => {
        let url = answers.url;

        let httpGet = (url) => {
          return new Promise((resolve, reject) => {
            http.get(url, (res) => {
              res.on('data', (chunk) = >{
                data = JSON.parse(chunk);
                resolve(data);
              })
            }).on('error', (err) => {
              reject(Error(e.message));
            }); //end of http get
          }); // end of promise
        }; //end of httpGet function

        /*
          This being able to return the resolved value and then
          being able to return the promise is something that callbacks
          can never do.
        */
        return httpGet(url).then((data) => {
          return data.componentsList;
        }).catch((err) => {
          console.log(Error(err.message));
        }); // end of thenable of promise
      }; // end of choices funcion
    }]); // end of this.prompts
  }, // end of prompting function
}); // end of extend

```
Because Promises are *__returnable__* and *__chainable__* (unlike callbacks)
I won't go into how promises work (because I want you to read about promises if you don't haven't yet read about them).

**Promises Learning Resources**(in sequence):
1. [Jake Archibald's funny way of explaining things (here, promises)](http://www.html5rocks.com/en/tutorials/es6/promises/)
2. [Promises MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)

If you have any questions regarding promises or this blog post, please don't comment (Because I don't have comments support on my blog yet (as you can see)). Til I have figured that out, [Tweet me](https://twitter.com/gdad_s_river).

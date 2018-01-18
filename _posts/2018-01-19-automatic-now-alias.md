---
title: "Automatic Now Deployment Aliasing"
date: "2018-01-18"
layout: post
permalink: "/blog/automatic-now-aliasing"
tag: "now, deployment"
---

The following script automates [this](https://zeit.co/docs/features/aliases), namely aliasing the weird unique identifier number in the free domain link that `now` gives you.

in your `package.json`

```json
"scripts": {
   "removeweirdno": "./gscripts/nowalias.js"
},
"bin": {
  "nowalias": "bin/gscripts/nowalias.js"
},
"devDependencies": {
  "copy-paste": "<your version>",
  "shelljs": "<your version>",
  "chalk": "<your version>"
}
```

`gscripts` is a folder that I made for convenience. Basically `nowalias.js` can be anywhere you want to keep.

if this `bin` thingy doesn't help you run `yarn removeweirdno` or `npm run removeweirdno` then make your script executable manually (which is not a good idea for class platform project sharing, but okay, it can be given in the instructions), like so:

`chmod u+x ./gscripts/nowalias.js`

Now in the actual `nowalias.js`

```javascript
#!/usr/bin/env node

const clipboard = require("copy-paste");
const shell = require("shelljs");
const chalk = require("chalk");

const copied = clipboard.paste();

if (!copied.includes("now.sh")) {
  throw new Error(chalk.red("fish! clipboard doesn't contain a now.sh link!"));
}

const command = `now alias ${copied} poetry-editor`;

shell.exec(command);
```

## What's happening?

`copy-paste` is a wrapper over cross platform system level clipboard utilities. We need this because as soon as you run `now --name <your project name>` it copies the link with the unique identifier. So for my project `poetry-editor` when I deploy with `now`, I get something like `poetry-editor-uihqjtoxue.now.sh`, which gets copied in the clipboard. But I'd want it to be aliased to `poetry-editor.now.sh`.

The alias capability let us do something like

`now alias poetry-editor-uihqjtoxue.now.sh poetry-editor`

which now aliases this ugly link to the prettier `poetry-editor.now.sh`. But putting that unique identifier link into this command would otherwise be manual.

We use `copy-paste` clipboard utility to access the copied ugly link and use `shelljs` to run the unix command (`now alias ...`) inside our `nowalias.js` file and voila! It happens automatically. If clipboard doesn't contain `now.sh` link, it throws and error and exits.

See the code again it'll make more sense.

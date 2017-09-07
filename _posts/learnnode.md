Problems I ran into : 


E11000 duplicate key error collection: learnnode.users index: username_1 dup key: { : null } (if console logged inside `mongoose-mongodb-errors/lib/plugin.js`). 

Actual error: 

```
/Users/gdad-s-river/Documents/code/github/Learn-Node/starter-files/node_modules/mongoose/node_modules/mongodb/lib/utils.js:98
[💻]     process.nextTick(function() { throw err; });
[💻]                                   ^
[💻]
[💻] TypeError: Cannot read property '1' of null
[💻]     at model.mongodbErrorHandler (/Users/gdad-s-river/Documents/code/github/Learn-Node/starter-files/node_modules/mongoose-mongodb-errors/lib/plugin.js:21:49)
... blalala
```

What helped: 
https://stackoverflow.com/questions/38347186/mongoose-caused-by-11000-e11000-duplicate-key-error-index
db.users.dropIndex("username_1")

I still have no idea what is making this happen.

XSS Attack demo! Didn't know about that before, super cool!

---
addFields instead of addField
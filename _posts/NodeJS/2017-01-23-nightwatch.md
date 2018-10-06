---
layout: post
title: "nightwatch"
date: 2017-01-23 00:43:16 +0800
comments: true
categories: 

---

## package.json

```
{
  "name": "admin-tool",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "engines": {
    "node": ">=6.9.1",
    "npm": "~3.10.9"
  },
  "scripts": {
    "start": "node app.js",
    "test": "./node_modules/.bin/nightwatch --env local",
    "postinstall": "./node_modules/bower/bin/bower install; node nightwatch.conf.js"
  },
  "author": "tcscoder",
  "license": "ISC",
  "dependencies": {
    "nightwatch": "*",
    "selenium-download": "*",
  }
}
```

## login.js

```
var conf = require('../nightwatch.conf.js')

module.exports = {
    'test login': function(browser) {
        browser
            .url('localhost:3000/admin/login.html')
            .waitForElementVisible('body');
        browser
            .element('css selector', '.nav .navbar-nav .navbar-right', function(result){
                if (result.status != -1) {
                    brower.click('.nav .navbar-nav .navbar-right')
                    .waitForElementVisible('body');
                }
            })
        browser
            .setValue('input[type=text]', 'admin')
            .setValue('input[type=password]', 'admin')
            .click('button[id=sign-in]')
            .pause(1000)
            .assert.containsText('body', 'Search')
            .end();
    }
}
```

## search.js

```
var conf = require('../nightwatch.conf.js')

module.exports = {
    'test search': function(browser) {
        browser
            .url('localhost:3000/admin/')
            .waitForElementVisible('body');
        browser
            .element('css selector', '.nav .navbar-nav .navbar-right', function(result){
                if (result.status == -1) {
                    browser
                        .setValue('input[type=text]', 'admin')
                        .setValue('input[type=password]', 'admin')
                        .click('button[id=sign-in]')
                        .pause(1000);
                }
            })
        browser
            .setValue('input[type=text]', 'user1')
            .pause(1000)
            .assert.containsText('table[id=entities-table]', 'user1')
            .end();
    }
}
```

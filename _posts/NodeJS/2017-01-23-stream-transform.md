---
layout: post
title: "stream-transform"
date: 2017-01-23 00:27:37 +0800
comments: true
categories: 

---

```
const parse = require('csv-parse');
const transform = require('stream-transform');
const streamify = require('stream-array')

var length = 0 
var count = 0

const parser = parse({delimiter: ','}, function(err, data){
    console.log(data);
    length = data.length;
    count = 0;
    streamify(data).pipe(transformer)//.pipe(res);
});

const transformer = transform(function(record, callback){
  const variables = {
    token: req.headers['x-authtoken'],
    storeId: record[0],
    store: {
      storeAddressLine1: record[1],
      storeAddressLine2: record[2],
      storeZipCode: record[3],
      storeCity: record[4],
      storeState: record[5]
    }
  };
  runGraphQl(schema, query, variables, callback, res)
}, {parallel: 10});

input.pipe(parser);

function runGraphQl(schema, query, variables, callback, res) {
  graphql(schema, query, {},{}, variables)
    .then(function (result) {
      
      count += 1;
      
      if (count == length) {
        s = "hi, there.";
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(s);
      }
      callback(null, r);
    })
}
```

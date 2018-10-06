---
layout: post
title: "JavaScript"
date: 2016-06-14 20:19:49 +0800
comments: true
categories: JavaScript

---

```
(function() { /* code */ })()
(function () { /* code */ } ()); 
!function () { /* code */ } ();
~function () { /* code */ } ();
-function () { /* code */ } ();
+function () { /* code */ } ();
```

## ===

```
"abc" == new String("abc")    // true
"abc" === new String("abc")   // false
```

```
!! // Boolean() 
```

## bind

The `bind()` method creates a new function that, when called, has its this keyword set to the provided value, with a given sequence of arguments preceding any provided when the new function is called.

* `call()` takes the function arguments separately 
* `apply()` takes the function arguments in an array

Both methods takes an owner object as the first argument.

## callback

```
if (callbacks) {
    callbacks.forEach(function (callback) {
        callback(data);
    });
}
```

## prototype

The JavaScript prototype property also allows you to add new methods to an existing prototype.

```
Tile.prototype.savePosition = function () {
  this.previousPosition = { x: this.x, y: this.y };
};
```

---

## forEach

The `forEach()` method calls a provided function once for each element in an array, in order.

```
array.forEach(function(currentValue,index,arr), thisValue)
```

## reverse

```
var fruits = ["Banana", "Orange", "Apple", "Mango"];
fruits.reverse(); 
```

## setTimeout

```
function openWin() {
    var myWindow = window.open("", "myWindow", "width=200, height=100");
    myWindow.document.write("<p>This is 'myWindow'</p>");
    setTimeout(function(){ myWindow.close() }, 3000);
}
```
```
var myVar;
function myFunction() {
    myVar = setTimeout(function(){ alert("Hello") }, 3000);
}
function myStopFunction() {
    clearTimeout(myVar);
}
```

## splice

The `splice()` method adds/removes items to/from an array, and returns the removed item(s).

```
arrayObject.splice(index,howmany,item1,.....,itemX)
```

---

## addEventListener

```
element.addEventListener(event, function, useCapture);
```

* bubbling(false): the inner most element's event is handled first and then the outer
* capturing(true): the outer most element's event is handled first and then the inner

## classList

The `classList` property is read-only, however, you can modify it by using the `add()` and `remove()` methods.

This property is useful to add, remove and toggle CSS classes on an element.

## Object.defineProperty

The `Object.defineProperty()` method defines a new property directly on an object, or modifies an existing property on an object, and returns the object.

```
Object.defineProperty(obj, prop, descriptor)
```

## preventDefault

The `preventDefault()` method cancels the event if it is cancelable, meaning that the default action that belongs to the event will not occur.

## setAttribute

If the specified attribute already exists, only the value is set/changed.

```
// Get the <a> element with id="myAnchor"
var x = document.getElementById("myAnchor"); 

// If the <a> element has a target attribute, set the value to "_self"
if (x.hasAttribute("target")) {      
    x.setAttribute("target", "_self");
}
``` 

## textContent

The textContent property sets or returns the textual content of the specified node, and all its descendants.

If you set the textContent property, any child nodes are removed and replaced by a single Text node containing the specified string.

```
function myFunction()
{
    var c=document.getElementsByTagName("BUTTON")[0];
    var x=document.getElementById("demo");  
    x.innerHTML=c.textContent;
}
```

---

## document

The document object is the root node of the HTML document and the "owner" of all other nodes.

### documentElement

The `Document.documentElement` read-only property returns the Element that is the root element of the document (for example, the `<html>` element for HTML documents).

```
var rootElement = document.documentElement;
var firstTier = rootElement.childNodes;

// firstTier is the NodeList of the direct children of the root element
for (var i = 0; i < firstTier.length; i++) {
   // do something with each direct kid of the root element
   // as firstTier[i]
}
```
### createElement

```
function myFunction() {
    var btn = document.createElement("BUTTON");
    var t = document.createTextNode("CLICK ME");
    btn.appendChild(t);
    document.body.appendChild(btn);
}
```

### querySelector

Visit CSS Selector [Reference](http://www.w3schools.com/cssref/css_selectors.asp).

Get the first `<p>` element in the document with class="example":
```
document.querySelector("p.example");
```

---

## window

### cancelAnimationFrame

Cancels an animation frame request previously scheduled through a call to `window.requestAnimationFrame()`.

### localStorage

Unlike cookies, the storage limit is far larger (at least 5MB) and information is never transferred to the server.

Local storage is per origin (per domain and protocol). All pages, from one origin, can store and access the same data.

* window.localStorage - stores data with no expiration date
* window.sessionStorage - stores data for one session (data is lost when the browser tab is closed)

```
LocalStorageManager.prototype.localStorageSupported = function () {
  var testKey = "test";
  var storage = window.localStorage;

  try {
    storage.setItem(testKey, "1");
    storage.removeItem(testKey);
    return true;
  } catch (error) {
    return false;
  }
};
```

### navigator.msPointerEnabled

BOM: Browser Object Model.

The window object is supported by all browsers. It represents the browser's window.

The `MSPointer` class handles Microsoft touch interactions with the game and the resulting Pointer objects.

It will work only in Internet Explorer 10+ and Windows Store or Windows Phone 8 apps using JavaScript.

### requestAnimationFrame

```
requestID = window.requestAnimationFrame(callback); // Firefox 23 / IE10 / Chrome / Safari 7 (incl. iOS)
requestID = window.mozRequestAnimationFrame(callback); // Firefox < 23
requestID = window.webkitRequestAnimationFrame(callback); // Older versions Chrome/Webkit
```

The callback has one single argument, a `DOMHighResTimeStamp`, which indicates the current time (the time returned from `Performance.now()` ) for when `requestAnimationFrame` starts to fire callbacks.

---

## JSON

JSON: JavaScript Object Notation.

```
LocalStorageManager.prototype.getGameState = function () {
  var stateJSON = this.storage.getItem(this.gameStateKey);
  return stateJSON ? JSON.parse(stateJSON) : null;
};

LocalStorageManager.prototype.setGameState = function (gameState) {
  this.storage.setItem(this.gameStateKey, JSON.stringify(gameState));
};
```
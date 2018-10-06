---
layout: post
title: "Bootstrap"
date: 2016-11-16 20:44:24 +0800
comments: true
categories: css

---

## start

[w3schools](http://www.w3schools.com/bootstrap/default.asp).

```
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
```

```
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <h1>My First Bootstrap Page</h1>
  <p>This is some text.</p>
</div>

</body>
</html>
```

---

## fonts

* eot: Embedded Open Type
* svg: Scalable Vector Graphics
* woff: Web Open Font Format
* ttf: TrueType
* otf: OpenType

## scss

* haml: HTML Abstract Markup Language.
* sass: Syntactically Awesome Stylesheets.
* scss: Sass 3, Sassy CSS.

```
gem install sass
sass main.scss main.css
```

## css

css: Cascading Style Sheets

In CSS, selectors [here](http://www.w3schools.com/cssref/css_selectors.asp) are patterns used to select the element(s) you want to style.

* .class: .intro(Selects all elements with class="intro")
* \#id: \#firstname(Selects the element with id="firstname")
* element,element: div, p(Selects all `<div>` elements and all `<p>` elements)
* element element: div p(Selects all `<p>` elements inside `<div>` elements)
* ::after: p::after(Insert something after the content of each `<p>` element)

WebKit [here](https://developer.mozilla.org/en-US/docs/Web/CSS/WebKit_Extensions) supports a number of extensions to CSS that are prefixed with `-webkit`. 

The `@media` rule is used to define different style rules for different media types/devices.

```
 <style>
body {
    background-color: lightblue;
}

@media screen and (min-width: 480px) {
    body {
        background-color: lightgreen;
    }
}
 </style>
```

---

## background-image

`style/main.css`

```
.tile.tile-2 .tile-inner {background-image: url(../images/tile-2.png)}
@media screen and (max-width: 520px) {.tile.tile-2 .tile-inner {background-size: 58px 58px}}
```

`js/html_actuator.js`

```
//inner.textContent = tile.value;
```

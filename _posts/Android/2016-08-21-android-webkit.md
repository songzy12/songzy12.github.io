---
layout: post
title: "Android Webkit"
date: 2016-08-21 20:07:03 +0800
comments: true
categories: Android

---

## WebView

```
WebView mWebView = (WebView) findViewById(R.id.mainWebView);
WebSettings settings = mWebView.getSettings();
settings.setJavaScriptEnabled(true);
settings.setDomStorageEnabled(true);
settings.setDatabaseEnabled(true);
```

```
mWebView.loadUrl("file:///" + getFilesDir().getAbsolutePath() + "/" + filename);
```
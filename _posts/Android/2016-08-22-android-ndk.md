---
layout: post
title: "Android NDK"
date: 2016-08-22 20:07:03 +0800
comments: true
categories: Android

---

## Android.mk

[Here](http://android.mk/).

```
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := hello-jni
LOCAL_SRC_FILES := hello-jni.c

include $(BUILD_SHARED_LIBRARY)
```

The `BUILD_SHARED_LIBRARY` is a variable provided by the build system that points to a GNU Makefile script that is in charge of collecting all the information you defined in `LOCAL_XXX` variables since the latest `include $(CLEAR_VARS)` and determine what to build, and how to do it exactly. There is also `BUILD_STATIC_LIBRARY` to generate a static library.

## AndroidManifest

### installLocation

- `internalOnly`
- `auto`
- `preferExternal`

### label/description

* The actual app label is set as the one in `<application android:label>`. If not set, then package name.
* The activity title is set as the one in `<activity android：label>`. If not set, then app label.
* The shortcut label is set as the one in main activity `<activity android：label>`. If not set, then app label.

But what if I want the shortcut label to be the same as app label, but different from the main activity title?

It seems that the `<intent-filter android:label>` is of no use in Android 4.4.

### name

* If the name starts with a dot, always prefix it with the package.
* If the name has a dot anywhere else, do not prefix it.
* If the name has no dot at all, also prefix it with the package.

### lauchMode

* standard
* singleTop
* singleTask
* singleInstance

### screenOrientation

* landscape
* portrait

### intent-filter

Declares the intent action accepted, in the `name` attribute.

```
android.intent.action.MAIN
```

Declares the intent category accepted, in the `name` attribute.

```
android.intent.category.LAUNCHER
```

### uses-permission

* `<uses-permission>`: Requests a permission that the application must be granted in order for it to operate correctly.
* `<permission>`: Declares a security permission that can be used to limit access to specific components or features of this or other applications. 

```
<uses-permission android:name="android.permission.INTERNET"/>
```

### uses-sdk

`Android 4.4W` extends support for `Wearables`.

```
Unable to resolve target 'android-19'
```

* `project.properties`: `target=android-20`.
* `AndroidManifest.xml`: `android:targetSdkVersion="20"` 

Then `clean` and `run`.
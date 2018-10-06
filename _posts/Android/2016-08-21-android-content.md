---
layout: post
title: "Android Content"
date: 2016-08-21 20:07:03 +0800
comments: true
categories: Android

---

## Context

Where?
* when creating views, adapters and Toast messages.
* when accessing System Services(`LayoutInflater`, `InputMethodManager`).
* when accessing components(Content Resolver).

Two types of Context:
* Application context: `getApplicationContext()`, `getApplication()`
    * to display a Toast message.
    * to access settings and resources shared across.  multiple activity instances
    * if you need a context with global scope.
* Activity context: `this`, `getBaseContext()`, `getActivity()`

```
FileOutputStream fout = openFileOutput(filename, MODE_PRIVATE);
byte[]  bytes = message.getBytes();
fout.write(bytes);
fout.close();
```

```
Log.i(TAG, getFilesDir().getAbsolutePath() + "/");
```

`/data/data/` 为系统内部存储文件路径，`/data/data/<package name>/`，所有内部存储中保存的文件在用户卸载应用的时候会被删除。

* `Context.getFilesDir()`: 返回 `/data/data/<package name>/files` 的 `File` 对象。
* `Context.openFileInput()`, `Context.openFileOutput()`，只能读取和写入 `files` 下的文件，返回的是 `FileInputStream` 和`FileOutputStream` 对象。
* `Context.fileList()`，返回 `files` 下所有的文件名，返回的是 `String[]` 对象。
* `Context.deleteFile(String)`，删除 `files` 下指定名称的文件。 
* `Context.getCacheDir()`，该方法返回 `/data/data/<package name>/cache` 的 `File` 对象。
* `getDir(String name, int mode)`，返回 `/data/data/<package name>/` 下的指定名称的文件夹 `File` 对象，如果该文件夹不存在则用指定名称创建一个新的文件夹。 

## Intents

```
Intent intent =  new Intent(); 
intent.setClass(PaintPadActivity.this, TextActivity.class);
startActivityForResult(intent, PaintPadActivity.WHAT_TO_WRITE);
```

```
Bundle bundle = new Bundle();
bundle.putString("font", "lingxin.ttf");
Intent data = getIntent();
data.putExtras(bundle);
TextActivity.this.setResult(WHAT_TO_WRITE, data);
TextActivity.this.finish();
```

```
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
	super.onActivityResult(requestCode, resultCode, data);
	switch (requestCode) {
		case WHAT_TO_WRITE:
            //
            break;
	}
}
```

## PackageManager

```
PackageManager pm = context.getPackageManager();
PackageInfo pi = pm.getPackageInfo(context.getPackageName(), 0);
version = pi.versionName;
```

## SharedPreference

```
Context.getSharedPreferences(String name, int mode)
PreferenceManager.getDefaultSharedPreferences(Context);
```
* name: `/data/data/<package name>/shared_prefs`
* mode: Context.MODE_PRIVATE, Context.MODE_WORLD_READABLE, Context.MODE_WORLD_WRITEABLE

`preferences.xml`.
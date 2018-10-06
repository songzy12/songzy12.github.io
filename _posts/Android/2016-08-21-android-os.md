---
layout: post
title: "Android OS"
date: 2016-08-21 20:07:03 +0800
comments: true
categories: Android

---

## External Storage

```
String state = Environment.getExternalStorageState();

if (Environment.MEDIA_MOUNTED.equals(state)) {
	// save to sd card
} else if (Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)) {
    // read only
} else {
    // not avaliable
}
```

```
File sdcard_path = Environment.getExternalStorageDirectory();
// sdcard_path.toString() == "/storage/emulated/0";
String myFloder = getResources().getString(folder_name);
File paintpad = new File(sdcard_path + "/" + myFloder + "/");
try {
	if (!paintpad.exists())	{
		// Note that this method does not throw IOException on failure.
		paintpad.mkdirs();
	}
} catch (Exception e) {
	e.printStackTrace();
}
```

```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"></uses-permission> 
```

## Handler

```
class MyHandler extends Handler {
    public void handleMessage(Message msg) {
    	Bundle bundle = msg.getData();
    	Date date = new Date();
    	textView.append((new SimpleDateFormat("hh:mm:ss")).format(date) +
    			        "    "+ bundle.getString("msg") + "\n");
    }
}   
```

```
Handler.sendEmptyMessageDelayed(int what, long delayMillis)
```

```
Handler handler = new Handler();
handler.post(new Runnable() {
	public void run() {	    
		Log.i(TAG, getFilesDir().getAbsolutePath() + "/" + filename);
		// Log.i(TAG, Environment.getExternalStorageDirectory()+"");
		webView.loadUrl("file:///" + getFilesDir().getAbsolutePath() + "/" + filename);
		swipeContainer.setRefreshing(false);
	}
});
```

## Message

```
Message msg = new Message();
Bundle bundle = new Bundle();
bundle.putString("msg", "Connection failed!\n");
msg.setData(bundle);
myHandler.sendMessage(msg);
```
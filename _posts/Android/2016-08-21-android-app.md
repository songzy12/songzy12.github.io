---
layout: post
title: "Android App"
date: 2016-08-21 20:07:03 +0800
comments: true
categories: Android

---

## appcompat_v7

SDK < 4.0

## Activity

[Here](http://developer.android.com/intl/zh-cn/reference/android/app/Activity.html)

```
@Override
protected void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
						 WindowManager.LayoutParams.FLAG_FULLSCREEN);        
	setContentView(R.layout.activity_main);
}
```

## PendingIntent

```
Intent intent = new Intent(MainActivity.this, TargetActivity.class);     
intent.putExtra("value", System.currentTimeMillis());
PendingIntent pendingIntent = PendingIntent.getActivity(
    MainActivity.this, 0, intent,
    PendingIntent.FLAG_UPDATE_CURRENT
); //Context context, int requestCode, Intent intent, int flags
Notification notification = new Notification(R.drawable.ic_launcher, "notification", System.currentTimeMillis());  
notification.setLatestEventInfo(MainActivity.this, "TestPendingIntent", "Testing...", pendingIntent);  
NotificationManager notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);  
notificationManager.notify(0, notification);  
```
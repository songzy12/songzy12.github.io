---
layout: post
title: "Android Util"
date: 2016-08-21 20:07:03 +0800
comments: true
categories: Android

---

## DisplayMetrics

```
DisplayMetrics dm = new DisplayMetrics();
getWindowManager().getDefaultDisplay().getMetrics(dm);
System.out.println(dm.widthPixels);
```

* px: pixel
* dip: device independent pixels
* sp: scaled pixels
* dpi: dot per inch
* pt: point, 1 pt = 1/72 inch
* sp: scaled pixels


```
px = dip * density / 160
```

```
public class DensityUtil {  
    public static int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }  
    public static int px2dip(Context context, float pxValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (pxValue / scale + 0.5f);
    }
}
```

## Log

```
static final String TAG = getClass().getName();
Log.i(TAG, "info");
```
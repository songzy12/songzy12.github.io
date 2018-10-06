---
layout: post
title: "Android Graphics"
date: 2016-06-22 20:07:03 +0800
comments: true
categories: Android

---

## Bitmap

```
Bitmap bitmap=BitmapFactory.decodeResource(getResources(), R.drawable.green);
bitmap=Bitmap.createBitmap(bitmap,0,0,bitmap.getWidth(),bitmap.getHeight(),matrix,true);
// Bitmap source, int x, int y, int width, int height, Matrix m, boolean filter
// Rect: (x,y) (width, height); filter: bilinear interpolation
```

* upsize: bilinear or bicubic interpolation
* downsize: area averaging

```
String fullPath = sdcard_path + "/" + myFloder + "/" + timeStamp + suffixName;
try {
	bitmap.compress(Bitmap.CompressFormat.PNG, 100, new FileOutputStream(fullPath));
} catch (FileNotFoundException e) {
	e.printStackTrace();
}
```

## Canvas

```
drawCircle(float cx, float cy, float radius,Paint paint)
drawArc(RectF oval, float startAngle, float sweepAngle, boolean useCenter, Paint paint)
drawBitmap(Bitmap bitmap, Rect src, Rect dst, Paint paint)
```

```
Canvas canvas;
if (rotation != 0)
	canvas.rotate(-rotation, x, y);
canvas.drawText(PaintPadActivity.text, x, y, Brush.getPen());
if (rotation != 0)
	canvas.rotate(rotation, x, y);
```

## Matrix

```
Matrix matrix=new Matrix();
matrix.setRotate(degree, px, py); // rotate degree centered at (px, py)
matrix.postScale(sx, sy); // scale center at (0, 0) 
```

## Shader

```
Shader s = new SweepGradient(0, 0, mColors, null);
// mPaint.setShader(new SweepGradient(screenX, screenY, Color.RED, Color.YELLOW)); 
mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
mPaint.setShader(s);
Canvas canvas;
canvas.drawOval(new RectF(-r, -r, r, r), mPaint);
```
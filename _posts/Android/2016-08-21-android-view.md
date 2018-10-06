---
layout: post
title: "Android View"
date: 2016-06-22 20:07:03 +0800
comments: true
categories: Android

---

## onClickListener

### Inline
```
findViewById(R.id.button1).setOnClickListener( new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        Toast.makeText(this, "Button1 clicked.", Toast.LENGTH_SHORT).show();  
    }
});
```

### Private variable

```
findViewById(R.id.button1).setOnClickListener(mGlobal_OnClickListener);
findViewById(R.id.button2).setOnClickListener(mGlobal_OnClickListener);
     
final OnClickListener mGlobal_OnClickListener = new OnClickListener() {
    public void onClick(final View v) {
        switch(v.getId()) {
            case R.id.button1:
                Toast.makeText(this, "Button1 clicked.", Toast.LENGTH_SHORT).show();                
            break;
            case R.id.button2:
                Toast.makeText(this, "Button2 clicked.", Toast.LENGTH_SHORT).show();                
            break;
        }
    }
};
```

### Xml reference

```
public void button1OnClick(View v) {
    Toast.makeText(this, "Button1 clicked.", Toast.LENGTH_SHORT).show();                
}
```

```
<Button
    android:id="@+id/button1"
    android:onClick="button1OnClick"/>
```

## Display

```
Display display = getWindowManager().getDefaultDisplay();
Point size = new Point();
display.getSize(size);
System.out.println(size.x + " " + size.y);
```

## Menu

```
<menu xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    tools:context="com.example.geekreader.MainActivity" >

    <item android:id="@+id/analysis"
        android:title="@string/analysis"/>	
</menu>
```

```
@Override
public boolean onCreateOptionsMenu(Menu menu) {
    getMenuInflater().inflate(R.menu.main, menu);
    return true;
}

@Override
public boolean onOptionsItemSelected(MenuItem item) {
    switch (item.getItemId()) {
	    case R.id.analysis:
	        CATEGORY_URL = "analysis/";
	        break;
	    default:
	        break;
    }
    return super.onOptionsItemSelected(item);
}
```
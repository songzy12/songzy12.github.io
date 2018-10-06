---
layout: post
title: "Android Widget"
date: 2016-08-21 20:07:03 +0800
comments: true
categories: Android

---

## EditText

```
editText.addTextChangedListener(new TextWatcher() {
@Override
public void onTextChanged(CharSequence charSequence, int start, int before, int count) {
    // Only handle addition of characters
    if(count > before) {
        // Write the last entered character to the pipe
        String s = charSequence.subSequence(before, count).toString();
    }
}
```

## ImageView

scaleType:

* center
* fitCenter

### setLayoutParams

```
img.setLayoutParams(new LinearLayout.LayoutParams(newWidth,newHeight))
```

### setImageBitmap

```
Bitmap bitmap = BitmapFactory.decodeResource(getResources(), R.drawable.picture);
img.setImageBitmap(bitmap);

public void setImageBitmap(Bitmap bm) {
// if this is used frequently, mayhandle bitmaps explicitly
// to reduce the intermediate drawable object
    setImageDrawable(newBitmapDrawable(mContext.getResources(), bm));
}
```

### getParent

```
ImageView img = mImages[i][j];
LinearLayout pa = (LinearLayout) img.getParent();
pa.removeView(img);
```

## LinearLayout

```
LinearLayout linralayout = new LinearLayout(context);
linralayout.setOrientation(LinearLayout.VERTICAL);
linralayout.setPadding(0, 0, 0, 0); // setPadding(left, top, right, bottom);
this.addView(linralayout);
```

* content: The content of the box, where text and images appear
* padding: Clears an area around the content. The padding is transparent
* border: A border that goes around the padding and content
* margin: Clears an area outside the border. The margin is transparent

## RadioGroup

```
RadioGroup style=(RadioGroup) findViewById(R.id.style);
RadioButton lingxin=(RadioButton) findViewById(R.id.lingxin);
style.setOnCheckedChangeListener( new OnCheckedChangeListener(){
	public void onCheckedChanged(RadioGroup group, int checkedId) {
		if(lingxin.getId() == checkedId){
        //
		}
    }
}
```

## ScrollView

```
<android.support.v4.widget.SwipeRefreshLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/swipeContainer"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    
    <WebView android:id="@+id/webView"
        android:layout_width="wrap_content"
	    android:layout_height="wrap_content" />
</android.support.v4.widget.SwipeRefreshLayout>
```

```
int offset = textView.getMeasuredHeight()
        - scrollView.getMeasuredHeight();
if (offset < 0) {
    offset = 0;
}
scrollView.scrollTo(0, offset);
```

## SwipeRefreshLayout

```
public class MainActivity extends Activity implements SwipeRefreshLayout.OnRefreshListener {
	private SwipeRefreshLayout swipeContainer;
	@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
        
        swipeContainer = (SwipeRefreshLayout) findViewById(R.id.swipeContainer);
        swipeContainer.setOnRefreshListener(this);  
	}   

	@Override
	public void onRefresh() {
		Log.i(TAG, "refreshing");
		swipeContainer.setRefreshing(false);
	}     
}   
```

## ViewHolder

```
static class ViewHolder {
    public TextView info;
}
@Override
public View getView(int position, View convertView, ViewGroup parent) {
    ViewHolder holder;
    if(convertView == null) {
        holder = new ViewHolder();
        convertView = mInflater.inflate(R.layout.list_item, null);
        holder.info = (TextView)item.findViewById(R.id.info);
        convertView.setTag(holder);
    } else {
        holder = (ViewHolder)convertView.getTag();
        holder.info.setText("World");
    }
    return convertView;
}
```
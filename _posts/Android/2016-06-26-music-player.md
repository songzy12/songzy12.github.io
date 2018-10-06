---
layout: post
title: "Music Player"
date: 2016-06-26 20:00:17 +0800
comments: true
categories: Android

---

[Tutorial](http://www.androidhive.info/2012/03/android-building-audio-player-tutorial/) and [source code](https://github.com/lizhuoli1126/Android-Media-Player).

## 附加功能

### 通知

```
public void notification(){
	mBuilder = new NotificationCompat.Builder(this);
	mBuilder.setAutoCancel(true)//点击后让通知将消失  
			.setOngoing(false)//ture，设置他为一个正在进行的通知。他们通常是用来表示一个后台任务,用户积极参与(如播放音乐)或以某种方式正在等待,因此占用设备(如一个文件下载,同步操作,主动网络连接)
			.setWhen(System.currentTimeMillis())//通知产生的时间，会在通知信息里显示
			.setPriority(Notification.PRIORITY_DEFAULT)//设置该通知优先级
			.setDefaults(Notification.DEFAULT_SOUND)//向通知添加声音、闪灯和振动效果的最简单、最一致的方式是使用当前的用户默认设置，使用defaults属性，可以组合：
			.setContentTitle("Music Player")
			.setContentText("Click to return")
			.setTicker("Click me")
			.setSmallIcon(R.drawable.ic_launcher);
	//点击的意图ACTION是跳转到Intent
	Intent resultIntent = new Intent(this, MainActivity.class);
	resultIntent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
	PendingIntent pendingIntent = PendingIntent.getActivity(this, 0,resultIntent, PendingIntent.FLAG_UPDATE_CURRENT);
	mBuilder.setContentIntent(pendingIntent);
	mNotificationManager.notify(notifyId, mBuilder.build());
}
```

### 播放列表

```
mBtnPlaylist.setOnClickListener(new View.OnClickListener() {
	@Override
	public void onClick(View arg0) {
		Bundle b = new Bundle();
		b.putLongArray("mSongIds", mSongIds);
		Intent i = new Intent(getApplicationContext(), PlayListActivity.class);
		i.putExtras(b);
		startActivityForResult(i, 100);			
	}
});
```

```
Bundle b = getIntent().getExtras();
long[] mySongIds = b.getLongArray("mSongIds");

this.songsList = new ArrayList<HashMap<String, String>>();

for (int i = 0; i < mySongIds.length; i++) {
	// creating new HashMap
	HashMap<String, String> song = new HashMap<String, String>();
	song.put("songTitle", mySongIds[i] + "");
	// adding HashList to ArrayList
	this.songsList.add(song);
}

// Adding menuItems to ListView
ListAdapter adapter = new SimpleAdapter(this, this.songsList,
		R.layout.playlist_item, new String[] { "songTitle" }, new int[] {
				R.id.songTitle });

setListAdapter(adapter);

// selecting single ListView item
ListView lv = getListView();
// listening to single listitem click
lv.setOnItemClickListener(new OnItemClickListener() {

	@Override
	public void onItemClick(AdapterView<?> parent, View view,
			int position, long id) {
		// getting listitem index
		int songIndex = position;
		
		// Starting new intent
		Intent in = new Intent(getApplicationContext(),
				MainActivity.class);
		// Sending songIndex to PlayerActivity
		in.putExtra("songIndex", songIndex);
		setResult(100, in);
		// Closing PlayListView
		finish();
	}
});
```

```
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if(resultCode == 100){
    	currentSongIndex = data.getExtras().getInt("songIndex");
    	mSongId = mSongIds[currentSongIndex];
        play(mSongId);
    }
}
```

### 随机播放

```
private void next() {
	if(isRepeat){
		// repeat is on play same song again
	} else if(isShuffle){
		// shuffle is on - play a random song
		Random rand = new Random();
		currentSongIndex = rand.nextInt((mSongIds.length - 1) - 0 + 1) + 0;
	} else{
		// no repeat or shuffle ON - play next song
		currentSongIndex = (currentSongIndex + 1) % mSongIds.length;
	}
	mSongId = mSongIds[currentSongIndex];
	play(mSongId);
}
```

### 专辑图

3454712, 31655244, 8061609, 114626026, 123772450, 130244125, 38280826, 7348261

```
File sdcardPath = Environment.getExternalStorageDirectory();
// sdcard_path.toString() == "/storage/emulated/0";
String folder = "baidu/music";
File dirPath = new File(sdcardPath + "/" + folder + "/");
if (!dirPath.exists())	
	dirPath.mkdirs();
ImageManager.init(this, ImageManager.POSTFIX_JPG,
	dirPath.toString(), 1 * 1024 * 1024);
```

```
private void loadImage(String title, String artist) {
	LogUtil.i(TAG, "title: " + title + ", artist: " + artist);
    OnlineManagerEngine
            .getInstance(getApplicationContext())
            .getSearchManager(getBaseContext())
            .getLyricPicAsync(getApplicationContext(),
                    title, artist,
                    new LrcPicSearchListener() {
                        @Override
                        public void onGetLrcPicList(LrcPicList list) {
                        	if (list.getErrorCode() == list.OK) {
                                LrcPic lrcPic = (LrcPic) list.getItems()
                                        .get(0);
                                LogUtil.i(TAG, "LrcPic: " + lrcPic.toString());
                                ImageManager.render(lrcPic.getPicBig(),
                                        mayuri, -1, -1, 0, false, false);
                            }
                        }
                    });
}
```

## 基本功能

### 播放

```
private void start() {
    if (isLossless) {
        mStreamPlayer.prepareLossless(mSongId);
    } else {
        mStreamPlayer.prepare(mSongId == 0 ? mSongIds[index] : mSongId,
                TextUtil.isEmpty(mBit) ? "128" : mBit);
    }
    status = PLAYING;
    mBtnPlay.setImageResource(R.drawable.pause);
    setTimer();
}
```

```
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@drawable/img_btn_play_pressed"
        android:state_focused="true"
        android:state_pressed="true" />
    <item android:drawable="@drawable/img_btn_play_pressed"
        android:state_focused="false"
        android:state_pressed="true" />
    <item android:drawable="@drawable/img_btn_play_pressed" 
        	android:state_focused="true" />
    <item android:drawable="@drawable/img_btn_play"
        android:state_focused="false"
        android:state_pressed="false" />
</selector>
```

### 当前播放时长、显示播放总时长

```
private void setTimer() {
    mTimer = new Timer(true);
    TimerTask task = new TimerTask() {
        public void run() {
            mHandler.sendEmptyMessage(REFRESH_POSITION);
        }
    };
    mTimer.scheduleAtFixedRate(task, 0, 1000);    
}

private Handler mHandler = new Handler() {
    @Override
    public void handleMessage(Message msg) {
        switch (msg.what) {
            case REFRESH_POSITION:
                long position = mStreamPlayer.position();
                mPosition.setText(strftime(Math.max(position, 0)));
                mSeekBar.setProgress((int) mStreamPlayer.position());
                break;
            case REFRESH_DURATION:
                mDuration.setText(strftime(mStreamPlayer.duration()));
                break;
            default:
                break;
        }
    }
};

private String strftime(long millisecond) {
	long second = millisecond / 1000;
	long minute = second / 60;
	String time = String.format(Locale.getDefault(), "%02d:%02d", minute, second % 60);
	LogUtil.i(TAG, "millisecond: " + millisecond + ", time: " + time);
	return time;
}
```

### 进度条

```
OnPreparedListener mOnPreparedListener = new OnPreparedListener() {

    @Override
    public void onPrepared() {
        // TODO Auto-generated method stub
        if (mSeekBar != null) {
            mSeekBar.setMax((int) mStreamPlayer.duration());
            mHandler.sendEmptyMessage(REFRESH_DURATION);
			mHandler.sendEmptyMessage(REFRESH_POSITION);
        }
        LogUtil.i(TAG, "onPrepared....");
        // if (status == PLAYING && !mStreamPlayer.isPlaying())
        mStreamPlayer.start();
    }
};
```

### 进度条拖动

```
mSeekBar.setOnSeekBarChangeListener(new OnSeekBarChangeListener() {
    @Override
    public void onProgressChanged(SeekBar arg0, int arg1, boolean arg2) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onStartTrackingTouch(SeekBar seekBar) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onStopTrackingTouch(SeekBar seekBar) {
        // TODO Auto-generated method stub
        int progress = seekBar.getProgress();
        int pos = (int) mStreamPlayer.seek(progress);
        seekBar.setProgress(pos);
        mPosition.setText(strftime(mStreamPlayer.position()));
    }
});
```

### 暂停

```
mBtnPlay.setOnClickListener(new OnClickListener() {
    @Override
    public void onClick(View v) {
        switch (status) {
        	case PLAYING: pause(); break;
        	case PAUSED: resume(); break;
        	default: start(); break;
         }
    }
});
```

```
private void resume() {
    mStreamPlayer.start();
    status = PLAYING;
    mBtnPlay.setImageResource(R.drawable.pause);
}

private void pause() {
    mStreamPlayer.pause();
    status = PAUSED;
    mBtnPlay.setImageResource(R.drawable.play);
}
```

### 下一曲、 上一曲

```    
private void previous() {
    currentSongIndex = (mSongIds.length + currentSongIndex - 1) %  mSongIds.length;
    mSongId = mSongIds[currentSongIndex];
	play(mSongId);
}
```

### 歌曲名、歌手名

null: 254515, 890663, 31387633, 2043518, 2104023, 539896, 2127370
not null: 1262598, 265898, 6172939, 2494343

```
private void setMusicInfo(){
	long musicId = mStreamPlayer.getMusicId();
	String album = mStreamPlayer.getMusicAlbum();
	String artist = mStreamPlayer.getMusicArtist();
	String title = mStreamPlayer.getMusicTitle();
	mTitle.setText(title);
	mMusicId.setText(String.valueOf(musicId));
	mArtist.setText(artist);
	mAlbum.setText(album);
}
```

### 后台可播放

```
android:persistent="true"
```

```
public void onBackPressed(){
	new AlertDialog.Builder(this).setTitle("Run in background?")
    .setIcon(android.R.drawable.ic_dialog_info)
    .setPositiveButton("No", new DialogInterface.OnClickListener() {

        @Override
        public void onClick(DialogInterface dialog, int which) {
            // 点击“确认”后的操作
            MainActivity.this.finish();
        }
    })
    .setNegativeButton("Yes", new DialogInterface.OnClickListener() {

        @Override
        public void onClick(DialogInterface dialog, int which) {
            bg();
        }
    }).show();
}

private void bg() {
	PackageManager pm = getPackageManager();
	ResolveInfo homeInfo = pm.resolveActivity(new Intent(Intent.ACTION_MAIN)
	.addCategory(Intent.CATEGORY_HOME), 0);
	ActivityInfo ai = homeInfo.activityInfo;
    Intent startIntent = new Intent(Intent.ACTION_MAIN);
    startIntent.addCategory(Intent.CATEGORY_LAUNCHER);
    startIntent.setComponent(new ComponentName(ai.packageName, ai.name));
    startIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    try {
        startActivity(startIntent);
    } catch (SecurityException e) {
        LogUtil.e(TAG, "Make sure to create a MAIN intent-filter for the corresponding activity.");
    }
}
```

## 手势功能

```
@Override
public boolean onTouchEvent(MotionEvent event) {
    return mDetector.onTouchEvent(event);
}

mDetector = new GestureDetector(this, mGestureListener);

GestureDetector.SimpleOnGestureListener mGestureListener = new GestureDetector.SimpleOnGestureListener() {
	float MIN_MOVE = 100;
    	
    @Override
    public boolean onScroll(MotionEvent e1, MotionEvent e2, float vX, float vY) {
    	LogUtil.d(TAG, "onScroll...");
        return false;
    }
    
    @Override
    public boolean onFling(MotionEvent e1, MotionEvent e2, float vX, float vY) {
    	LogUtil.d(TAG, "onFling...");
    	float deltaX = e2.getX() - e1.getX(); 
        if(deltaX > MIN_MOVE){
            fastForward(deltaX);
        } else if(deltaX < -MIN_MOVE){
            rewind(-deltaX);
        } 
        
        float deltaY = e2.getY() - e1.getY(); 
        if(deltaY > MIN_MOVE){
            volumeDown(deltaY);
        } else if(deltaY < -MIN_MOVE){
            volumeUp(-deltaY);
        }
        return false;
    }
};
```

### 左右滑动快进快退

```
private void fastForward(float delta){
	LogUtil.d(TAG, "fastForward: " + delta);
	// delta typically 100, 100ms * 100 = 10000ms = 10s 
	int progress =  Math.min(mSongProgressBar.getMax(), mSongProgressBar.getProgress() + (int)(delta * 100));
    mSongProgressBar.setProgress(progress);
    mSongCurrentDurationLabel.setText(strftime(mStreamPlayer.position()));
	mStreamPlayer.seek(progress);
}

private void rewind(float delta){
	LogUtil.d(TAG, "rewind: " + delta);
	int progress =  Math.max(0, mSongProgressBar.getProgress() - (int)(delta * 100));
    mSongProgressBar.setProgress(progress);
    mSongCurrentDurationLabel.setText(strftime(progress));
	mStreamPlayer.seek(progress);
}
```

### 上下滑动调节音量

```
private void volumeUp(float delta){
    int max = mAudioManager.getStreamMaxVolume( AudioManager.STREAM_MUSIC );
    int current = mAudioManager.getStreamVolume( AudioManager.STREAM_MUSIC );
    mAudioManager.setStreamVolume(AudioManager.STREAM_MUSIC, Math.min(current + 1, max), AudioManager.FLAG_SHOW_UI);
    LogUtil.d(TAG, "max : " + max + " current : " + current);
}

private void volumeDown(float delta){
    int current = mAudioManager.getStreamVolume( AudioManager.STREAM_MUSIC );
    mAudioManager.setStreamVolume(AudioManager.STREAM_MUSIC, Math.max(0, current - 1), AudioManager.FLAG_SHOW_UI);
    LogUtil.d(TAG, "min : " + 0 + " current : " + current);
}
```

## 特殊事件处理

### 无网、网络数据错误导致无法播放时的异常页面显示

```
OnBlockListener mOnBlockListener = new OnBlockListener() {

    @Override
    public void onBlocked() {
        LogUtil.i(TAG,
                "onBlocked... isPlaying : " + mStreamPlayer.isPlaying());
        mStreamPlayer.pause();
        status = PAUSED;
        checkNetConnected();
    }
};

private boolean isNetConnected() {  
    ConnectivityManager cm = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);  
    if (cm != null) {  
        NetworkInfo[] infos = cm.getAllNetworkInfo();  
        if (infos != null) {  
            for (NetworkInfo ni : infos) {  
                if (ni.isConnected()) {  
                    return true;  
                }  
            }  
        }  
    }  
    return false;  
}  
    
private void checkNetConnected() {
	if (isNetConnected())
		return;
	LogUtil.i(TAG, "Net Disconnected...");
	Toast.makeText(getApplicationContext(), "Net Disconnected...",
			Toast.LENGTH_LONG).show();
		
}
```

### 播放状态下，拔掉耳机，自动暂停播放；播放状态下插入耳机，播放继续。

```
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

```
public void onCreate(Bundle savedInstanceState) {  
    super.onCreate(savedInstanceState);  
    setContentView(R.layout.main);  
      
    IntentFilter filter = new IntentFilter();  
    filter.addAction(Intent.ACTION_HEADSET_PLUG);  
    registerReceiver(headsetReceiver, filter);  
}  
  
private BroadcastReceiver headsetReceiver = new BroadcastReceiver() {  
    @Override  
    public void onReceive(Context context, Intent intent) {    
         LogUtil.i(TAG, "state: "+intent.getIntExtra("state", 0));
         if(intent.getIntExtra("state", 0) == 1){   
             resume();
         }else if(intent.getIntExtra("state", 0) == 0){  
             pause();  
         }    
    }  
}; 
```

### 播放状态下来电话，自动暂停播放；一旦挂掉电话，自动恢复播放。

```
<uses-permission android:name="android.permission.READ_PHONE_STATE"></uses-permission>  
<uses-permission android:name="android.permission.PROCESS_OUTGOING_CALLS"></uses-permission> 
```

```
<activity
    android:name=".MainActivity"
    android:label="@string/app_name" >
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
    <intent-filter>
		<!-- 获取来电广播 -->
		<action android:name="android.intent.action.PHONE_STATE" />
		<!-- 获取去电广播 -->
		<action android:name="android.intent.action.NEW_OUTGOING_CALL" />
	</intent-filter>
</activity>
```

```
IntentFilter phoneFilter = new IntentFilter("android.intent.action.PHONE_STATE");  
phoneFilter.addAction(Intent.ACTION_NEW_OUTGOING_CALL);
registerReceiver(phoneReceiver, phoneFilter);
```

```
private BroadcastReceiver phoneReceiver = new BroadcastReceiver(){
	@Override
    public void onReceive(Context context, Intent intent) {
        //拨打电话
        if (intent.getAction().equals(Intent.ACTION_NEW_OUTGOING_CALL)) {
            final String phoneNum = intent.getStringExtra(Intent.EXTRA_PHONE_NUMBER);
            LogUtil.i(TAG, "phoneNum: " + phoneNum);
            pause();
        } else {
            TelephonyManager tm = (TelephonyManager) context.getSystemService(Service.TELEPHONY_SERVICE);
            tm.listen(listener,PhoneStateListener.LISTEN_CALL_STATE);
        }
    }

    PhoneStateListener listener = new PhoneStateListener(){
        @Override
        public void onCallStateChanged(int state, String incomingNumber) {
            super.onCallStateChanged(state, incomingNumber);
            switch(state){
                //电话等待接听
                case TelephonyManager.CALL_STATE_RINGING:
                    pause();
                    LogUtil.i(TAG, "call state ringing...");
                    break;
                //电话接听
                case TelephonyManager.CALL_STATE_OFFHOOK:
                    LogUtil.i(TAG, "call state offhook...");
                    break;
                //电话挂机
                case TelephonyManager.CALL_STATE_IDLE:
                    LogUtil.i(TAG, "call state idle...");
                    resume();
                    break;
            }
        }
    };
};
```

## uses-permission

```
<uses-permission android:name="android.permission.MOUNT_UNMOUNT_FILESYSTEMS" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.READ_TING_MP3" />
<uses-permission android:name="android.permission.WRITE_TING_MP3" />
<uses-permission android:name="android.permission.WRITE_SETTINGS" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.KILL_BACKGROUND_PROCESSES" />
<uses-permission android:name="android.permission.RESTART_PACKAGES" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.GET_ACCOUNTS" />
<uses-permission android:name="android.permission.USE_CREDENTIALS" />
<uses-permission android:name="android.permission.MANAGE_ACCOUNTS" />
<uses-permission android:name="android.permission.AUTHENTICATE_ACCOUNTS" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.hardware.sensor.accelerometer" />
```
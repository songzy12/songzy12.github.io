---
layout: post
title: "Android Hardware"
date: 2016-06-22 20:07:03 +0800
comments: true
categories: Android

---

## Sensor

```
import android.hardware.SensorManager;
import android.hardware.Sensor;

sensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);

sensorEventListener = new SensorEventListener() {
    public void onSensorChanged(SensorEvent event) {
    	ax = event.values[0];
    	ay = event.values[1];
    	az = event.values[2];
	}

	public void onAccuracyChanged(Sensor sensor, int accuracy) {
	}
}

sensorManager.registerListener(sensorEventListener, accelerometer, SensorManager.SENSOR_DELAY_NORMAL);
```
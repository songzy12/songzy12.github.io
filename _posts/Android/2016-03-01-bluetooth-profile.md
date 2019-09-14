---
layout: post
title: "Bluetooth Profile"
date: 2016-03-01 14:36:00 +0800
comments: true
categories: 

---

## Outline

An outline of Android source code: [here](http://elinux.org/Master-android). 

Bluetooth architecture: [here](https://source.android.com/devices/bluetooth.html). 

Android source code analysis: [here](http://blog.csdn.net/luoshengyang).

* android.bluetooth:
    * frameworks/base/core/java/android/bluetooth
    * implements public API for the Bluetooth adapter and profiles
* Bluetooth system service
    * packages/apps/Bluetooth/src
    * implements service and profiles at the Android fraework layer
* Bluetooth JNI
    * packages/apps/Bluetooth/jni
    * defines Bluetooth adapter and profiles service JNI: calls into HAL and receives callback from HAL
* Bluetooth HAL
    * hardware/libhardware/include/hardware/bt_*.h
    * defines the standard interface that the android.bluetooth adapter and  profiles APIs
* Bluetooth stack
    * external/bluetooth/bluedroid
    * implement bluetooth stack: core and profiles

## PBAP

* Copy `/frameworks/opt/bluetooth/src/android/bluetooth/client/pbap/` from Android 5.0.
* Modify `/frameworks/opt/bluetooth/Android.mk` to make it suitable.

## A2DP

The implementation of A2DP sink role: [here](https://android-review.googlesource.com/#/c/98161/). 

One implementation of sbc-decoder: [here](github.com/tieto/sbc-decoder). 

* /external/bluetooth/bluedroid/
    * btif/
        * co/bta_av_co.c
        * include/btif_av_api.h
        * include/btif_media.h
        * src/btif_av.c
        * src/btif_dm.c
        * src/btif_media_task.c
        * src/btif_storage.c
    * bta/ 
        * av/bta_av_aact.c
        * av/bta_av_act.c
        * av/bta_av_int.h
        * av/bta_av_main.c
        * av/bta_av_sbc.c
        * av/bta_av_ssm.c
        * include/bta_av_co.h
        * include/bta_av_sbc.h
    * audio_a2dp_hw/
        * audio_a2dp_hw.h
        * audio_a2dp_hw.c
        * Android.mk
    * embdrv/
        * sbc/decoder/include/sbc_decoder.h
        * sbc/decoder/srce/sbc_decoder.c
    * main/
    * stack/
        * avdt/avdt_scb_act.c
    * Android.mk
* /system/core/include/system/audio.h
* /frameworks/base/media/java/android/media/
    * AudioManager.java
    * AudioService.java
    * AudioSystem.java
    * MediaRecorder.java
* /hardware/libhardware_legacy/audio/
    * Android.mk
    * AudioPolicyManagerBase.cpp
* /device/softwinner/common/hardware/audio/audio_policy.conf
* /packages/apps/Bluetooth/
    * src/com/android/bluetooth/a2dp/A2dpStateMachine.java
    * AndroidManifest.xml

The sbc-decoder of Android 5.0 lies in 

* /external/bluetooth/bluedroid/
    * embdrv/sbc/decoder/
    * btif/src/btif_media_task.c

## HFP

Directories about A2DP, AVRCP, HFP: [here](http://blog.csdn.net/wendell_gong/article/details/47950781).

* /frameworks/base/core/java/android/bluetooth/
    * BluetoothHeadsetClient.java
    * BluetoothHeadsetClientCall.java
* /packages/apps/Bluetooth/
    * src/com/android/bluetooth/hfpclient/
        * HeadsetClientHalConstants.java
        * HeadsetClientService.java
        * HeadsetClientStateMachine.java
    * jni/com_android_bluetooth_hfpclient.cpp
* /hardware/libhardware/include/hardware/
    * bluetooth.h
    * bt_hf_client.h
* /external/bluetooth/bluedroid/
    * btif/src/btif_hf_client.c
    * btif/src/bluetooth.c
    * bta/hf_client/
    * bta/Android.mk
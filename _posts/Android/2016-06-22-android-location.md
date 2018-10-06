---
layout: post
title: "Android Location"
date: 2016-06-22 20:07:03 +0800
comments: true
categories: Android

---

## Location

```
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;

locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);  

criteria = new Criteria();      
criteria.setAccuracy(Criteria.ACCURACY_FINE);   
criteria.setAltitudeRequired(true);  
criteria.setBearingRequired(true);  
criteria.setCostAllowed(true);      
criteria.setPowerRequirement(Criteria.POWER_LOW);  
criteria.setSpeedRequired(true);  
provider = locationManager.getBestProvider(criteria, true);

locationListener = new LocationListener() {  
    @Override  
    public void onLocationChanged(Location location) {  
    	updateLocation(location);
    }  
    @Override  
    public void onStatusChanged(String provider, int status, Bundle extras) {  
    	updateLocation(null);
    }  
    @Override  
    public void onProviderEnabled(String provider) {  
    }  
    @Override  
    public void onProviderDisabled(String provider) {  
    }  
};  

locationManager.requestLocationUpdates(provider, 1000, 0,locationListener);

private void updateLocation(Location location){
	if (location != null) {  
        location.getLatitude();  
        location.getLongitude();  
    }
}  
		        
```

```
import android.location.GpsSatellite;
import android.location.GpsStatus;

if(locationManager.isProviderEnabled(android.location.LocationManager.GPS_PROVIDER))
	textView.append("GPS opened!\n");
else
	textView.append("Please open GPS!\n");

statusListener = new GpsStatus.Listener() {  
    public void onGpsStatusChanged(int event) { // GPS状态变化时的回调，如卫星数  
        GpsStatus status = locationManager.getGpsStatus(null); //取当前状态  
        updateGpsStatus(event, status);
    }
};
locationManager.addGpsStatusListener(statusListener);

private void updateGpsStatus(int event, GpsStatus status) {
	maxSignalNoiseRate.setValue(0f);
    if (event == GpsStatus.GPS_EVENT_SATELLITE_STATUS) {
        Iterator<GpsSatellite> it = status.getSatellites().iterator();
        while (it.hasNext()) {
        	float tmp = it.next().getSnr();
        	if (tmp > maxSignalNoiseRate.getValue())
        		maxSignalNoiseRate.setValue(tmp);
        }
    }
}
```

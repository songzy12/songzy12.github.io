---
layout: post
title: "Speech to Text"
date: 2016-03-16 21:37:58 +0800
comments: true
categories: JavaScript Python

---

## API

API: application programming interface.

* api key: `272693d198659c3ab00bbdeee1df353f`
* text-to-speech: [here](http://apistore.baidu.com/apiworks/servicedetail/867.html).
* speech-to-text: [here](http://apistore.baidu.com/astore/toolshttpproxy?apiId=usy9yg&isAworks=1).
* One hundred times per second.

* `audioBase64 ` is truncated in the debug tool for speech-to-text api.
* parameter error: the `audioBase64` parameter is wrong.
* The t-t-s api returns mp3 data, while the s-t-t api receives wav data.
* The `lan` parameter is of no use.  

## browser

### navigator.getUserMedia

```
navigator.getUserMedia({audio:true}, success, function(e) {
alert('Error capturing audio.');
});
```

### AudioContext

```
function success(e){
    // creates the audio context
    audioContext = window.AudioContext || window.webkitAudioContext;
    context = new audioContext();

	// we query the context sample rate (varies depending on platforms)
    inputSampleRate = context.sampleRate;
    outputSampleRate = 8000;

    console.log('succcess');
    
    // creates a gain node
    volume = context.createGain();

    // creates an audio node from the microphone incoming stream
    audioInput = context.createMediaStreamSource(e);

    // connect the stream to the gain node
    audioInput.connect(volume);

    /* From the spec: This value controls how frequently the audioprocess event is 
    dispatched and how many sample-frames need to be processed each call. 
    Lower values for buffer size will result in a lower (better) latency. 
    Higher values will be necessary to avoid audio breakup and glitches */
    var bufferSize = 2048;
    recorder = context.createScriptProcessor(bufferSize, 1, 1);

    recorder.onaudioprocess = function(e){
        if (!recording) return;
        var left = e.inputBuffer.getChannelData (0);
        
        // we clone the samples
        leftchannel.push (new Float32Array (left));
        
        recordingLength += left.length;
        console.log('recording');
    }

    // we connect the recorder
    volume.connect (recorder);
    recorder.connect (context.destination); 
}
```

### compress

The `context.sampleRate` returns `48000`.

```
function compress(buffer, size) {
    //合并
    var data = new Float32Array(size);
    var offset = 0;
    
    for (var i = 0; i < buffer.length; i++) {
        data.set(buffer[i], offset);
        offset += buffer[i].length;
    }
    //压缩
    var compression = parseInt(inputSampleRate / outputSampleRate);
    
    var length = Math.floor(data.length / compression);
    // Float32Array: 32 bit (4 byte) floating point Array
    var result = new Float32Array(length);

    var index = 0, j = 0;
    
    while (index < length) {
        result[index] = data[j];
        j += compression;
        index++;
    }
    
    return result;
}
```

### wav 

BLOB: binary large object

```
// we stop recording
recording = false;            
outputElement.innerHTML = 'Building wav file...';

var sampleRate = Math.min(inputSampleRate, outputSampleRate);
var sampleBits = 16;

var bytes = compress(leftchannel, recordingLength);

var dataLength = bytes.length * (sampleBits / 8);

// we create our wav file
var buffer = new ArrayBuffer(44 + dataLength);
var view = new DataView(buffer);
var channelCount = 1;
var index = 0;

// RIFF chunk descriptor, 资源交换文件标识符
writeUTFBytes(view, index, 'RIFF'); index += 4;
// 下个地址开始到文件尾总字节数,即文件大小-8
view.setUint32(index, 36 + dataLength, true); index += 4;
// WAV文件标志
writeUTFBytes(view, index, 'WAVE'); index += 4;
// FMT sub-chunk, 波形格式标志 
writeUTFBytes(view, index, 'fmt '); index += 4;
// 过滤字节,一般为 0x10 = 16 
view.setUint32(index, 16, true); index += 4;
view.setUint16(index, 1, true); index += 2;
// 通道数 
view.setUint16(index, channelCount, true); index += 2;
// 采样率,每秒样本数,表示每个通道的播放速度 
view.setUint32(index, sampleRate, true); index += 4;
// 波形数据传输率 (每秒平均字节数) 单声道×每秒数据位数×每样本数据位/8 
view.setUint32(index, sampleRate * channelCount * (sampleBits / 8), true); index += 4;
// 快数据调整数 采样一次占用字节数 单声道×每样本的数据位数/8 
view.setUint16(index, channelCount * (sampleBits / 8), true); index += 2;
// 每样本数据位数 
view.setUint16(index, sampleBits, true); index += 2;
// 数据标识符 
writeUTFBytes(view, index, 'data'); index += 4;
// 采样数据总数,即数据总大小-44, index == 44 now
view.setUint32(index, dataLength, true); index += 4;

// write the PCM samples
var volume = 1;
for (var i = 0; i < bytes.length; i++){
    view.setInt16(index, bytes[i] * (0x7FFF * volume), true);
    index += 2;
}

// our final binary blob
var blob = new Blob ( [ view ], { type : 'audio/wav' } );
```

### download

```
var url = (window.URL || window.webkitURL).createObjectURL(blob);
var link = window.document.getElementById("link");
link.href = url;
link.download = 'output.wav';
var click = document.createEvent("Event");
click.initEvent("click", true, true);
link.dispatchEvent(click);
```

### base 64

A base 64 encoder: [here](http://www.opinionatedgeek.com/dotnet/tools/base64encode/).

```
var audioData = btoa([].reduce.call(new Uint8Array(buffer),function(p,c){return p+String.fromCharCode(c)},''));
```

### XMLHttpRequest

```
var fd = new FormData();
fd.append("audioData", audioData);
var url = "/stt";
var xhr = new XMLHttpRequest();
xhr.onreadystatechange=function() {
    if (xhr.readyState==4 && xhr.status==200) {
        outputElement.innerHTML=xhr.responseText;
    }
}

xhr.open("POST", url);
xhr.send(fd);
```

## server

html: templates/index.html

```
import sys, json
from flask import Flask
from flask import render_template, url_for
from flask import request
from urllib import quote, urlencode
from urllib2 import Request, urlopen

reload(sys)
sys.setdefaultencoding('utf-8')

app = Flask(__name__)
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
apikey = "272693d198659c3ab00bbdeee1df353f"

@app.route('/')
def index():
    retData = open('tts.txt').read()
    return render_template('tts.html', audioBase64=retData)
    
@app.route('/stt', methods=['GET', 'POST'])
def stt():
    # return render_template('stt.html')
    if request.method != 'POST':
        return render_template('stt.html')
    
    url = 'http://apis.baidu.com/apistore/vop/baiduvopjson'
    data = {}
    data['audioBase64'] = request.form['audioData']
    # data['audioBase64'] = open('stt.txt').read()

    data['format'] = "wav"
    data['rate'] = "8000"
    data['channel'] = "1"
    data['lan'] = "zh"

    decoded_data = urlencode(data)
    
    req = Request(url, data = decoded_data)

    req.add_header("Content-Type", "application/x-www-form-urlencoded")
    req.add_header("apikey", apikey)

    resp = urlopen(req)
    content = resp.read()
    if(content):
        try:
            retData = json.loads(content)['retData']
            result = json.loads(retData)['result']
            return "\n".join(result)
        except:
            return content

@app.route('/tts', methods=['GET', 'POST'])
def tts():
    if request.method == 'POST':
        text = quote(request.form['text'].encode('utf-8'))
        url = 'http://apis.baidu.com/apistore/baidutts/tts?text='+text+'&ctp=1&per=0'
        req = Request(url)
        req.add_header("apikey", apikey)
        resp = urlopen(req)
        content = resp.read()
        if(content):
            content = json.loads(content)
            retData = content['retData']
            retData = retData.replace('\/','/')
            return render_template('tts.html', audioBase64=retData)

    return '''
        <form action="" method="post">
            <p><input type=text name=text>
            <p><input type=submit value=Post>
        </form>
    '''

if __name__ == '__main__':
    # app.run()
    app.run(debug=True)
```
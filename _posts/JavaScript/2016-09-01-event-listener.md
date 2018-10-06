---
layout: post
title: "Event Listener"
date: 2016-09-01 09:44:43 +0800
comments: true
categories: JavaScript

---

```
sudo -i
rm /edx/var/mongo/mongodb/mongod.lock
sudo -u mongodb mongod --dbpath /edx/var/mongo/mongodb --repair --repairpath /edx/var/mongo/mongodb
start mongod
exit
sudo su edxapp
```

```
paver devstack lms > lms.log 2>&1 &
paver devstack --fast studio > studio.log 2>&1 &
```

```
lms/urls.py
lms/djangoapps/courseware/mu.py

lms/templates/courseware/courseware.html 
lms/static/js/mu.js

lms/static/videos
```

## mongo

```
> db.problem.findOne()
{
        "_id" : ObjectId("574d30828524fe0e3644b402"),
        "text" : "某公司20XX年总负债100万元，其中有息负债30万元，全部为银行贷款，资产负债率40%，其银行贷款利率为8%，该行业平均收益水平为12%，A公司的企业所得税率为25%，请计算A公司的加权平均资本成本?|||multiplechoiceresponse|||{\"A\": {\"detail\": \"10.4%\"}, \"C\": {\"detail\": \"11%\", \"correct\": \"true\"}, \"B\": {\"detail\": \"10.33%\"}, \"D\": {\"detail\": \"9.6%\"}}",
        "id" : "0074debadb964eee8a0a18ee7ae44a25_2_1"
}
```

```
> db.knowledge_point.findOne()
{
        "_id" : ObjectId("574d691d8524fe0e3644b495"),
        "begin" : 17,
        "end" : 545,
        "problem" : [
                "fdb7429f7aa844e38f04b7f49fbb9f8d_9_1"
        ],
        "id" : "cb796df9b2584f609a58a3fa8f858031_0"
}
```

```
> db.video_knowledge_point.findOne()
{
        "_id" : ObjectId("574ed22a8524fe0e3644b641"),
        "hot_point" : [
                "23,129",
                "192,198",
                "239,277"
        ],
        "id" : "86efb9a1b3b949839d9f540f1359f261",
        "knowledge_point" : [
                "86efb9a1b3b949839d9f540f1359f261_0",
                "86efb9a1b3b949839d9f540f1359f261_1",
                "86efb9a1b3b949839d9f540f1359f261_2",
                "86efb9a1b3b949839d9f540f1359f261_3"
        ]
}
```

## problem\_knowledgepoint

`vi ~/edx-platform/lms/static/js/mu.js`

```
$.get("/mu/problem/knowledgepoint/"+current_problem_id+"/", function(data){
    console.log('knowledge point received')
    console.log(data);
})
```

`vi ~/edx-platform/lms/djangoapps/courseware/mu.py`

```
def get_problem_knowledgepoint(request, problem_id):
    print problem_id
    problem_id = 'fdb7429f7aa844e38f04b7f49fbb9f8d_9_1'

    client = MongoClient('10.9.10.15', 27017)
    db = client.mu
    collection = db.knowledge_point
    data = {}
    cur = collection.find({'problem':problem_id})
    for item in cur:
        data[problem_id] = data.get(problem_id, []) + item['problem']
    return HttpResponse(json.dumps(data), content_type = 'application/json')

```

`vi ~/edx-platform/lms/urls.py `

```
urlpatterns += (
	url(r'^mu/problem/knowledgepoint/([\w\d]+)/$', 'courseware.mu.get_problem_knowledgepoint', name = 'get_problem_knowledgepoint'),
)
```

## onunload

```
~/edx-platform$ grep -r page_close .
./common/static/js/src/logger.js
vi ./common/static/js/src/logger.js
```

```
window.onunload = function() {

}
```

## timeupdate

```
~/edx-platform$ grep -r seek_video .
./lms/static/xmodule_js/src/video/09_events_plugin.js
vi ./lms/static/xmodule_js/src/video/09_events_plugin.js
vi ./lms/static/xmodule_js/src/video/03_video_player.js
```

```
var lastUnixTimeStamp;
var lastCurrentVideoTime;
videoplayer.addEventListener('timeupdate',function(){

    if( !lastUnixTimeStamp && !lastCurrentVideoTime ){  
         //not defined at first timeupdate event
         lastUnixTimeStamp = new Date().getTime();
         lastCurrentVideoTime = videoplayer.currentTime;
         return;
    }
    
    var videoTimeOffset = videoplayer.currentTime - lastCurrentVideoTime; 
    var realTimeOffset = new Date().getTime() - lastUnixTimeStamp;  
    lastUnixTimeStamp = new Date().getTime();
    lastCurrentVideoTime = videoplayer.currentTime;
	// logic
})
```

## scrollx

```
function scrollx(){
    $('iframe#mu').css({
        'border':'none',
        'position':'fixed',
        'height':'280px',
        'right':'0',
        'bottom':'0'
    });
}
```

## type

```
var data_id = $('div.vert').attr('data-id');
var type = data_id.split('+')[3].split('@')[1];
```

## sequence-nav

```
$('div.sequence-nav').click(function(){
    console.log('sequence-list clicked.')
})

$('div.sequence-nav').mouseover($.debounce(500, function(){
        console.log('sequence-nav mouse over.');
}))
```

## div.problem

```
$('div.vert-mod').delegate('div.problem', 'click', function(event){
    console.log('problem clicked');
    var temp = $(event.target).parent();
    while (!temp.attr('id') || !temp.attr('id').startsWith('problem_')) {
        console.log(temp);
        temp = temp.parent();
    }
    current_problem_id = temp.attr('id').split('_')[1];
    console.log(current_problem_id);
    // current_problem_id = event.target;
})
```

## div.course-index

```
$('div.course-index').mouseover($.debounce(1000, function(){
    current_correct_rate = 1.0 * $('button.show').length / $('div.problem').length;
    console.log('course-index mouse over');
    console.log('current_corrent_rate: '+current_correct_rate);
}))
```

## sendMessage

```
function sendMessage(message){
    var iframeWin = $('iframe#mu')[0].contentWindow;
    domain = 'http://112.74.68.45/player/output/huiAS3html.html'
    iframeWin.postMessage(message, domain)
}
```

## seq\_content

```
$('div#seq_content').bind('DOMNodeInserted', $.debounce(250, function(){
    console.log('seq_content content changed')
}))
```

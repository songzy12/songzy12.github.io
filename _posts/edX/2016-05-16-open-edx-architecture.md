---
layout: post
title: "Open edX Architecture"
date: 2016-05-16 14:26:50 +0800
comments: true
categories: 

---

[Here](https://edx.readthedocs.io/projects/edx-developer-guide/en/latest/architecture.html).

## Technologies

* server: Python, Django framework, Mako templates
* browser:  JavaScript, CoffeeScript, Backbone.js framework
* CSS: Sass, Bourbon framework

## Components

* discussions: Ruby, Sinatra framework
* searching: Elasticsearch
* background work: Celery, RabbitMQ.(grading, emails, reports, certificates)
* Courses are stored in Mongo
* Per-student data is stored in MySQL

Events are published to the `analytics pipeline` for collection, analysis, and reporting.

LTI: Learning Tools Interoperability.

## Course

* Open edX courses are composed of units called XBlocks.
* Instructor-written Python code is executed in a secure environment called CodeJail.
* JavaScript components can be integrated using JS Input.
* Courses can be exported and imported using Open Learning XML (OLX), an XML-based format for courses.

* Section
* Subsection
* Unit
* Component: Advanced, Discussion, HTML, Problem, Video

## XBlock

LON-CAPA problems: Learning Online Network with CAPA.

SOP: same origin policy(same protocol, host, and port).

code quality and style: `pylint .`, `pep8 .`

[Here](https://openedx.atlassian.net/wiki/display/COMM/XBlocks+Directory).

* VideoJS Xblock Pro: Video Xblock using Video.js 4.12.11, Features: .vtt substitle upload; tracking log support; more controller and plugins.
* Video JS XBlock: Use Video.js HTML5 player instead of the default one(true full screen, more video speeds, source document download)
* Voice recognizer Xblock: allows students to recognize their voice and can see the what they spoken in text format.
* GradeMe: Button to send request to server to grade user.
* 2048 XBlock: Allows students to play 2048 in the platform (ungraded).

XBlock handlers are Python methods invoked by AJAX calls from the user’s browser. The runtime provides a mapping from handler names to specific URLs so that the XBlock JavaScript code can make requests to its handlers.

## analytics

The events are stored as JSON in S3, processed using Hadoop, and digested, aggregated results are published to MySQL. Results are made available via a REST API to Insights, a Django application that instructors and administrators use to explore data that lets them know what their students are doing and how their courses are being used.

## video

[Here](https://openedx.atlassian.net/wiki/display/TNL/Video+Module+architecture).

* back-end: `edx-platform/common/lib/xmodule/xmodule/video_module/`
* front-end: 
    * JavaScript code: `edx-platform/common/lib/xmodule/xmodule/js/src/video/`
    * Jasmine tests: `edx-platform/common/lib/xmodule/xmodule/js/spec/video/`

```
diff ~/edx-platform/lms/static/xmodule_js/src/video/03_video_player.js ~/edx-platform/common/lib/xmodule/xmodule/js/src/video/03_video_player.js
```

i18n: internationalization.
rst: reStructuredText

HOW TO ADD A NEW MODULE:
* create a new module (for example, video/09_bumper.js)
* Add it to the list of modules: `10_main.js`

## tracker

location: `/edx/var/log/tracking/tracking.log`

* Python

```
from eventtracking import tracker

tracker.emit(
    'edx.addressmodule.address.created',
    {
        'name': 'foo',
        'address': {
            'postal_code': '90210',
            'country': 'United States'
        }
    }
)
```

* JavaScript

```
Logger.log("edx.video.awesome_mode_enabled", {"button_pressed": "the really big purple one", "button_id": 15, "..."})
```

uglify: 混淆，minify

* XBlocks

```
self.runtime.publish(self, "company.xblock.content.viewed", event_data)
```
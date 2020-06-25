---
layout: post
title: "Elasticsearch"
date: 2016-05-13 13:41:59 +0800
comments: true
categories: 

---

## _score

The standard similarity algorithm used in Elasticsearch is known as term frequency/inverse document frequency, or TF/IDF.

```
GET /_search?explain 
{
   "query"   : { "match" : { "tweet" : "honeymoon" }}
}


"_explanation": { 
   "description": "weight(tweet:honeymoon in 0)
                  [PerFieldSimilarity], result of:",
   "value":       0.076713204,
   "details": [
      {
         "description": "fieldWeight in 0, product of:",
         "value":       0.076713204,
         "details": [
            {  
               "description": "tf(freq=1.0), with freq of:",
               "value":       1,
               "details": [
                  {
                     "description": "termFreq=1.0",
                     "value":       1
                  }
               ]
            },
            { 
               "description": "idf(docFreq=1, maxDocs=1)",
               "value":       0.30685282
            },
            { 
               "description": "fieldNorm(doc=0)",
               "value":        0.25,
            }
         ]
      }
   ]
}
```

## _bulk

```
$ cat requests
{ "index" : { "_index" : "test", "_type" : "type1", "_id" : "1" } }
{ "field1" : "value1" }
$ curl -s -XPOST localhost:9200/_bulk --data-binary @requests; echo
{"took":7,"items":[{"create":{"_index":"test","_type":"type1","_id":"1","_version":1,"ok":true}}]}
```

And if you are using `index/type/_bulk` endpoint, you can also ignore `_index` and `_type`. 

## _stats

```
curl -XGET 'http://localhost:9200/_mapping?pretty=true'
curl http://localhost:9201/_stats/indices?pretty=1
curl http://localhost:9201/_stats?pretty=1
```

[Tutorial here](http://es.xiaoleilu.com/)

## 安装

install: 

```
curl -L -O http://download.elasticsearch.org/PATH/TO/VERSION.zip <1>
unzip elasticsearch-$VERSION.zip
cd  elasticsearch-$VERSION
```

config: `./config/elasticsearch.yml`

status:

```
curl 'http://localhost:9200/?pretty'
```

shutdown:

```
curl -XPOST 'http://localhost:9200/_shutdown'
```

## API

```
curl -X<VERB> '<PROTOCOL>://<HOST>:<PORT>/<PATH>?<QUERY_STRING>' -d '<BODY>'
```

- VERB HTTP方法：GET, POST, PUT, HEAD, DELETE
- PROTOCOL http或者https协议（只有在Elasticsearch前面有https代理的时候可用）
- HOST Elasticsearch集群中的任何一个节点的主机名，如果是在本地的节点，那么就叫localhost
- PORT Elasticsearch HTTP服务所在的端口，默认为9200
- PATH API路径（例如_count将返回集群中文档的数量），PATH可以包含多个组件，例如_cluster/stats或者_nodes/stats/jvm
- QUERY_STRING 一些可选的查询请求参数，例如?pretty参数将使请求返回更加美观易读的JSON数据
- BODY 一个JSON格式的请求主体（如果请求需要的话）

```
curl -XGET 'http://localhost:9200/_count?pretty' -d '
{
    "query": {
        "match_all": {}
    }
}
```

## 索引

```
Relational DB -> Databases -> Tables -> Rows -> Columns
Elasticsearch -> Indices   -> Types  -> Documents -> Fields
```

默认情况下，文档中的所有字段都会被索引（拥有一个倒排索引），只有这样他们才是可被搜索的。

```
PUT /megacorp/employee/1
{
    "first_name" : "John",
    "last_name" :  "Smith",
    "age" :        25,
    "about" :      "I love to go rock climbing",
    "interests": [ "sports", "music" ]
}
```

## 搜索

检索文档:

```
GET /megacorp/employee/1
```

简单搜索：

```
GET /megacorp/employee/_search
```

默认情况下搜索会返回前10个结果。


query string:

```
GET /megacorp/employee/_search?q=last_name:Smith
```

DSL(domain specific language):

```
GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "last_name" : "Smith"
        }
    }
}
```

filter:

```
GET /megacorp/employee/_search
{
    "query" : {
        "filtered" : {
            "filter" : {
                "range" : {
                    "age" : { "gt" : 30 } <1>
                }
            },
            "query" : {
                "match" : {
                    "last_name" : "smith" <2>
                }
            }
        }
    }
}
```

match:

```
GET /megacorp/employee/_search
{
    "query" : {
        "match" : {
            "about" : "rock climbing"
        }
    }
}
```

相关性(relevance)的概念在Elasticsearch中非常重要，而这个概念在传统关系型数据库中是不可想象的，因为传统数据库对记录的查询只有匹配或者不匹配。

phrase:

```
GET /megacorp/employee/_search
{
    "query" : {
        "match_phrase" : {
            "about" : "rock climbing"
        }
    }
}
```

highlight:

```
GET /megacorp/employee/_search
{
    "query" : {
        "match_phrase" : {
            "about" : "rock climbing"
        }
    },
    "highlight": {
        "fields" : {
            "about" : {}
        }
    }
}
```

## 聚合

```
GET /megacorp/employee/_search
{
    "aggs" : {
        "all_interests" : {
            "terms" : { "field" : "interests" },
            "aggs" : {
                "avg_age" : {
                    "avg" : { "field" : "age" }
                }
            }
        }
    }
}
```

## 乐观并发控制

```
PUT /website/blog/1?version=1 <1>
{
  "title": "My first blog entry",
  "text":  "Starting to get the hang of this..."
}
```

我们只希望文档的_version是1时更新才生效。

ES是基于Lucene的，有很多概念是直接来自于它，所有要想深入学习ES，还得有点Lucene的基础。
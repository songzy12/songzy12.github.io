---
layout: post
title: "XML Parser"
date: 2016-07-19 13:50:37 +0800
comments: true
categories: Python

---

## TypeError

```
soup = BeautifulSoup(data, 'lxml')
TypeError: unhashable type
```

```
i4x_TsinghuaX_10430494X
{u'data': u'<problem>\n<p>\u8ba4\u8bc6\u4e86\u7535\u6d41\u7684\u78c1\u6548\u5e94\u4ee5\u540e, \u4eba\u4eec\u5bf9\u78c1\u573a\u7684\u7814\u7a76\u624d\u6709\u4e86\u5927\u7684\u8fdb\u5c55.</p>\n<multiplechoiceresponse>\n  <choicegroup type="MultipleChoice">\n    <choice correct="true">\u662f</choice>\n    <choice correct="false">\u5426</choice>\n  </choicegroup>\n</multiplechoiceresponse>\n\n     \n<solution>\n<div class="detailed-solution">\n<p>Explanation</p>\n\n<p>\u5386\u53f2\u4e0a\u662f\u5965\u65af\u7279\u7684\u53d1\u73b0\u63a8\u52a8\u4e86\u5bf9\u78c1\u73b0\u8c61\u7684\u672c\u8d28\u8ba4\u8bc6\u3002</p>\n\n</div>\n</solution>\n\n</problem>'}
```

```
db.modulestore.find({"_id.category":"problem", "_id.tag":"i4x", "_id.org":"TsinghuaX", "_id.course":"10430494X"}).limit(1).pretty();
```

```
"definition" : {
        "data" : {
                "data" : "<problem>\n<p>静电场沿闭合回路的积分为零, 就是基尔霍夫第二定律.</p>\n<multiplechoiceresponse>\n  <choicegroup type=\"MultipleChoice\">\n    <choice correct=\"true\">是</choice>\n    <choice correct=\"false\">否</choice>\n  </choicegroup>\n</multiplechoiceresponse>\n\n     \n<solution>\n<div class=\"detailed-solution\">\n<p>Explanation</p>\n\n<p>稳恒电场本质上是静电场.</p>\n\n</div>\n</solution>\n\n</problem>"
        }
}
```

## exercises

Types of different exercises: [here](http://edx.readthedocs.io/projects/edx-partner-course-staff/en/latest/exercises_tools/create_exercises_and_tools.html).

```
checkbox.xml  
dropdown.xml  
math_expression_input.xml 
multiple_choice.xml  
numerical_input.xml  
text_input.xml
```

```
soup = BeautifulSoup(data, 'lxml')
if soup.choiceresponse:
    return parse_checkbox(soup)
elif soup.optionresponse:
    return parse_dropdown(soup)
elif soup.formularesponse:
    return parse_math_expression_input(soup)
elif soup.multiplechoiceresponse:
    return parse_multiple_choice(soup)
elif soup.numericalresponse:
    return parse_numerical_input(soup)
elif soup.stringresponse:
    return parse_text_input(soup)
```

## modulestore

```
mongo;
use edxapp;
db.modulestore.find({"_id.category":"problem", "_id.tag":"i4x", "_id.org":"TsinghuaX", "_id.course":"80512073X"}).limit(10).pretty();
db.modulestore.findOne({"_id.category":"problem"});
```

```
{
        "_id" : {
                "tag" : "i4x",
                "org" : "BerkeleyX",
                "course" : "CS169_1x",
                "category" : "problem",
                "name" : "005669218053441494b20883be8d5b00",
                "revision" : null
        },
        "definition" : {
                "children" : [ ],
                "data" : "<problem markdown=\"null\">\n  <problem>\n    <p>下面哪些是正确的:</p>\n    <p>(a) <code>my_account.@balance</code></p>\n    <p>(b) <code>my_account.balance</code></p>\n    <p>(c) <code>my_account.balance()</code></p>\n    <choiceresponse>\n      <radiogroup>\n        <choice correct=\"false\">\n          <text>\n            <span style=\"color: #F90;\">All Three</span>\n          </text>\n        </choice>\n        <choice correct=\"false\">\n          <text>\n            <span style=\"color: #063;\">Only (b)</span>\n          </text>\n        </choice>\n        <choice correct=\"false\">\n          <text>\n            <span style=\"color: #C00;\">(a) and (b)</span>\n          </text>\n        </choice>\n        <choice correct=\"true\">\n          <text>\n            <span style=\"color: #006;\">(b) and (c)</span>\n          </text>\n        </choice>\n      </radiogroup>\n    </choiceresponse>\n  </problem>\n</problem>\n"
        },
        "metadata" : {
                "rerandomize" : "never",
                "showanswer" : "finished",
                "display_name" : "Multiple Choice"
        }
}
```

## xml filename

财务分析： course-v1:TsinghuaX+80512073X+2016_T1

```
>>> item['metadata']['xml_attributes']['filename']
[u'problem/3984191f64e140aaa7b43b3187d2a4a5.xml', u'problem/3984191f64e140aaa7b43b3187d2a4a5.xml']
```
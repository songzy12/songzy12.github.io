---
layout: post
title: "String Services"
date: 2016-12-24 14:29:03 +0800
comments: true
categories: Python

---

## re

### ?P

```
>>> import re
>>> match = re.search('(?P<name>.*) (?P<phone>.*)', 'John 123456')
>>> match.group('name')
'John'
```

### split

```
re.split(u'，|。', u'a，b。c')
```

```
import re
DATA = "Hey, you - what are you doing here!?"
print re.findall(r"[\w']+", DATA)
```

### sub

```
re.sub(pattern, repl, string, count=0, flags=0)

	Return the string obtained by replacing the leftmost non-overlapping occurrences of pattern in string by the replacement repl. If the pattern isn’t found, string is returned unchanged. repl can be a string or a function;
	If repl is a function, it is called for every non-overlapping occurrence of pattern. The function takes a single match object argument, and returns the replacement string.
```

```
>>> def dashrepl(matchobj):
...     if matchobj.group(0) == '-': return ' '
...     else: return '-'
>>> re.sub('-{1,2}', dashrepl, 'pro----gram-files')
'pro--gram files'
```

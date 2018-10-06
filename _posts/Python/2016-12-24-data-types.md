---
layout: post
title: "data types"
date: 2016-12-24 14:11:32 +0800
comments: true
categories: Python

---

## bisect

```
bisect.bisect_left(a, x, lo=0, hi=len(a))
	Locate the insertion point for x in a to maintain sorted order.


bisect.insort_left(a, x, lo=0, hi=len(a))
    Insert x in a in sorted order. This is equivalent to a.insert(bisect.bisect_left(a, x, lo, hi), x) assuming that a is already sorted. Keep in mind that the O(log n) search is dominated by the slow O(n) insertion step.
```

## collections

### deque

```
from collections import dequeue
q = dequeue(['a','b','c'])
q.append('x')
q.appendleft('y')
q.pop()
q.popleft()
```

```
buffer = deque(maxlen=span)
for _ in xrange(span):
    buffer.append(data[data_index])
    data_index = (data_index + 1) % len(data)
```

### defaultdict

```
from collections import defaultdict
dd = defaultdict(lambda: 'N/A')
```

### namedtuple

```
from collections import namedtuple
Point = namedtuple('Point', ['x','y'])
p = Point(1,2)
p.x
p.y
isinstance(p, tuple)
```

### Counter

```
c = Counter('programming')
```

```
most_common(self, n=None) unbound collections.Counter method
    List the n most common elements and their counts from the most
    common to the least.  If n is None, then list all element counts.
    
    >>> Counter('abcdeabcdabcaba').most_common(3)
    [('a', 5), ('b', 4), ('c', 3)]
```

### OrderedDict

```
vocab = Counter(reduce(lambda x, y: x + y,[question + answer for question, answer in train]))

from collections import OrderedDict
with io.open('data/vocab.json', 'w', encoding='utf8') as f:
    f.write(json.dumps(OrderedDict(sorted(vocab.items(), key=lambda (k,v):v)), ensure_ascii=False, sort_keys=False, indent=4))
```

## datetime

```
from datetime import datetime

time = '2016-02-26 04:41'
time = datetime.strptime(time, '%Y-%m-%d %H:%M')
print time
```

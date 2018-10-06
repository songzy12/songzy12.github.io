---
layout: post
title: "python built-in"
date: 2016-12-24 14:04:31 +0800
comments: true
categories: Python

---

## Python Style

* 命名： ClassName, ExceptionName, GLOBAL_VAR_NAME, module_name, package_name, method_name, function_name, instance_var_name, function_parameter_name, local_var_name. 用单下划线(_)开头表示模块变量或函数是protected的(使用import * from时不会包含). 用双下划线(__)开头的实例变量或方法表示类内私有.
* 不要在行尾加分号, 也不要用分号将两条命令放在同一行.
* 不要使用反斜杠连接行.
* 顶级定义之间空两行, 方法定义之间空一行
* 当’=’用于指示关键字参数或默认参数值时, 不要在其两侧使用空格. 
```
def complex(real, imag=0.0): return magic(r=real, i=imag)
```
* 不要用空格来垂直对齐多行间的标记, 因为这会成为维护的负担(适用于:, #, =等)
* SheBang(HashBang): 大部分.py文件不必以#!作为文件的开始. 根据 PEP-394 , 程序的main文件应该以 `#!/usr/bin/python2` 或者 `#!/usr/bin/python3` 开始.
* 注释：
```
def fetch_bigtable_rows(big_table, keys, other_silly_variable=None):
    """Fetches rows from a Bigtable.

    Retrieves rows pertaining to the given keys from the Table instance
    represented by big_table.  Silly things may happen if
    other_silly_variable is not None.

    Args:
        big_table: An open Bigtable Table instance.
        keys: A sequence of strings representing the key of each table row
            to fetch.
        other_silly_variable: Another optional variable, that has a much
            longer name than the other args, and which does nothing.

    Returns:
        A dict mapping keys to the corresponding table row data
        fetched. Each row is represented as a tuple of strings. For
        example:

        {'Serak': ('Rigel VII', 'Preparer'),
         'Zim': ('Irk', 'Invader'),
         'Lrrr': ('Omicron Persei 8', 'Emperor')}

        If a key from the keys argument is missing from the dictionary,
        then that row was not found in the table.

    Raises:
        IOError: An error occurred accessing the bigtable.Table object.
    """
    pass
```

```
class SampleClass(object):
    """Summary of class here.

    Longer class information....
    Longer class information....

    Attributes:
        likes_spam: A boolean indicating if we like SPAM or not.
        eggs: An integer count of the eggs we have laid.
    """

    def __init__(self, likes_spam=False):
        """Inits SampleClass with blah."""
        self.likes_spam = likes_spam
        self.eggs = 0

    def public_method(self):
        """Performs operation blah."""
```
* 如果一个类不继承自其它类, 就显式的从object继承. 嵌套类也一样.
* 在同一个文件中, 保持使用字符串引号的一致性. 使用单引号’或者双引号”之一用以引用字符串, 并在同一文件中沿用.
* 每个导入应该独占一行. 导入应该按照从最通用到最不通用的顺序分组: 标准库导入，第三方库导入， 应用程序指定导入。每种分组中, 应该根据每个模块的完整包路径按字典序排序, 忽略大小写。

## all

```
all(iterable) -> bool
```

## any

```
>>> any(x == 2 for x in [1,2])
True
>>> any(x == 3 for x in [1,2])
False
```

## bin

```
>>> print bin(8)
0b1000
```

## dict

When dealing with `dict`, remember to use `dict.copy()`, since it is mutable.

```
for key, value in dict_.items():
    print key, value

dict1.update(dict2)
```

```
# map from word to id

word2id = {}
for word, _ in count:
    word2id[word] = len(word2id)
```

```
# map from id to word
id2word = dict(zip(word2id.values(), word2id.keys()))
```

## input

`raw_input` expects a string, while `input` expects an expression.

## list

```
t = emp[k]
emp.pop(k)
# emp.remove(t)
```

## locals

```
def __init__(self, x, y, z, etc):
	self.__dict__.update(locals())
```

All these arguments become members (including the `self` argument). 

So you may remove it with: `self.__dict__.pop('self')`

## set

```
s | t
s & t
s - t
s ^ t
```

## sorted

`list_of_adoption_centers.sort(key=adopter.get_score)` returns `None`.

`list(reversed(list_of_adoption_centers))` is equal to `list_of_adoption_centers[::-1]`.

```
envelopes.sort(cmp=lambda x, y:x[0] - y[0] if x[0] != y[0] else y[1] - x[1])
envelopes.sort(key=lambda x: (x[0], -x[1]))
```

## super

The code can be simplified as `Shape.__init__(self, x, y)`.

`super()` lets you avoid referring to the base class explicitly, which can be nice. But the main advantage comes with multiple inheritance.

Syntax changed in Python 3.0: you can just say `super().__init__()` instead of `super(self.__class__, self).__init__()` which is quite a bit nicer.

`super()` can be used only in the new-style classes, which means the root class needs to inherit from the `object` class.

```
>>> instance = Shape()
>>> issubclass(instance.__class__, object)
False
```

## unicode

In Python 3 the default encoding has been switched from `ascii` to `utf-8`.

To get utf8-encoded file (for smaller size) in Python 2.x:

```
import io, json
with io.open('data.txt', 'w', encoding='utf-8') as f:
  f.write(unicode(json.dumps(data, ensure_ascii=False, sort_keys=True, indent=4)))
```

The code is simpler in Python 3.x:

```
import json
with open('data.txt', 'w') as f:
  json.dump(data, f, ensure_ascii=False)
```

```
SyntaxError: Non-ASCII character '\xe6' in file test.py on line 8, but no encoding declared; see http://python.org/dev/peps/pep-0263/ for details
```

```
# -*- coding: utf-8 -*-  
```

## zip

```
zip(...)
    zip(seq1 [, seq2 [...]]) -> [(seq1[0], seq2[0] ...), (...)]
    
    Return a list of tuples, where each tuple contains the i-th element
    from each of the argument sequences.  The returned list is truncated
    in length to the length of the shortest argument sequence.
```

---
layout: post
title: "Python Dist Packages"
date: 2016-09-11 14:44:05 +0800
comments: true
categories: Python

---

## dist-packages

```
>>> import site
>>> site.getsitepackages()
['/usr/local/lib/python2.7/dist-packages', '/usr/lib/python2.7/dist-packages']
```

```
>>> import gensim
>>> gensim 
<module 'gensim' from '/usr/local/lib/python2.7/dist-packages/gensim/__init__.pyc'>
```

## pip

```
pip install --use pyhs2
```

## pkg_resources

```
>>> from pkg_resources import parse_version
>>> parse_version('1.9.a.dev') == parse_version('1.9a0dev')
True
>>> parse_version('2.1-rc2') < parse_version('2.1')
True
>>> parse_version('0.6a9dev-r41475') < parse_version('0.6a9')
True
```

```
release = pkg_resources.get_distribution('sandman').version
version = '.'.join(release.split('.')[:2])
```

## virtualenv

```
cd my_project_folder
virtualenv venv
source venv/bin/activate
pip install requests
deactivate
```

## xlrd

```
import xlrd

table = xlrd.open_workbook(file_name).sheets()[0]
for row in range(1, table.nrows - 1):
    print table.row_values(row)
```

---

## bs4

```
[script.extract() for script in link_soup(["script", "ins"])]

extract(self) method of bs4.element.Tag instance
    Destructively rips this element out of the tree. 
```

## pymining

[Here](https://github.com/bartdag/pymining).

BIDE Algorithm.

```
support = 1000
```

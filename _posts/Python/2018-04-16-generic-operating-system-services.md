---
layout: post
title: "Generic Operating System Services"
date: 2018-04-16 14:19:01 +0800
comments: true
categories: Python

---

## io

```
import io
io.open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True)
```

* The `open()` function an alias to `io.open()`. It wraps the OS-level file descriptor in a file object. 
* `os.open()` is just a wrapper for the lower-level POSIX syscall. It returns the file descriptor (a number) that represents the opened file.

## logging

```
import logging  

logging.basicConfig()
logger = logging.getLogger('test')  
# NOTSET < DEBUG < INFO < WARNING < ERROR < CRITICAL
logger.setLevel(logging.DEBUG)  
  
fh = logging.FileHandler('test.log')  
fh.setLevel(logging.DEBUG)  
    
ch = logging.StreamHandler()  
ch.setLevel(logging.DEBUG)  
    
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')  
fh.setFormatter(formatter)  
ch.setFormatter(formatter)  
    
logger.addHandler(fh)  
logger.addHandler(ch)  

# logger.debug, logger.info, logger.warning, logger.error, logger.critical
logger.info('foorbar')  
```

## optparse

```
parser = optparse.OptionParser(sys.argv[0]+' '+
'-r <file_with URLs>')
parser.add_option('-r', dest='URLs', type='string', 
        help='specify target file with URLs')
(options, args) = parser.parse_args()
URLs=options.URLs
```

## os

```
import os
script_dir = os.path.dirname(__file__) # <-- absolute dir the script is in
rel_path = "2091/data.txt"
abs_file_path = os.path.join(script_dir, rel_path)
```

### makedirs

Works like mkdir, except that any intermediate path segment (not just the rightmost) will be created if it does not exist.

```
if not os.path.exists(directory):
    os.makedirs(directory)
```

### path

```
>>> filename, file_extension = os.path.splitext('/path/to/somefile.ext')
>>> filename
'/path/to/somefile'
>>> file_extension
'.ext'
```

```
os.path.join(dir_name, file_name);
```

```
import sys
import os
parent = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, parent)
```

```
os.path.dirname(path)
    Return the directory name of pathname path. This is the first element of the pair returned by passing path to the function split().
```

```
os.access(path, mode);
```

* os.F_OK: test the existence of path
* os.R_OK: readability
* os.W_OK: writability
* os.X_OK: executability

### popen

```
output = os.popen('cat /proc/cpuinfo')
print output.read()
```

### system

```
retvalue = os.system("ps -p 2993 -o time --no-headers")
```

## pickle

```
import pickle

with open("active_user.pkl", "wb") as f:
    pickle.dump(active_user, f)

with open("active_user") as f:
    active_user = pickle.load(f)

with open("text1") as f1, open("text2") as f2:
	pass
```

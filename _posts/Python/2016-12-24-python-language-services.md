---
layout: post
title: "python language services"
date: 2016-12-24 14:06:13 +0800
comments: true
categories: Python

---

## ast

Abstract Syntax Trees

```
import ast

expr_ast = ast.parse(expr)
ast.dump(expr_ast)

transformer = CrazyTransformer()
transformer.visit(expr_ast)

unparse.Unparser(modified, sys.stdout)
```

`ast.literal_eval()` only considers a small subset of Python's syntax to be valid: 

The string or node provided may only consist of the following Python literal structures: strings, numbers, tuples, lists, dicts, booleans, and None.

Passing `__import__('os').system('rm -rf /a-path-you-really-care-about')` into `ast.literal_eval()` will raise an error, but `eval()` will happily wipe your drive.

Use `ast.literal_eval` whenever you need `eval`.

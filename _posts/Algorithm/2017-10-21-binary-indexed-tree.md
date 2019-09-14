---
layout: post
title: "Binary Indexed Tree"
date: 2017-10-21 10:14:50 +0800
comments: true
categories: 
keywords: 
description: 

---

## Low Bit

```
int lowbit(int x) {
    return x & (-x);
}
```

## One Dimension

```
int sum(int x) {
    int ret = 0;
    while(x > 0) {
        ret += BIT[x]);
        x -= lowbit(x);
    }
    return ret;
}
```

```
void add(x, val) {
    while(x <= N) {
        BIT[x] += val;
        x += lowbit(x);
    }
}
```

## Two Dimension

```
void add(int x, int y, int val) {
    for(int i = x; i <= N; i += lowbit(i)) {
        for(int j = y; j <= N; j += lowbit(j)) {
            BIT2[i][j] += val;
        }
    }
}
```

```
int sum(int x, int y) {
    int ret = 0;
    for(int i = x; i > 0; i -= lowbit(i)) {
        for(int j = y; j > 0; j -= lowbit(j)) {
            ret += BIT2[i][j];
        }
    }
    return ret;
}
```

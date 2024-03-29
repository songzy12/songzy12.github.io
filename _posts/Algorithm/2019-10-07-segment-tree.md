---
layout: post
title: "Segment Tree"
date: 2019-10-07T17:14:21+08:00
---

<https://www.geeksforgeeks.org/segment-tree-data-structure/>

Representation of Segment trees:

1. Leaf Nodes are the elements of the input array.

2. Each internal node represents some merging of the leaf nodes. 

   The merging may be different for different problems. 

## Sum of given range

<https://www.geeksforgeeks.org/segment-tree-set-1-sum-of-given-range/>

1. Find the sum of elements from index l to r where 0 <= l <= r <= n-1

2. Change value of a specified element of the array to a new value x. 

   We need to do arr[i] = x where 0 <= i <= n-1.

Can we perform both the operations in O(log n) time once given the array? 

## Range Minimum Query

<https://www.geeksforgeeks.org/segment-tree-set-1-range-minimum-query/>

### Example

<https://codeforces.com/contest/1208/problem/d>

```
# https://codeforces.com/contest/1208/problem/D

from sys import stdin, stdout
input = stdin.readline
# print = stdout.write

# 1. the right most 0 is the index of current minimum value
# 2. we abstract the current value for all the elements to the right
# 3. Then we can do recusion

# To find the last index with value zero,
# we can use segment tree to get range minimum query with lazy propagation.

# https://www.geeksforgeeks.org/lazy-propagation-in-segment-tree-set-2/

n = int(input())
array = list(map(int, input().split()))

MAX = n * n


class Node:
    def __init__(self, val, index, s, e):
        self.lazy = 0
        # for leaf node, store the value of array
        # for internal node, store the value of interval
        self.val = val
        self.index = index

        self.s = s
        self.e = e

        self.left = None
        self.right = None


class SegmentTree:
    def __init__(self, array):
        self.root = self.build(array)

    def build(self, array):
        def _build(array, s, e):
            if s == e:
                cur = Node(array[s], s, s, e)
                return cur
            mid = (s + e) // 2
            left = _build(array, s, mid)
            right = _build(array, mid + 1, e)

            if left.val < right.val:
                cur = Node(left.val, left.index, s, e)
            else:
                cur = Node(right.val, right.index, s, e)

            cur.left = left
            cur.right = right
            return cur

        root = _build(array, 0, len(array) - 1)
        return root

    def modify(self, s, e, diff):
        # add diff to all the array elements from s to e (inclusive)
        def _modify(cur, s, e, diff):
            if cur.s > e or cur.e < s:
                return cur.val, cur.index
            if cur.s == cur.e:
                cur.val += diff
                return cur.val, cur.index

            # note here [s, mid] is wrong because that 
            # [s, mid] may be larger than [s, e]
            
            left_val, left_index = _modify(cur.left, s, e, diff)
            right_val, right_index = _modify(cur.right, s, e, diff)

            if left_val < right_val:
                cur.val = left_val
                cur.index = left_index
            else:
                cur.val = right_val
                cur.index = right_index
            return cur.val, cur.index
        _modify(self.root, s, e, diff)

    def query(self, s, e):
        # return the index of the minimum of array from s to e (inclusive)
        def _query(cur, s, e):
            if cur.s > e or cur.e < s:
                return MAX, -1
            if cur.s == s and cur.e == e:
                return cur.val, cur.index

            mid = (cur.s + cur.e) // 2

            left_val, left_index = _query(cur.left, s, mid)
            right_val, right_index = _query(cur.right, mid+1, e)

            if left_val < right_val:
                return left_val, left_index
            else:
                return right_val, right_index

        val, index = _query(self.root, s, e)
        return val, index


def debug(tree):
    l = [tree.root]
    while l:
        next_l = []
        for node in l:
            print("(%d, %d): %d, %d\t" %
                  (node.s, node.e, node.val, node.index), end="")
            if node.left:
                next_l.append(node.left)
            if node.right:
                next_l.append(node.right)
        print()
        l = next_l


tree = SegmentTree(array)

result = [0 for i in range(n)]
cur = 1
while cur <= n:
    val, index = tree.query(0, n - 1)
    if index < n - 1:
        tree.modify(index + 1, n - 1, -cur)
    tree.modify(index, index, MAX)

    result[index] = cur
    cur += 1
print(" ".join(map(str, result)))
```

## Lazy Propagation

<https://www.geeksforgeeks.org/lazy-propagation-in-segment-tree/>

What if there are updates on a range of array indexes?
For example add 10 to all values at indexes from 2 to 7 in array. 



Lazy Propagation – An optimization to make range updates faster

When there are many updates and updates are done on a range, we can postpone some updates (avoid recursive calls in update) and do those updates only when required.



<https://www.geeksforgeeks.org/lazy-propagation-in-segment-tree-set-2/>

Given an array arr[] of size N. There are two types of operations:

1. Update(l, r, x) : Increment the a[i] (l <= i <= r) with value x.
2. Query(l, r) : Find the maximum value in the array in a range l to r (both are included).

### Example 

```
# https://codeforces.com/contest/1208/problem/D

from sys import stdin, stdout
input = stdin.readline
print = stdout.write

# 1. the right most 0 is the index of current minimum value
# 2. we abstract the current value for all the elements to the right
# 3. Then we can do recusion

# To find the last index with value zero,
# we can use segment tree to get range minimum query with lazy propagation.

# https://www.geeksforgeeks.org/lazy-propagation-in-segment-tree-set-2/

n = int(input())
array = list(map(int, input().split()))

MAX = n * n


class Node:
    def __init__(self, val, index, s, e):
        self.lazy = 0
        # for leaf node, store the value of array
        # for internal node, store the value of interval
        self.val = val
        self.index = index

        self.s = s
        self.e = e

        self.left = None
        self.right = None


class SegmentTree:
    def __init__(self, array):
        self.root = self.build(array)

    def build(self, array):
        def _build(array, s, e):
            if s == e:
                cur = Node(array[s], s, s, e)
                return cur
            mid = (s + e) // 2
            left = _build(array, s, mid)
            right = _build(array, mid + 1, e)

            if left.val < right.val:
                cur = Node(left.val, left.index, s, e)
            else:
                cur = Node(right.val, right.index, s, e)

            cur.left = left
            cur.right = right
            return cur

        root = _build(array, 0, len(array) - 1)
        return root

    def modify(self, s, e, diff):
        # add diff to all the array elements from s to e (inclusive)
        def _modify(cur, s, e, diff):
            # print("cur: [%d, %d], midify: [%d, %d], diff: %d" %
            #       (cur.s, cur.e, s, e, diff))
            if cur.s > e or cur.e < s:
                return cur.val + cur.lazy, cur.index

            if cur.s == s and cur.e == e:
                cur.lazy += diff
                return cur.val + cur.lazy, cur.index

            mid = (cur.s + cur.e) // 2
            
            # note here cur.lazy will affect [cur.s, cur.e]
            # while diff will only affect [s, e]
            _modify(cur.left, cur.s, mid, cur.lazy)
            _modify(cur.right, mid + 1, cur.e, cur.lazy)
            cur.lazy = 0
            
            if s - 1 < mid < e:                
                left_val, left_index = _modify(
                    cur.left, s, mid, diff)
                right_val, right_index = _modify(
                    cur.right, mid + 1, e, diff)
            else:
                left_val, left_index = _modify(
                    cur.left, s, e, diff)
                right_val, right_index = _modify(
                    cur.right, s, e, diff)

            if left_val < right_val:
                cur.val = left_val
                cur.index = left_index
            else:
                cur.val = right_val
                cur.index = right_index
            return cur.val, cur.index
        _modify(self.root, s, e, diff)

    def query(self, s, e):
        # return the index of the minimum of array from s to e (inclusive)
        def _query(cur, s, e):
            if cur.s > e or cur.e < s:
                return cur.val + cur.lazy, cur.index
            if cur.s == s and cur.e == e:
                return cur.val + cur.lazy, cur.index

            mid = (cur.s + cur.e) // 2
            if s - 1 < mid < e:
                left_val, left_index = _query(
                    cur.left, s, mid)
                right_val, right_index = _query(
                    cur.right, mid + 1, e)
            else:
                left_val, left_index = _query(
                    cur.left, s, e)
                right_val, right_index = _query(
                    cur.right, s, e)

            if left_val < right_val:
                return left_val + cur.lazy, left_index
            else:
                return right_val + cur.lazy, right_index

        val, index = _query(self.root, s, e)
        return val, index


def debug(tree):
    l = [tree.root]
    while l:
        next_l = []
        for node in l:
            print("[%d, %d]: %d+%d of %d" % (node.s, node.e, node.val, node.lazy, node.index), end=" | ")
            if node.left:
                next_l.append(node.left)
            if node.right:
                next_l.append(node.right)
        print()
        l = next_l


tree = SegmentTree(array)

result = [0 for i in range(n)]
cur = 1
while cur <= n:
    val, index = tree.query(0, n - 1)
    if index < n - 1:
        tree.modify(index + 1, n - 1, -cur)
    tree.modify(index, index, MAX)

    # debug(tree)

    result[index] = cur
    cur += 1
print(" ".join(map(str, result)))
```


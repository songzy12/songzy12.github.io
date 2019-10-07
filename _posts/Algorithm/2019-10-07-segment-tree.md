---
layout: post
title: "Segment Tree"
date: 2019-10-07T17:14:21+08:00
---



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
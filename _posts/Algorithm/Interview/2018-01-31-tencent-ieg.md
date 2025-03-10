---
layout: post
title: "Tencent IEG"
date: 2018-01-31 20:13:35 +0800
comments: true
categories: 
keywords: 
description: 

---

腾讯互娱校招面试算法题。

这个也是 LeetCode 原题：[Integer Break](https://leetcode.com/problems/integer-break/description/)

给定 $m\in N$,
$\max x_1\cdot x_2\dots x_{n-1}\cdot x_n$

s.t. $x_1+x_2+...+x_n = m$ and $x_i \in N $.

（面试官给的题目里 $m = 25$）

下面我们介绍两种解法，一种是使用动态规划的编程解，另一种是直接手算出答案的数学解。

### 动态规划

我们使用 `dp(m)` 表示将整数 `m` 进行如上拆分后所能得到的最大乘积。那么我们要的结果就是 `dp(25)`.

如何计算 `dp(m)` 呢？对于一般的情况，我们直接根据所拆分出来的第一个整数进行动态规划：

`dp(m)= max{i * dp(m-i)}` 其中，`i \in {1,...,m}`

这里为了便于计算我们将边界条件设为 `dp(0) = 1`

上面这个算法的复杂度是 `O(m^2)` ：首先我们需要计算 `dp(1),...,dp(m)` 这 `m` 个值，然后在计算每个值`dp(m_0)`的时候我们需要进行一个 `O(m_0)` 层的循环。

### 数学解法

首先我们假设分成的份数 `n` 是固定的，那么根据 [均值不等式](https://zh.wikipedia.org/wiki/%E7%AE%97%E6%9C%AF-%E5%87%A0%E4%BD%95%E5%B9%B3%E5%9D%87%E5%80%BC%E4%B8%8D%E7%AD%89%E5%BC%8F)我们有

$\prod\_{i=1}^n x\_i \le (\frac{\sum\_{i=1}^n x\_i}{n}) ^ n = (\frac{m}{n}) \^ n$

（几何平均值小于等于算术平均值）

上式取等的条件为各 $x_i$ 均相等。

也就是说，对于给定的 `n` ，我们要使得各份尽量均匀的情况下乘积最大。

下面我们考虑最优的 `n` 的取值。我们令 $g(n) = (\frac{m}{n})\^n$, 于是只需要求 $g(n)$ 的最大值。

求导，$g'(n)=((\frac{m}{n})\^n)'=(e^{n\ln(m/n)})'=e^{n\ln(m/n)}\cdot (n\ln(\frac{m}{n}))'$

因为 $(n\ln(\frac{m}{n}))'=ln(\frac{m}{n}) + n\cdot(ln(\frac{m}{n})')=ln(\frac{m}{n}) + n \cdot \frac{n}{m} \cdot (-\frac{m}{n\^2}) = ln(\frac{m}{n}) - 1$ 

从而 $g'(n) > 0\Leftrightarrow  ln(\frac{m}{n})-1 > 0 \Leftrightarrow ln(\frac{m}{n}) > 1\Leftrightarrow \frac{m}{n} > e \Leftrightarrow n < \frac{m}{e}$

也就是说，$g(n)$ 在 $(1, \frac{m}{e})$ 递增，在 $(\frac{m}{e}, +\infty)$ 递减。

所以 $g(n)$ 在 $n=\frac{m}{e}$ 时取最大值，也就是说对于给定的数 $m$, 我们希望分成 $\frac{m}{e}$ 份，也就是说我们希望每份分成的数值是 $e$. 这里的 $e=2.71828$. 

由于要求分成整数，所以我们应该分成尽量多的 3 和最多两个 2（因为我们可以把3个2变成2个3）

具体来讲，如果 m % 3 == 0，那就是 m / 3 个 3; m % 3 == 2 就是  m / 3 个 3 和 1 个 2；m % 3 == 1, 我们把多出来的 1 和它前面的那个 3 放一起拆成两个 2（2 * 2 > 1 * 3）, 就是 (m / 3 - 1) 个 3 和 2 个 2.

具体到 25，就是 25 = 3 * 7 + 2 * 2，最大的积为 $3\^7\times 2\^2$.

$\cdot$

### 其他问题

面试中遇到的其他问题包括：

1. 说说 word2vec 的不同方法：CBOW v.s. skip-gram
2. 说说 梯度弥散 v.s. 梯度爆炸
3. 说说 线性回归 v.s 逻辑回归
4. 说说 逻辑回归 中为什么使用 Sigmoid 函数
5. 说说 SGD v.s. BGD 
6. 说说除了 SGD 之外其他的 Optimizer:  Adagrad, Adam


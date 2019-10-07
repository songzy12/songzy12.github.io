---
layout: post
title: "Random Variable Expectation"
date: 2017-03-22 13:11:13 +0800
comments: true
categories: 

---

一枚硬币, 扔出 H 的概率为 $p$, T 的概率为 $q$, 计算首次扔出 $T\underbrace{H\dots H}_{k}​$ 所需投掷次数的数学期望。 


我们先来考虑 $\underbrace{H\dots H}_{k}$ 这样简单后的情形，然后试图将其推广到任意模式的一般情况。

记 随机变量 $X_k$ 为 首次投掷出 $\underbrace{H\dots H}_{k}​$ 所需的次数。

### Solution 1

设我们要求的数学期望为 $e$, 则有 

$$
e = q (1+e) + p q (2+e) + p p q (3+e) + p^{k-1} q (k+e) + p^k k 
$$

这是对前 $k$ 位可能出现的模式进行分类讨论得到的。

记 $S=1+2p+3p^2+\dots+kp^{k-1}$, 可得 $S=1/q((1-p^k)/q-kp^k)$.

```
  e 
= q(1+2p+3p^2+\dots+kp^{k-1})+kp^k+q(1+p+\dots+p^{k-1})e
= q\cdot 1/q ((1-p^k)/q-kp^k) + kp^k + q 1/q(1-p^k) e
= (1-p^k)/q + (1-p^k) e
```


从而

$$e = 1/q (1/p ^k - 1)$$

这与我们上面的结果是吻合的。

推广：首次投掷出 HTHHT

$$e = q(1+e) + pp(2+e) + pqq(3+e) + pqpq(4+e) + pqppp(5+e) + pqppq 5$$


### Solution 2

```
X_k = (X_{k-1} + 1)\cdot p + (X_{k-1} + 1 + X_k)\cdot q
X_0 = 0 
```

```
X_k = 1/p X_{k-1} + 1/p
```

```
X_k = 1/q (1/p ^k - 1)
```

而递推式的由来在于

```
  Pr(X_k = n) 
= Pr(X_{k-1} = n-1) p + \sum_m [ Pr(X_{k-1}=m) q Pr(X_{k}=n-m-1) ]
= p Pr(X_{k-1}+1 = n) + q \sum_m [ Pr(X_{k-1}=m) Pr(X_{k}+1=n-m) ] 
```

也就是

```
X_k = p (X_{k-1}+1) + q (X_{k-1}+X_{k}+1)
```

这是由于对于随机变量 `X, Y, Z`, 若 `Z=X+Y`，则

```
Pr(Z=n) = \sum_m [Pr(X=m) Pr(Y=n-m)]
```

递推法可以使得我们顺便求出所有的 `X_k` 

推广：首次投掷出 HTHHT

### Solution 3

If `f(x)` is the generating function of the probability `p_n` of the ending after `n` tosses

```
f(x) = \sum_n p_n x^n
```

Consider the following toss strings, probabilities, and terms

```
T								q			qx
HT								pq			pqx^2
HHT								p^2q		p^2qx^3
\underbrace{H\dots H}_{k-1}T	p^{k-1}q	p^{k-1}qx^k
\underbrace{H\dots H}_k			p^{k}		p^kx^k
```

We get the generating function of the probability of ending after `n` tosses to be

```
f(x) 
= \sum_m (\sum_{t=1}^k p^{t-1}qx^t)^m p^kx^k
= p^kx^k / (1-\sum_{t=1}^k p^{t-1}qx^t)
```

```
f'(1) = \sum p_n n = 
```

推广：首次投掷出 HTHHT

```
T		qx
HH		p^2x^2
HTT		pq^2x^3
HTHT	p^2q^2x^4
HTHHH	p^4qx^5
HTHHT	p^3q^2x^5
```

```
f(x) 
=\sum (qx+p^2x^2+pq^2x^3+p^2q^2x^4+p^4qx^5)^m p^3q^2x^5
=
```
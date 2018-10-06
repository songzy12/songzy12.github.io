---
layout: post
title: "Interprocess Communication and Networking"
date: 2016-12-24 14:24:44 +0800
comments: true
categories: Python

---

## subprocess

```
import subprocess as sub
p = sub.Popen(['your command', 'arg1', 'arg2', ...],stdout=sub.PIPE,stderr=sub.PIPE)
output, errors = p.communicate()
print output
```

## socket

* AF_INET: address family IPv4
* SOCK_STREAM: 数据流, TCP
* SOCK_DGRAM: 数据报, UDP

80端口是Web服务的标准端口。SMTP服务是25端口，FTP服务是21端口。端口号小于1024的是Internet标准服务的端口，端口号大于1024的，可以任意使用。

TCP连接创建的是双向通道，双方都可以同时给对方发数据。HTTP协议规定客户端必须先发请求给服务器，服务器收到后才发数据给客户端。

服务器可能有多块网卡，可以绑定到某一块网卡的IP地址上，也可以用0.0.0.0绑定到所有的网络地址，还可以用127.0.0.1绑定到本机地址。小于1024的端口号必须要有管理员权限才能绑定。

```
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# 监听端口:
s.bind(('127.0.0.1', 9999))
s.listen(5)
print 'Waiting for connection...'
while True:
    # 接受一个新连接:
    sock, addr = s.accept()
    # 创建新线程来处理TCP连接:
    t = threading.Thread(target=tcplink, args=(sock, addr))
    t.start()
    
def tcplink(sock, addr):
    print 'Accept new connection from %s:%s...' % addr
    sock.send('Welcome!')
    while True:
        data = sock.recv(1024)
        time.sleep(1)
        if data == 'exit' or not data:
            break
        sock.send('Hello, %s!' % data)
    sock.close()
    print 'Connection from %s:%s closed.' % addr   
```

```
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# 建立连接:
s.connect(('127.0.0.1', 9999))
# 接收欢迎消息:
print s.recv(1024)
for data in ['Michael', 'Tracy', 'Sarah']:
    # 发送数据:
    s.send(data)
    print s.recv(1024)
s.send('exit')
s.close()
```

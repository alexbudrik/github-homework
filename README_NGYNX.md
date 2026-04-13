# Задание 1: 
* Запустите два simple python сервера на своей виртуальной машине на разных портах
* Установите и настройте HAProxy, воспользуйтесь материалами к лекции по ссылке
* Настройте балансировку Round-robin на 4 уровне.
* На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.

  haproxy.cfg
```
global
    log /dev/log local0
    log /dev/log local1 notice
    daemon
defaults
    log     global
    mode    tcp
    option  dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000
frontend my_frontend
    bind *:8080
    default_backend my_backend
backend my_backend
    balance roundrobin
    server server1 127.0.0.1:8001 check
    server server2 127.0.0.1:8002 check
```
![ngynx](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/ngynx_1.png)

# Задание 2:
* Запустите три simple python сервера на своей виртуальной машине на разных портах
* Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
* HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
* На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy c использованием домена example.local и без него.

  haproxy.cfg
```
global
    log /dev/log local0
    daemon
defaults
    log global
    mode http
    option httplog
    timeout connect 5s
    timeout client  50s
    timeout server  50s
frontend http_front
    bind *:8080
    # Проверяем Host header
    acl is_example hdr(host) -i example.local
    use_backend example_backend if is_example
    default_backend deny_backend
backend example_backend
    balance roundrobin
    server s1 127.0.0.1:8001 weight 2 check
    server s2 127.0.0.1:8002 weight 3 check
    server s3 127.0.0.1:8003 weight 4 check
backend deny_backend
    http-request deny
```
![ngynx2](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/ngynx_2.png)
![ngynx3](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/ngynx_3.png)

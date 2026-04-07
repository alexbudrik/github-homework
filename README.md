# Задание 1: Установка Zabbix Server с веб-интерфейсом


## 1. Скачивание и уставнока repo

wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_latest+debian13_all.deb
sudo dpkg -i zabbix-release_latest+debian13_all.deb
sudo apt update

  --2026-...--  https://repo.zabbix.com/...
  Saving to: ‘zabbix-release_latest+debian13_all.deb’

  Selecting previously unselected package zabbix-release.
  Unpacking zabbix-release...
  Setting up zabbix-release...

  Hit:1 http://deb.debian.org/debian bookworm InRelease
  Get:2 https://repo.zabbix.com/zabbix/7.0/debian bookworm InRelease
  Reading package lists... Done

### 2. Установка пакетов Zabbix

sudo apt install zabbix-server-pgsql zabbix-frontend-php zabbix-apache-conf zabbix-agent postgresql
Reading package lists... Done
Building dependency tree... Done

  The following NEW packages will be installed:
    zabbix-server-pgsql zabbix-frontend-php zabbix-agent postgresql ...

  Need to get XX MB of archives.
  After this operation, XXX MB of disk space will be used.

  Setting up zabbix-server-pgsql ...
  Setting up zabbix-agent ...
  Setting up postgresql ...

#### 3. Установка PostgreSQL

sudo apt update
sudo apt install -y postgresql postgresql-contrib
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo -u postgres psql -c "\du"


   Reading package lists... Done
   Created symlink /etc/systemd/system/multi-user.target.wants/postgresql.service
   Starting PostgreSQL database server: postgresql.
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}

##### 4. Создание пользователя и базы данных для Zabbix

sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
sudo -u postgres psql -d zabbix -c "ALTER USER zabbix WITH SUPERUSER;"


 Enter password for Zabbix:
 Enter it again:

CREATE ROLE
CREATE DATABASE
ALTER ROLE

###### 5.Установка зависимостей

sudo apt install -y \
    build-essential libpcre3-dev libssl-dev libcurl4-openssl-dev libxml2-dev \
    libsnmp-dev libevent-dev libssh2-1-dev libmariadb-dev php-cli php-mbstring \
    php-gd php-bcmath php-xml php-pgsql apache2 wget tar make cmake


  Reading package lists... Done
  Building dependency tree... Done

  The following NEW packages will be installed:
    build-essential libpcre3-dev libssl-dev ...

  Setting up apache2 ...
  Setting up php-cli ...
  Setting up libxml2-dev ...

####### 6.Добавление репозиториев Zabbix и установка Zabbix Server

wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-1+debian12_all.deb
sudo dpkg -i zabbix-release_7.0-1+debian12_all.deb
sudo apt update
sudo apt install -y zabbix-server-pgsql zabbix-frontend-php zabbix-apache-conf zabbix-agent zabbix-sql-scripts

  Saving to: ‘zabbix-release_7.0-1+debian12_all.deb’

  Unpacking zabbix-release...
  Setting up zabbix-release...

  Get:1 https://repo.zabbix.com/zabbix/7.0/debian ...

  Setting up zabbix-server-pgsql ...
  Setting up zabbix-frontend-php ...
  Setting up zabbix-sql-scripts ...

5. Настройка конфигурации Zabbix Server
sudo -u postgres psql -d zabbix -f /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz
sudo nano /etc/zabbix/zabbix_server.conf
# Установите правильные параметры:
# DBName=zabbix
# DBUser=zabbix
# DBPassword=<ваш пароль>

Saving to: ‘zabbix-release_7.0-1+debian12_all.deb’

Unpacking zabbix-release...
Setting up zabbix-release...

Get:1 https://repo.zabbix.com/zabbix/7.0/debian ...

Setting up zabbix-server-pgsql ...
Setting up zabbix-frontend-php ...
Setting up zabbix-sql-scripts ...


######## 7.Запуск и проверка Zabbix Server
sudo systemctl daemon-reload
sudo systemctl enable zabbix-server
sudo systemctl restart zabbix-server
sudo systemctl status zabbix-server
sudo systemctl restart apache2

######### 8. Настройка веб-интерфейса

браузер: http://10.1.0.1/zabbix/setup.php
Вход в веб-интерфейс:
Логин: Admin
Пароль: zabbix

![runner](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/Screenshot%202026-03-09%20001637.png)

# Задание 2. Установка Zabbix Agent

## 1. Установка агента

sudo apt install zabbix-agent -y

### 2. Настройка агента

Редактируем:
sudo nano /etc/zabbix/zabbix_agentd.conf
Указываем:

Server=<10.0.2.3>
ServerActive=<10.0.2.3_ZABBIX_SERVER>
Hostname=<ABBIX_SERVER>

#### 3. Запуск агента

sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent

#### 4. Добавление хостов в Zabbix

Перейти в Configuration → Hosts
Нажать Create Host
Указать:
Hostname
IP адрес
Добавить группу (Linux servers)
Добавить шаблон:
Linux by Zabbix agent

![Hosts](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/Screenshot%202026-04-05%20195249.png)
![Server](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/Screenshot%202026-04-05%20195449.png)
![Agent](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/Screenshot%202026-04-05%20195513.png)
![AgentLogs](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/agent%20logs.png)
![AgentLastData](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/agent%20latest%20data.png)
![ServerLastData](https://github.com/alexbudrik/sys-pattern-homework/blob/main/screenshots/server%20latest%20data.png)

# part 6: GoAccess

проект выполнялся в докер контейнере на основе операционной системы Ubuntu:

![ubuntu version](img/ubuntu_version.png)

[документация goaccess](https://goaccess.io/get-started)

Для того, чтобы воспользоваться утилитой goaccess, были проделаны следующие действия:

1. ```apt update```
2. ```apt -y upgrade```
3. ```apt install goaccess```

После этого вызываем goaccess и передаем ему файл с логами:

```goaccess 20230127.log```

В появившемся окне выбираем при помощи клавиши **Space** 
формат логов "NCSA Combined log format" и жмём **Enter**

![goaccess setup](img/goaccess_setup.png)

Видим главное окно утилиты, на котором показана статистика, собранная из файла

![goaccess activate](img/goaccess.png)

Чтобы проверить, что мы не ошиблись, смотрим в поле "Hits", оно равно 991. 
Именно столько записей в нашем файле с логами

Перематываем вниз, смотрим раздел 13 "HTTP status codes"

Server errors: 444

Client errors: 333

Success: 214

![](img/goaccess_http_codes.png)

Выходим из goaccess, нажимаем **q**

Проверяем вручную при помощи утилит **awk**, **grep**, **wc** 
сколько соответствующих статус кодов в нашем файле:

![stats](img/check_statistics_by_hands.png)

Все сходится!

Применяем знания из проекта SimpleDocker.
Устанавливаем nginx, меняем настройки в файле /etc/nginx/nginx.conf

![](img/nginx_conf.png)

Создаем файл с репортом, который позже будем отдавать при помощи nginx

```goaccess 20230127.log -o report.html```

```nginx -s reload```

```nginx -g "daemon off;"```

Забыл упомянуть, что докер контейнер изначально 
был запущен с замапленными портами ```docker run -p 7890:7890 ubuntu```

![](img/docker_run.png)

Примерно вот так 

Радуемся открытому дашборду на localhost:7890 на локальной машине!

![](img/localhost-goaccess.png)

Задание выполнено! Идем дальше

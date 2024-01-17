# Part 9: Bonus. Your own node_exporter

## Создаем свой конфиг nignx

![](./img/nginx_config.png)

Вот так выглядит конфиг Prometheus:

![](./img/prometheus_config.png)

Вот такая картина в Prometheus targets:

![](./img/prometheus_nodes.png)

После этого при выборе метрик в Графане становятся доступны наши новые метрики,
прописанные в скрипте

![](./img/new_metrics.png)

После этого они начинают отображаться по адресу ```localhost:7890```

![](./img/metrics_on_localhost.png)

## stress

Вот так выглядят графики после запуска утилиты stress:

```stress -c 6 -i 5 -m 4 --vm-bytes 1000M -t 120s```

![](./img/stress_my_metrics.png)

## Запускаем скрипты из part 1, 2, 3

![](./img/scripts_work.png)

# Part 9: Bonus. Your own node_exporter

## Создаем свой конфиг nignx

![](./img/nginx_config.png)

Вот так выглядит конфиг Prometheus:

![](./img/prometheus_config.png)

После этого при выборе метрик в Графане становятся доступны наши новые метрики,
прописанные в скрипте

![](./img/new_metrics.png)

После этого они начинают отображаться по адресу ```localhost:7890```

![](./img/metrics_on_localhost.png)
Part 7. Prometheus и Grafana
== Задание ==

Установить и настроить Prometheus и Grafana на виртуальную машину
`Prometheus` получает метрики из разных сервисов и собирает их в одном месте.

`Node exporter` — небольшое приложение, собирающее метрики операционной системы и предоставляющее к ним доступ по HTTP. Prometheus собирает данные с одного или нескольких экземпляров Node Exporter.

`Grafana` — это вишенка на торте. Grafana отображает данные из Prometheus в виде графиков и диаграмм, организованных в дашборды.
#### Подключаем порты, чтоб получить доступ к веб интерфейсам Prometheus и Grafana с локальной машины
![](../../misc/images/7_01.png)

#### Устанавливаем Prometheus 

1. Обновляем систему
`sudo apt-get update`
![](../../misc/images/7_02.png)

2. Устанавливаем Node exporter `sudo apt-get install prometheus-node-exporter`
![](../../misc/images/7_03.png)

 - Проверяем как работает node-exporter http://localhost:9100/metrics
![](../../misc/images/7_04.png)

3. Устанавливаем Prometheus `sudo apt search prometheus`
![](../../misc/images/7_05.png)

 - Проверяем работу Prometheus

    http://localhost:9090/targets
![](../../misc/images/7_06.png)

    http://localhost:9090/graph
![](../../misc/images/7_07.png)
![](../../misc/images/7_08.png)
![](../../misc/images/7_09.png)

3. Устанавливаем grafana
 - делаем общую папку с локальной машиной (https://medium.com/macoclock/share-folder-between-macos-and-ubuntu-4ce84fb5c1ad)

 `sudo mount -t vboxsf shared_folder /home/student/mac_shared`
 - помешаем файл графаны в общую папку и запускаем установшика

 `sudo apt install /home/student/mac_shared/grafana_9.2.3_amd64.deb` (путь редактировать)

`sudo systemctl daemon-reload`

`sudo systemctl start grafana-server`

`sudo systemctl status grafana-server`

![](../../misc/images/7_10.png)

 - Заходим в  Gravana `http://localhost:3000` Логин: admin Пароль: admin далее Skip
https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/create-dashboard/
https://www.tigera.io/learn/guides/prometheus-monitoring/prometheus-metrics/ - примеры дашбордов

![](../../misc/images/7_11.png)


Добавить на дашборд Grafana отображение: 
- ЦПУ `100 - (avg by (instance) (irate(node_cpu_seconds_total{job="node",mode="idle"}[5m])) * 100)`
- Доступной оперативной памяти `node_memory_MemFree_bytes`
- Свободное место `node_filesystem_avail_bytes/node_filesystem_size_bytes*100`
- Кол-во операций ввода/вывода на жестком диске:
    `node_disk_io_now`
    `node_disk_io_now{device="sda"}`
    `node_disk_io_now{device="sr0"}`
    `node_disk_io_time_seconds_total{device="sda"}`

4. Тесты:
- Запустить ваш bash-скрипт из Части 2
Посмотреть на нагрузку жесткого диска (место на диске и операции чтения/записи) 
![](../../misc/images/7_13.png)
![](../../misc/images/7_13a.png)

- Установить утилиту stress `sudo apt-get install stress -y` 
![](../../misc/images/7_12.png)

и запустить команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`
![](../../misc/images/stress.png)
![](../../misc/images/stress_2.png)
Посмотреть на нагрузку жесткого диска, оперативной памяти и ЦПУ
![](../../misc/images/7_14.png)
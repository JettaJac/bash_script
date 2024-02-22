## `part_8`
1. Download the ready-made dashboard `Node Exporter Quickstart and Dashboard` from `Grafana Labs` official website. 
  > https://grafana.com/oss/prometheus/exporters/node-exporter/?tab=dashboards
  - ![](../../misc/images/8_01.png)
 Заходим на Dashboards, импорт из jcon `http://localhost:3000/dashboard/import` 
  - ![](../../misc/images/8_02.png)
  <!-- - http://localhost:3000 -->

2. Тесты:
- Запустить ваш bash-скрипт из Части 2
Посмотреть на нагрузку жесткого диска (место на диске и операции чтения/записи)
![](../../misc/images/8_04.png)
![](../../misc/images/8_05.png)

- Запустить команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`
![](../../misc/images/stress.png)


![](../../misc/images/stress_2.png)
Посмотреть на нагрузку жесткого диска, оперативной памяти и ЦПУ

![](../../misc/images/8_06.png)

3. Запустить ещё одну виртуальную машину, находящуюся в одной сети с текущей 
![](../../misc/images/8_03.png)

4. Запустить тест нагрузки сети с помощью утилиты iperf3

- `sudo apt install iperf3`
    `iperf3 -c 192.168.101.10 -f K`
    `iperf3 -s`
![](../../misc/images/8_07.png)
    
5. Посмотреть на нагрузку сетевого интерфейса
  - результат в графане 
  ![](../../misc/images/8_08.png)
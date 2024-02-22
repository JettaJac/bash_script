#!/bin/bash
. ../../code-samples/colors.sh

# Копируем конфиг nginx и перезапускаем
sudo cp ../../data-samples/nginx_part_9.conf /etc/nginx/nginx.conf 
sudo service nginx restart
sudo nginx -t

# http://localhost:9001
# http://localhost:9001/metrics
# http://localhost:9090/targets

# Передаем файл
# sudo service prometheus stop
sudo cp ../../data-samples/part_9.yml /etc/prometheus/prometheus.yml
# sudo service prometheus start
# sudo service prometheus status
sudo service prometheus restart

# Функция, собирающая метрики
function info() {
cpu="$(cat /proc/loadavg | awk '{print $1}')" # показатель загрузки средний за 1 мин
mem_avail="$(free | grep Mem | awk '{print $4}')" # свободная оперативная память
disk_avail="$(df /| grep / | awk '{print $4}')" # свободное место на диске

echo "# HELP cpu CPU info 1 min"
echo "# TYPE cpu gauge"
      echo "cpu $cpu"

echo "# HELP mem_avail available RAM"
echo "# TYPE mem_avail gauge"
      echo "mem_avail $mem_avail"

echo "# HELP disk_avail free disk space"
echo "## TYPE disk_avail gauge"
      echo "disk_avail $disk_avail"
}

# Передаем метрики в html-файл
echo -e "${COLOR[4]}для выхода нажмите${COLOR[2]}${BACK_COLOR[3]}control+c${RES}"
while true; do
  info > /home/student/Monitoring_2/data-samples/part_9.html
  sleep 3
done


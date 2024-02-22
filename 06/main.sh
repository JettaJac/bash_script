#!/bin/bash

chmod +x ins.sh

# Установка goaccess - утилита для работы с логами
if ! [[ -n $(dpkg -l | grep goaccess) ]];then
    sudo apt install goaccess -y
fi

# Установка nginx -веб-сервер
if ! [[ -n $(dpkg -l | grep nginx) ]];then
    sudo apt install nginx -y
fi

# Копируем конфиги в программу
  sudo cp ../../data-samples/nginx_part_6.conf /etc/nginx/nginx.conf
  sudo cp ../../data-samples/goaccess.conf /etc/goaccess/goaccess.conf

# Генерируется html файл и транслируется на localhost:1082
# Если меняется машина  - поменять локацию файла в конфиге nginx и настоить порты
  # sudo goaccess -f ../04/*.log --log-format=COMBINED -o ../../data-samples/index.html 
  sudo goaccess -f ../04/*.log --log-format=COMBINED -o report.html
  sudo service nginx restart 
  sudo nginx -t
  # http://localhost:3082/
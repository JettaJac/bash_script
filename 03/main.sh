#!/bin/bash

## Написать bash-скрипт который удаляет нужные вам файлы. Скрипт запускается с 1 параметром.
## Скрипт должен уметь очистить систему от созданных в задание 02 папок и файлов 3 способами:

## 1. По лог файлу
## 2. По дате и времени создания
## 3. По маске имени (т.е. символы, нижнее подчёркивание и дата). 



chmod +x check.sh
# . ./check.sh
./check.sh $1 $2 

RES="$(./check.sh $1 $2)"



if [ "$RES" == "" ]
then
    # Проверка на подачу только цифр
regex_folder_name='[A-Za-z]{5,}_(0?[1-9]|[12][0-9]|3[01])(0?[1-9]|1[012])[2][2-3]'
# echo "o!o"
    case $1 in

    # УДАЛЯЕМ ПО ЛОГУ
    1)  # Ишем по логу папки
        NUMBER=$(cat ../02/log.txt | awk '{print $1}')
        # NUMBER=$(wc -l log.txt | awk '{print $1}')

        # Удаляем папки, файлы и лог
        sudo rm -rf $NUMBER ../02/log.txt 

        # Другой способ поиска
        # echo "Цикл"
        # TMP=$(cat log.txt | awk 'NR==1')
        # for ((i=3; i<$NUMBER; i++))
        # do
        #     # echo "$LOG"
        #     echo "$i"
        #     # TMP=$(find $1 -type f | awk 'NR=='$i'{printf($1)}')
        #     TMP=$(echo "$TMP" | awk 'NR=='$i'{print $1}')
        #     # tthrhrth
        #     echo "$TMP"
        # done
    ;;

    # УДАЛЯЕМ ПО ДАТЕ СОЗДАНИЯ
    2)  # Заранее задаю дату для облегчения тестинга програмки
        date_f="$(date +"%y-%m-%d")"
        Date_Start="2022-12-24"
        Date_Finish="$date_f"
        Time_Start="00:00"
        Time_Finish="23:59"
        # 2022-12-23 11:00
        # 2022-12-31 19:50

        # Вводим время, с которого ищем
        read -p "Enter the start time in the following format (YYYY-MM-DD HH:MM): " Date_Start Time_Start

        ## Проверяем правильность ввода времени
        
        for ((data=1; data==1; ))
        do  
        
            if ! [[ "$(date "+%Y-%m-%d %H:%M" -d "$Date_Start $Time_Start" 2> /dev/null)" = "$Date_Start $Time_Start" ]]
            then
            # if ! [[ "$Date_Start" =~ '(([2]|[0]|[2][2-3])'-'(0?[1-9]|1[012])'-'(0?[1-9]|[12][0-9]|3[01]))' ]] #&& [[ "$Time_Start"='([1][1-9]|[2][0-3])':'([1-5][0-9]|[0-9' ]]    
            # then
                echo ""
                echo "You entered an invalid search start date, example: (YYYY-MM-DD HH:MM)"
                read -p "Enter the start time in the following format (YYYY-MM-DD HH:MM): " Date_Start Time_Start  
            else
                data=0     
                # echo "OK"
            fi
        done

        #Вводим время, по которое ищем
        read -p "Enter the end time in the following format (YYYY-MM-DD HH:MM): " Date_Finish Time_Finish
        
        ## Проверяем правильность ввода времени
        for ((data=1; data==1; ))
        do  
            if ! [[ "$(date "+%Y-%m-%d %H:%M" -d "$Date_Finish $Time_Finish" 2> /dev/null)" = "$Date_Finish $Time_Finish" ]]
            then
        #     if  [[ "$Date_Finish"='(0?[1-9]|[12][0-9]|3[01])'-'(0?[1-9]|1[012])'-'[2][2-3]' ]] && [[ "$Time_Finish"='([1][1-9]|[2][0-3])':'([1-5][0-9]|[0-9])' ]]    
                echo ""
                echo "You entered an invalid search end date, example: (YYYY-MM-DD HH:MM)"
                read -p "Enter the end time in the following format (YYYY-MM-DD HH:MM): " Date_Finish Time_Finish   
            else
                data=0     
                # echo "OK"
            fi
        done

        if ! [[ $(date -d "$Date_Start $Time_Start" +%s) -le $(date -d "$Date_Finish $Time_Finish" +%s) ]] 
        then
            echo "" 
            echo "ERROR! You entered an incorrect date, the Start Date must be before the End Date"
            exit
        elif [[ $(date "+%Y-%m-%d %H:%M" 2> /dev/null) < $(date -d "$Date_Finish $Time_Finish") ]] 
        then  
            echo "" 
            echo "ERROR! The start date is set incorrectly, it has not yet arrived"
            exit
        else
            echo ""    
        fi

        # echo "Дата старт_$Date_Start $Time_Start"
        # echo "Дата финиш_$Date_Finish $Time_Finish"
    
        # Ищем файлы по времени
        tmp_print="$(find / -type d -newermt "$Date_Start $Time_Start" ! -newermt "$Date_Finish $Time_Finish" 2>/dev/null | grep -E $regex_folder_name)" 
        # echo "$tmp_print"

        # Удаляем найденные файлы и лог
        sudo rm -rf $tmp_print ../02/log.txt
    ;;

    # УДАЛЯЕМ ПО МАСКИ ИМЕНИ
    3)  
    sudo rm -rf $(find / -type d 2>/dev/null | grep -E $regex_folder_name) ../02/log.txt
    ;;

esac
fi
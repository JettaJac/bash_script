#!/bin/bash

# Удаляем старый лог
rm -rf *.log

# Запуск проверки ввода параметра на правильность
chmod +x check.sh
./check.sh $1
RES=$(. ./check.sh $1)
# echo "$RES"

if [[ "$RES" == "" ]]
then 
    IP="125.125.125.125"
    # DATE=$(date | awk '{print $1" "$2" "$3}')
    DATE=$(date +%d/%b/%Y)

    DATE_N=$(date | awk '{print $2}')

    ##  Генерируем уникальные даты
    if [[ $DATE_N -gt 25 ]]
    then
        DATE_N=24 
    fi

    DATE_2=$(date +%d/%b/%Y | awk -F'/' '{print $2"/"$3}' )
    
    # echo "$DATE"

    # TIME0=$(date +%H:%M:00 | awk '{print $1}')
    # HOUR=$(date +%H:%M:00| awk -F':' '{print $1}')
    HOUR=8
    MIN=$(date +%H:%M:00| awk -F':' '{print $2}')
    MIN=58




for ((File=1; File < 6; File++))
do
    DATE=$(echo "$DATE_N/$DATE_2") 
    # echo "$DATE"
    Count_Record="$(shuf -i 100-1000 -n1)"
    # Count_Record=5
    
    for ((c=1, SEC=00; c <= Count_Record; c++))
    do
    # Генерируем уникальные IP
    IP=$(echo "$(shuf -i 1-125 -n1).$(shuf -i 1-125 -n1).$(shuf -i 1-125 -n1).$(shuf -i 1-125 -n1)")
    # Рандомно ввыодим заданные методы
    methods=$(shuf methods -n1)
    # Рандомно ввыодим заданные prot
    prot=$(shuf prot -n1)
    # Рандомно ввыодим заданные коды ошибок
    codes=$(shuf codes -n1)
    # Генерируем количество байт
    bites=$(shuf -i 12-999 -n1)
    # Рандомно ввыодим сайты
    request=$(shuf request -n1) 
    # Рандомно ввыодим заданных агентов
    agents=$(shuf agents -n1)  
    # Генерация чисел
    R_SEC="$(shuf -i 1-21 -n1)"
    # echo "R_SEC_$R_SEC"
    SEC=$((SEC+$R_SEC))

        

        # if [ "$#SEC" -lt 10 ]
        # then
        #     echo "lllll"
        #     S=0
        # else
        # echo "2lllll"
        #     S="" 
        # fi

        # Создаем последовательность времени, с прибавлением минут и часов
        if [ "$MIN" -gt 59 ]
            then
                HOUR=$((HOUR+1))
                MIN=0
            fi    
        # Создаем последовательность времени, с прибавлением дня
        # if [ "$HOUR" == 23 ] && [ "$MIN" -gt 58 ]
        #     then
        #         echo "hhh"
        #         # DATE=$((DATE+1))
        #         HOUR=0
        #     fi        


        if [ "$SEC" -gt 59 ]
        then
            MIN=$((MIN+1))
            SEC=0
        fi 

        if [ "${#SEC}" == 1 ]
        then
            S=0
        else
            S="" 
        fi

        if [ "${#MIN}" == 1 ]
        then
            M=0
        else
            M=""
        fi
        
        # echo "$HOUR"
        if [ "${#HOUR}" == 1 ]
        then
           H=0
        else
            H="" 
        fi 
            # for ((i=01; i < 60; i++))
            # do
            #     # echo "00000"
                # SEC=$((SEC+1))        
            # done   
        TIME=$(echo "$H$HOUR:$M$MIN:$S$SEC")
        ZONE="+0300"

        # Количество байтов, переданных в запрошенном объекте.
        # echo "ll"
        # Выводим запись nginx и добавляем ее в лог
        echo "$IP -- [$DATE":"$TIME" "$ZONE] \"$methods $prot\" $codes $bites \"$request\" \"$agents\""  >> $File.log
    done
    DATE_N=$((DATE_N+1)) 
done    
fi    

# Codes
# 200 OK («хорошо»)
# 201 Created («создано»)
# 400 Bad Request («неправильный, некорректный запрос»)
# 401 Unauthorized («не авторизован (не представился)»)
# 403 Forbidden («запрещено (не уполномочен)»)
# 404 Not Found («не найдено»)
# 500 Internal Server Error («внутренняя ошибка сервера»)
# 501 Not Implemented («не реализовано»)
# 502 Bad Gateway («плохой, ошибочный шлюз»)
# 503 Service Unavailable («сервис недоступен»)L»)
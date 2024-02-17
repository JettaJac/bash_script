#!/bin/bash
rm *.log

# Создаем новый лог
# > log.txt

# Запуск проверки ввода параметра на правильность
chmod +x check.sh
chmod +x rm.sh
./check.sh $1

RES=$(. ./check.sh $1)
# echo "$RES"

if [[ "$RES" == "" ]]
then 

    
    # echo "o!o"
    # -n - сортировка строк linux по числовому значению
    # -o - вывести результат в файл
    # -d - использовать для сортировки только буквы и цифры
    # -i - сортировать только по ASCII символах

    # $ sort опции файл
    # Или
    # $ команда | sort опции
    # Команда sort Linux позволяет не только сортировать строки, но и удалять дубликаты. Для этого есть опция -u:
    n_log=1
    for ((n_log=1; n_log < 6; n_log++))
    do
        cat ../04/$n_log.log 2>/dev/null >> all_log.log
    done

    for ((n_log=1; n_log < 6; n_log++))
    do
        # log=$(cat ../04/$n_log.log) 

        # 2>/dev/null
            case $1 in
            1) # Все записи, отсортированные по коду ответа
                # echo "1"

                # Cоздаем сортировку по всем записям во всех логах
                if ! [[ -f ./s_all_log.log ]]
                then
                    NUMBER=$(cat ./all_log.log 2>/dev/null | sort -k7 -n) >> s_all_log.log 
                    # echo "$NUMBER"
                    echo "$NUMBER" >> s_all_log.log 
                fi

                # Общий алгоритм
                NUMBER=$(cat ../04/$n_log.log 2>/dev/null | sort -k7 -n) >> s_$n_log.log 
                echo "$NUMBER" >> s_$n_log.log
                echo "$NUMBER"                
            ;;

            2) # Все уникальные IP, встречающиеся в записях

                # Cоздаем сортировку по всем записям во всех логах
                if ! [[ -f ./s_all_log.log ]]
                then
                    NUMBER=$(cat ./all_log.log 2>/dev/null | awk '{print $1}' | sort -u) 
                    echo "$NUMBER" >> s_all_log.log 
                fi

                # Общий алгоритм
                NUMBER=$(cat ../04/1.log 2>/dev/null | awk '{print $1}' | sort -u) >> s_$n_log.log 
                # awk '{print $1}' ../04/1.log
                echo "$NUMBER" >> s_$n_log.log
                echo "$NUMBER"
            ;;

            3) # Все запросы с ошибками (код ответа - 4хх или 5хх)
                # Cоздаем сортировку по всем записям во всех логах
                if ! [[ -f ./s_all_log.log ]]
                then
                    NUMBER=$(cat ./all_log.log 2>/dev/null | awk '$7 ~ /[45]/') 
                    echo "$NUMBER" >> s_all_log.log
                fi

                # Общий алгоритм
                NUMBER=$(cat ../04/1.log 2>/dev/null | awk '$7 ~ /[45]/') >> s_$n_log.log 
                echo "$NUMBER" >> s_$n_log.log
                echo "$NUMBER"   
            ;;

            4) # Все уникальные IP, которые встречаются среди ошибочных запросов
                # echo "4"
                
                # Cоздаем сортировку по всем записям во всех логах
                if ! [[ -f ./s_all_log.log ]]
                then
                    NUMBER0=$(cat ./all_log.log 2>/dev/null | awk '$7 ~ /[45]/')
                    NUMBER=$(echo "$NUMBER0" | awk '{print $1}' | sort -u) >> s_all_log.log 
                    echo "$NUMBER" >> s_all_log.log
                fi

                # Общий алгоритм    
                NUMBER0=$(cat ../04/1.log 2>/dev/null | awk '$7 ~ /[45]/')
                # echo "$(cat ../04/1.log | awk '{print $7}')"
                NUMBER=$(echo "$NUMBER0" | awk '{print $1}' | sort -u) >> s_$n_log.log
                echo "$NUMBER" >> s_$n_log.log
                echo "$NUMBER"
            ;;

        esac
    done        
fi
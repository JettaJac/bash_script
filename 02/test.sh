#!/bin/bash


for ((test=1 ; test==1; ))
do
        qwe="$(compgen -d / | shuf -n1)"
        mkdir $qwe/test 2>/dev/null
        path_test=$qwe/test
        if [[ -d $path_test ]]
        then
            echo "Путь рандом_$path_test"
            test=0
        # qwe="u/sbin"
        # echo "Путь рандом_$qwe"
        # if [[ "$qwe" -eq "/bin" ]]
        else
            echo "!!!!!!!!OOOOOPS! Неправильная директория_$qwe"
            test=1
        fi
        done

                # Функция, проверяющая, что у нас есть доступ к папке
        # if [[ -d $qwe ]]
        # then
        #     echo "Путь рандом_$qwe"
        # # qwe="u/sbin"
        # # echo "Путь рандом_$qwe"
        # # if [[ "$qwe" -eq "/bin" ]]
        # else
        #     echo "!!!!!!!!OOOOOPS! Неправильная директория_$qwe"
        # fi




        # Рандомно генерируем папку, в которой создаем файлы
        # PATH_RANDOM=/home/student/Monitoring_2
        # echo "_________________________$PATH_RANDOM"
        # qwe="$(compgen -d / | shuf -n1)"




        # PATH_RANDOM=/lost+found

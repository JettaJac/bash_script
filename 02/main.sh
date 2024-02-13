#!/bin/bash

## Написать bash-скрипт, который создает файлы и папки с определенными параметрами. 
## Скрипт запускается с 3 параметрами. 

## Пример запуска скрипта: ./main.sh az az.az 3Mb

## Параметр 1 - список букв английского алфавита, используемый в названии папок (не более 7 знаков). \
## Параметр 2 - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). \
## Параметр 3 - размер файла (в Мегабайтах, но не более 100)


# MEM=102

# Создаем новый лог
> log.txt
# rm log2.txt

# Делаем пометку начало работы программы
    START=$(date +"%H:%M:%C")
    START3=$(awk '{print $1}' /proc/uptime)
    
    PATH_START=$(pwd)
# Время начала работы программы
    echo "Starting the system: $START"    
    echo ""
    echo "Starting the system: $START" >> $PATH_START/log.txt
    echo "" >> $PATH_START/log.txt

# Запуск проверки ввода параметра на правильность
# Даем разрешеине и подключаем
chmod +x check.sh
chmod +x test.sh
. ./check.sh

# Проверяем на то что нам не подали больше 3 параметров
RES="$(./check.sh $1 $2 $3 $4)"


# Своя мини функция по генерации рандомно чисел
function number_random {
    START2=$(awk '{print $1}' /proc/uptime | awk -F'.' '{print $2}')         
    if [ "$START2" -eq 00 ]
    then
        START2=0
    elif [ "$START2" -lt 10 ]
    then            
        START2=$(echo "$START2" | awk -F'0' '{print $2}')
    fi
    echo "$START2"
}

if [ "$RES" == "" ]
then
    # Записываем первый параметр, как имя папки
    FolderName="$1"

    # Фиксируем последний символ имени папок
    FolderLastZnak=${1: (-1)}

    # Фиксируем из второго параметра начальное имени файла
    FileName0=$(echo "$2" | awk -F'.' '{print $1}')
    FileName=$FileName0

    # Фиксируем первый символ имени файла
    FileFirstZnak=${2:0:1}

    # Фиксируем последний символ имени файлов
    FileLastZnak=${FileName0: (-1)}

    # Фиксируем из второго параметра расширение файла
    FileExc=$(echo "$2" | awk -F'.' '{print $2}')
     
    # Обнуление счетчика файлов и папок
    FolderCount=1
    FileCount=1
    LEIG=0
   
    # Если заданные имена папок и файлов меньше 5 символов, дописываем до 5
    for ((i=${#FolderName}; i < 5; i++))
    do
        FolderName+=$FolderLastZnak
    done

    for ((i=${#FileName}; i < 5; i++))
    do
        FileName+=$FileLastZnak
    done
    FileName0=$FileName

    # Смотрим количество свободной памяти в системе
    MEM_NOW="$(df -m | awk '/sda/{print $4}')"
    # echo "Памяти до запуска создания папок_$MEM_NOW"

    # генерируем рандомно количество папок до 100 шт
    FolderRandom="$(shuf -i 1-100 -n1)"
# FolderRandom=100
    # Запускаем цикл по созданию вложенных папок до 100 шт
    for ((FolderCount=1; FolderCount<=100 && $MEM_NOW > $MEM && $LEIG == 0; FolderCount++))
    do
        # echo "Памяти сейчас_$MEM_NOW"

        # Генерируем количество создаваемых файлов в папке 
        FileRandom=$(number_random)
       
        # Генерируем имя
        FolderNamePrint="$FolderName"_$(date +"%d%m%y")
        # echo "$FolderNamePrint"
      
      


        for ((test=1; test==1; ))
        do
        cd ..
        #     echo "Путь рандом_до_$qwe"
            qwe="$(compgen -d / | shuf -n1)"
            sudo mkdir $qwe/test 2>/dev/null
            path_test=$qwe/test
            if [[ -d $path_test ]]
            then
                # echo "Путь рандом_после_$path_test"
                test=0
                sudo rm -rf $qwe/test 2>/dev/null
            fi
        done        

        # Условие ограничивающее возможность создания папок и файлов в папке /bin и /sbin
        if ! [[ "$qwe" == "/bin" || "$qwe" == "/sbin" ]]
        then
            # Создаем нашу папку через sudo
            PATH_RANDOM="$qwe"
            # PATH_RANDOM=/home/student/Monitoring_2/test_Monitoring
            sudo mkdir $PATH_RANDOM/$FolderNamePrint 2>/dev/null
            EXIT=0
            # Проверяем получилось создать папку, в данном случае ц=условие не актуально
            if [[ -d $PATH_RANDOM/$FolderNamePrint ]]
            then
                # echo "ПАПКА СОЗДАНА СУЩЕСТВУЕТ"
                # Записываем в лог инфу по созданной папке
                echo "$PATH_RANDOM/$FolderNamePrint   $(date +"%d.%m.%Y_%H:%M")" >> $PATH_START/log.txt
                
                # Проверяем количество свободной памяти, не должна привышать заявленной
                MEM_NOW="$(df -m | awk '/sda/{print $4}')"
                # echo "Память перед файлом $MEM_NOW"

# FileRandom=2000


                # Запускаем цикл по созданию файлов, каждый раз проверяя, чтоб оставался заявленный остаток свободной памяти            
                for ((FileCount=1; (FileCount<="$FileRandom" && $MEM_NOW > $MEM) && $EXIT == 0 && $LEIG == 0; FileCount++))
                do
                    # echo "Память cперед файлом_$MEM_NOW "
                    # echo "До _ $EXIT"
                    # Генерируем имя файла                
                    FileNamePrint="$FileName"_$(date +"%d%m%y.$FileExc")

                    Leight=$((${#PATH_RANDOM}+${#FolderNamePrint}+${#FileNamePrint}))
                    # echo "$Leight"
                    if [[ $Leight -gt 230 ]]
                    then
                        FileName="$FileFirstZnak""$FileName0"
                        FileName0=$FileName
                        # echo "OOOOOOOOOOOOO"
                    fi
                    
                    FileNamePrint="$FileName"_$(date +"%d%m%y.$FileExc")

                    Leight=$((${#PATH_RANDOM}+${#FolderNamePrint}+${#FileNamePrint}))
                    # echo "$Leight"
                    if [[ $Leight -gt 230 ]]
                    then
                        
                        echo ""
                        echo "STOP! Exceeded number of actual name variations"
                        echo ""
                        LEIG=1
                        # echo "внутри_ $EXIT"
                    fi
                    

                    # Создаем файл, заявленного размера
                    sudo fallocate -l $SIZE'M' $PATH_RANDOM/$FolderNamePrint/$FileNamePrint 2>/dev/null

                    # Выходит из программы, если последняя операция не выполнена                    
                    if [[ $? == 1 ]]
                    then                    
                        EXIT=1
                        # echo "$EXIT ___$?"
                        # # echo "ERROR! File not created"
                        # echo "ERROR! File $FileNamePrint not created"
                        # echo "ERROR! File $FileNamePrint not created" >> $PATH_START/log2.txt
                    else
                        echo "$PATH_RANDOM/$FolderNamePrint/$FileNamePrint  $(date +"%d.%m.%Y_%H:%M") $3" >> $PATH_START/log.txt
                        #   $SIZE Mb
                    fi
                    FileName+=$FileLastZnak

                    # 2>/dev/null
                    # truncate -s $SIZE'M' $PATH_RANDOM/$FolderNamePrint/$FileNamePrint
                    
                    # Записываем в лог инфу по созданному файлу 
                    
                    # truncate -s $SIZE'M' $FileNamePrint
                    # touch $FileNamePrint

                    # Генерируем новое уникальное имя файла добавлением последнего символа
                    

                    # Если в имени больше 200 символов, генерируем новое имя, добавлением первого символа в начало имени
                    
                    
                    # Проверяем количество свободной памяти, не должна привышать заявленной
                    MEM_NOW="$(df -m | awk '/sda/{print $4}')"
                done

                # В случае достижение заявленной отметки свободной памяти, выдает ошибку и заканчивает работу
                
                if [[ $MEM_NOW -lt $MEM ]]
                # if [[ 200 -gt $MEM ]]
                then
                    echo ""
                    echo "STOP! Out of memory"
                    echo ""
                fi
            else
                # Выдает запись, если нет доступа к папке
                echo "Cannot create directory $PATH_RANDOM/$FolderNamePrint: Permission denied" >> $PATH_START/log.txt
            fi
            cd

            # Генерируем новое уникальное имя папки добавлением последнего символа
            # FolderCount=$((FolderCount+1))
            FolderName+=$FolderLastZnak
        # else
        #     echo "SOS SOS SOS"
        fi
        # Проверяем количество свободной памятипосле создания всех файлов в папке, не должна привышать заявленной
        MEM_NOW="$(df -m | awk '/sda/{print $4}')"
        # echo "$MEM_NOW"
    done
fi

    
    FINISH=$(date +"%H:%M:%C")
    FINISH2=$(awk '{print $1}' /proc/uptime)

    # Время окончания работы программы
    echo ""
    echo "System shutdown: $FINISH"
    echo "" >> $PATH_START/log.txt
    echo "System shutdown: $FINISH" >> $PATH_START/log.txt
    echo ""

    # Считаем время работы программы
    DIF=$(echo "$FINISH2 - $START3" | bc -l )
    if [ "$DIF" \< "1" ]
    then
        T=0
    fi

    # Выводим время работы программы
    echo "System run time (sec) = $T$(echo "$DIF")"
    echo "System run time (sec) = $T$(echo "$DIF")" >> $PATH_START/log.txt

#!/bin/bash

## Написать bash-скрипт, который создает определенное количество папок и файлов по определенному пути. Скрипт запускается с 6 параметрами. 

## Пример запуска скрипта: 
## ./main.sh /../test_Monitoring/ 2 gf 4 sj.s 100kb
## Удаление файла по заданому пути
## rm -rf ../test_Monitoring/*_271222 log*

## **Параметр 1** - это абсолютный путь. \
## Параметр 2 - количество вложенных папок. \
## Параметр 3 - список букв английского алфавита, используемый в названии папок (не более 7 знаков). \
## Параметр 4 - количество файлов в каждой созданной папке. \
## Параметр 5 - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). \
## Параметр 6 - размер файлов (в килобайтах, но не более 100).  


## Запуск проверки ввода параметра на правильность
chmod +x check.sh
. ./check.sh
## ./check.sh $1 $2 $3 $4 $5 $6 $7

RES="$(./check.sh $1 $2 $3 $4 $5 $6 $7)"

PATH_START=$(pwd)
PATH_WORK=$1
echo $1

if [ "$RES" == "" ]
then

## Создаем лог
> log.txt
    FolderName="$3"
    FileName=$(echo "$5" | awk -F'.' '{print $1}')
    FileExc=$(echo "$5" | awk -F'.' '{print $2}')
    FolderLastZnak=${3: (-1)}
    FileLastZnak=${FileName: (-1)}

    FileName0=$FileName
    FileName00=$FileName0

    ## Фиксируем первый символ имени файла
    FileFirstZnak=${5:0:1}

    FolderCount=1
    FileCount=1
    LEIG=0
    
    ## Если заданные имена папок и файлов меньше 4 символов, дописываем до 4
    for ((i=${#FolderName}; i < 4; i++))
    do
            FolderName+=$FolderLastZnak
    done

    for ((i=${#FileName}; i < 4; i++))
    do
        FileName+=$FileLastZnak
    done
    FileName0=$FileName
    
    FolderNum=0
    FileNum_s=0
    EXIT=0

    ## Создаем папки в заданном количестве
    ## if [[ $FolderCount -lt $2 ]]
    for ((FolderCount=1; FolderCount<=$2 && $EXIT < 1; FolderCount++))
    do
        if [[ LEIG==1 ]]
        then
            FileName=$FileName00
            LEIG=0
        fi

        FolderNamePrint="$FolderName"_$(date +"%d%m%y")
        PATH_WORK=$(pwd)
        cd $PATH_WORK || exit
        
        FileNum=0
            
        ## Проверяем, есть ли такая папка уже, если нет, то создаем
        if [[ -d $PATH_WORK/$FolderNamePrint ]]
        then
            echo ""
            echo "ERROR! Folder $FolderNamePrint  and others already created " 
            echo "ERROR! Folder $FolderNamePrint already created" >> $PATH_START/log.txt
        else 
            mkdir $FolderNamePrint 2>/dev/null
            FolderNum=$((FolderNum+1))
        fi    

        ## Проверяем, что у нас получилось создать папку
        if [[ -d $PATH_WORK/$FolderNamePrint ]]
        then
            echo "$PATH_WORK/$FolderNamePrint   $(date +"%d.%m.%Y_%H:%M")" >> $PATH_START/log.txt
            cd $FolderNamePrint
            EXIT=0
            
            # Создаем заявленное число файлов
            for ((FileCount=1; FileCount<=$4 && $EXIT < 1; FileCount++))
            do

            FileNamePrint="$FileName"_$(date +"%d%m%y.$FileExc")
            
            # Определяем длину пути и имени файла
            Leight=$((${#PATH_WORK}+${#FolderNamePrint}+${#FileNamePrint}))

            # Если она превышает, обнуляем и генерируем новое уникальное
            if [[ $Leight -gt 230 ]]
            then
                FileName="$FileFirstZnak""$FileName0"
                FileName0=$FileName
            fi
            
            FileNamePrint="$FileName"_$(date +"%d%m%y.$FileExc")

            Leight=$((${#PATH_WORK}+${#FolderNamePrint}+${#FileNamePrint}))
            ## echo "2_$Leight"
            if [[ $Leight -gt 200 ]]
            then
                
                echo ""
                echo "STOP! Exceeded number of actual file name variations"
                echo ""
                EXIT=1
                
                ## echo "внутри_ $EXIT"
            fi

            Already=0

            if  [[ $(df -m  | awk '/sda/{print $4}') -gt $MEM ]]
            then
                FileNamePrint="$FileName"_$(date +"%d%m%y.$FileExc")

            ## Проверяет, если уже файл создан, то он выдвет запись в лог о дублирование.
            if ! [[ -f $PATH_WORK/$FolderNamePrint/$FileNamePrint ]]
            then    
                fallocate -l $SIZE'K' $FileNamePrint 2>/dev/null

                ## Выходит из программы, если последняя операция не выполнена
                if [[ $? -gt 1 ]]
                then
                    EXIT=1
                    echo "ERROR! File not created"
                    echo "ERROR! File $FileNamePrint not created" > $PATH_START/log.txt
                fi

                echo "$PATH_WORK/$FolderNamePrint/$FileNamePrint    $(date +"%d.%m.%Y_%H:%M")  $6" >> $PATH_START/log.txt
                
                ## Счетчики созданных файлов
                FileNum=$((FileNum+1))
                FileNum_s=$((FileNum_s+1))

            else   
                Already=1
                FileAlready=$FileNamePrint                
               ## ## continue
            fi

            
            ## Если в имени больше 200 символов, генерируем новое имя, добавлением первого символа в начало имени          
                # if [ ${#FileNamePrint} -gt 230 ]
                # then
                #     FileName="$FileFirstZnak""$FileName0"
                #     FileName0=$FileName
                # fi

            FileName+=$FileLastZnak

            else
                echo "ATTENTION! Memory less than $MEM2 Gb"
            fi
            done

            # ## Выводим ошибку, если у нас в папке уже есть файлы с таким именем
            # if [[ Already -eq 1 ]]
            # then
            #     echo ""
            #     echo "ERROR! File $FileAlready  and others already created " 
            #     echo "ERROR! File $FileAlready already created" >> $PATH_START/log.txt
            #     # echo "STOP! Exceeded number of actual file name variations"
            #     echo "" 
            #     echo "Сейчас в папке $FolderNamePrint всего создано $FileNum файлов"
            #     echo ""                
            # fi
            
            cd ..

            ## FolderCount=$((FolderCount+1))
            FolderName+=$FolderLastZnak
            ## echo "$FolderCount"
            ## echo "PastFile_$FolderName"
        else
            echo "ERROR! Cannot create directory in $PATH_WORK/: Permission denied" >> $PATH_START/log.txt
            echo "ERROR! Cannot create directory in $PATH_WORK/: Permission denied"
            exit
        fi
    done

    echo "Total $FolderNum folders and $FileNum_s files created, details about created folders and files"
fi

#!/bin/bash

## Задаем ограничение по свободной памяти
MEM=1024
MEM2=$((MEM/1024))

SIZE=$(echo "$6" | awk -F'k' '{print $1}')

## Проверка ввода параметра на правильность
## Проверка на то, что нет 7 параметра
if [[ -n $7 ]]
then
    echo "ERROR! More than 6 parameters entered"

## Проверка, что подаеться 6 параметров
elif [[ -n $6 ]]
then

    ## Проверка первого параметра, что это директория
    if ! [[ -d $1 ]]
    then
        echo "ERROR! Directory not specified correctly"
    
    ## Проверка первого параметра (абсолютный путь)    
    elif ! [[ ${1:0:1} = "/" ]]
    then 
        echo "ERROR! Path specified incorrectly, enter an absolute path starting with '/'"

    ## Проверяем, что нам здесь подают число (количество папок)
    elif ! [[ "$2" =~ ^[0-9]+$ ]]
    then
        echo "ERROR! The second parameter is incorrect, enter the number of subfolders"
    
    ## Проверяем, что только буквы английского алвафита, до 7 шт     
    elif ! [[ "$3" =~ ^[A-Za-z]+$ ]] || [ $(expr length "$3") -gt 7 ]
    ## (( $(expr length "$3") > "7" ))
    then       
        echo "ERROR! The third parameter is incorrect, enter the letters of the English alphabet used in the name of the folders"
        if [ $(expr length "$3") -gt 7 ]
        then    
            echo "File name must be up to 7 characters"
        fi

    ## Проверяем, что нам здесь подают число (количество файлов)
    elif ! [[ "$4" =~ ^[0-9]+$ ]]
    then
        echo "ERROR! The fourth parameter is incorrect, please enter the number of files in each folder"

    ## Проверяем, что только буквы, до 7 шт и после точки для расширения только 3 знака
    elif ! [[ "$5" =~ ^[A-Za-z]{1,7}'.'[A-Za-z]{1,3}$ ]]
    ## elif ! [[ "$5" =~ ^[A-Za-z].[A-Za-z]+$ ]] || [ $(expr length "$3") -gt 7 ]
    then
        echo "ERROR! The fifth parameter is incorrect, enter file names in English letters, with the extension through '.'"
        if [[ "$5" =~ ^[A-Za-z]{7,}'.'[A-Za-z]{1,3}$ ]]
        then
            echo "File name must be up to 7 characters"
        elif  [[ "$5" =~ ^[A-Za-z]{1,7}'.'[A-Za-z]{3,}$ ]]
        then
            echo "Extension must be up to 3 characters"
        else
            echo "Example 'name.txt'"
        fi
    ## elif  [[ "$6" == 01 ]]
    ## ##  elif ! [[ "$6" =~ ^[0-9]{1,3}[kb]+$ ]] || [[ ${TMP%kb} -gt 100 ]]
    ## then
  
    ## Проверяем, что файл в Кб и до 100Кб 
    elif ! [[ "$6" =~ ^[0-9]{1,3}[kb]+$ ]] || [[ $SIZE -gt 100 || $SIZE -lt 1 ]]
    ##  elif ! [[ "$6" =~ ^[0-9]{1,3}[kb]+$ ]] || [[ ${TMP%kb} -gt 100 ]]
    then
        echo "ERROR! The sixth parameter is incorrect, enter file parsing in kilobytes, example 3kb (from 1 to 100 kb)"

    ## Проверка, на остаток свободной памяти, в соответствие с задаными условиями
    elif ! [[ $(df -m  | awk '/sda/{print $4}') -gt $MEM ]]
    then
        echo "ERROR! Memory less than $MEM2 Gb"
    fi 
else
    echo "ERROR! Less than 6 parameters entered"
fi
     



## length=$(expr length "$3")
## echo "Длина моей строки $length"


## if ! [[ "$5" =~ ^[A-Za-z]{2,7}$ ]] #|| [ $(expr length "$3") -gt 7 ]
## if ! [[ "$5" =~ ^[A-Za-z]{2,7}.[A-Za-z]{1,3}$ ]] #|| [ $(expr length "$3") -gt 7 ]
    ## elif ! [[ "$5" =~ ^[A-Za-z].[A-Za-z]+$ ]] || [ $(expr length "$3") -gt 7 ]

    ## =~ ^[A-Za-z]+$   (?=.{1,7}+$)
##     then
##         echo "ERROR!"
##         ## {2} {2,5}
## fi        


## Проверка на остаток свободной памяти 1 Gb
## free -m | awk 'NK==2{print $4}'
## echo "$(free -m | awk 'NR==2{print $4}')"
## if [[ $(free -m | awk 'NR==2{print $4}') -gt 1025 ]]
   
## SIZE=$Sizcd ..ZE_$SIZE"
## if ! [[ ${1: -1} = "/" ]]
## then
##     ## "$1"="$1+/"
##     $1=$2
##     echo "$1"
## fi

 
## rm -rf di* s* log* && ls
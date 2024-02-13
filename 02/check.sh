#!/bin/bash

# Задаем ограничение по свободной памяти 
MEM=1030
MEM2=$((MEM/1024))


# Проверка ввода параметра на правильность
# Проверка на наличие 4 параметра
if [[ -n $4 ]]
then
    echo "ERROR! More than 3 parameters entered"

# Проверка, что подаем 3 параметра    
elif [[ -n $3 ]]
then
    # Определяем размер файлов, что требуеться создать
    SIZE=$(echo "$3" | awk -F'M' '{print $1}')
    
    # Проверка первого параметра, подаем только буквы английского алвафита до 7 шт (имя папки)
    if ! [[ "$1" =~ ^[A-Za-z]+$ ]] || [ $(expr length "$3") -gt 7 ]
    # (( $(expr length "$3") > "7" ))
    then       
        echo "ERROR! The first parameter is incorrect, enter the letters of the English alphabet used in the name of the folders"
        if [ $(expr length "$1") -gt 7 ]
        then    
            echo "File name must be up to 7 characters"
        fi
    # Проверка второго параметра подаем только буквы английского алвафита до 7 шт, после точки до 3 символов (имя файла) 
    elif ! [[ "$2" =~ ^[A-Za-z]{1,7}'.'[A-Za-z]{1,3}$ ]]
    # elif ! [[ "$5" =~ ^[A-Za-z].[A-Za-z]+$ ]] || [ $(expr length "$3") -gt 7 ]
    then
        echo "ERROR! The second parameter is incorrect, enter file names in English letters, with the extension through '.'"
        if [[ "$2" =~ ^[A-Za-z]{7,}'.'[A-Za-z]{1,3}$ ]]
        then
            echo "ERROR! File name must be up to 7 characters"
        elif  [[ "$2" =~ ^[A-Za-z]{1,7}'.'[A-Za-z]{3,}$ ]]
        then
            echo "Extension must be up to 3 characters"
        else
            echo "Example: 'name.txt'"
        fi

    # Проверка третий параметр, подаем число от 1 до 100 и размерность   
    elif ! [[ "$3" =~ ^[0-9]{1,3}[Mb]+$ ]] || [[ $SIZE -gt 100 || $SIZE -lt 1 ]]
        #  elif ! [[ "$6" =~ ^[0-9]{1,3}[kb]+$ ]] || [[ ${TMP%kb} -gt 100 ]]
    then
        echo "ERROR! The third parameter is incorrect, enter file parsing in megabytes, example 3Mb (up to 100Mb)"
    
    # Проверка, на остаток свободной памяти, в соответствие с задаными условиями    
    elif ! [[ $(df -m  | awk '/sda/{print $4}') -gt $MEM ]]
    then
        echo ""
        echo "ERROR! Memory less than $MEM2 Gb"  
        echo ""
    fi 
else
    echo "ERROR! Less than 3 parameters entered"
fi
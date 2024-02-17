#!/bin/bash

if [[ -n $2 ]]
    then
        echo "ERROR! More than 1 parameters entered"
    elif [[ $# == 0 ]]
    then
        echo "ERROR! Less than 1 parameters entered"
    elif [[ "$1" =~ ^[1-4]$ ]]
    then
        echo ""
    else
        echo "ERROR! Less than 1 parameters entered введенно не правильное значение, надо или 1 2 3 (возможно через ифелс)"
fi
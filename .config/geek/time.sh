#!/bin/sh

hour=$(date "+%-I")
for ((i=0; i <= 12; i++)) ; do
    if [ $i -eq $hour ]; then
        printf "\033[1;35m|\033[0m              "
    elif [ $(($i % 12)) == 0 ]; then
        printf ":              "
    else
        printf "%s              " -
    fi
done

printf "\n\n"

min=$(date "+%-M")
for ((i=0; i <= 60; i++)) ; do
    if [ $i -eq $min ]; then
        printf "\033[1;35m|\033[0m  "
    elif [ $(($i % 10)) == 0 ]; then
        printf ":  "
    else
        printf "%s  " -
    fi
done

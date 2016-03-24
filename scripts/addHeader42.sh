#!/bin/sh

if [[ ! -e ./includes || ! -e ./srcs ]]
then
    echo "ERROR : directory 'includes' and/or 'srcs' not found !"
    exit
fi

SRCS=$(ls srcs | grep "\.c" | grep -v "\~")
for FILE in $SRCS
do
    echo $FILE
    /usr/bin/vim +Stdheader +wq "srcs/$FILE"
done

INCS=$(ls includes | grep "\.h" | grep -v "\~")
for FILE in $INCS
do
    echo $FILE
    /usr/bin/vim +Stdheader +wq "includes/$FILE"
done

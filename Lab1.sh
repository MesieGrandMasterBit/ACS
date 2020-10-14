#!/bin/bash

#В проекте должен обрабатываться аргумент "--help|-h" для вывода справки, в которой отображаются:
#Авторы;
#Все доступные аргументы;
#Краткое описание проекта;
#Примеры запуска.

IFS=$'\n'
echo "Доступные функции программы
-h - получить справку
-I - вывод сетевых интерфейсов
-U - отключение/включение интерфейса
-In - установка IP/Mask/Gateway для определённого интерфейса
-L - отображение сетевой статиститки
-e - exit"

while true
read var
do
case "$var" in
-h) echo "Доступные команды
-a -авторы
-ar - все доступны аргументы
-readme - краткое описание проекта
-example - примеры запуска "
read v
if [ -n $v ]
then
case "$v" in
-a) echo "	Высотин Кирилл Евгеньевич
		Пахомов Илья Максимович
		Юрьев Юрий Вадимович"
;;
-ar) echo " -h -I -U -In -K -L -M -e "
;;
-readme) echo "Функционал программы включает в себя:
а)Вывод сетевых интерфейсов
б)Отключение/включение интерфейса
в)Установка IP/Mask/Gateway для определённого интерфейса
д)Отображение сетевой статиститки"
;;
-example) echo "Всем ку, уважаемые дамы и господа"
;;
-*) echo "Неизвестное действие"
exit 1
;;
esac
fi
;;
-I) ip link show
;;
-U) ip link show
echo "Отключить -d, включить -u"
read v
if [ -n $v ]
then
case "$v" in
-u) echo "Введите интерфейс, который хотите включить:"
read int
sudo ifconfig $int up
ip link show
;;
-d) echo "Введите интерфейс, который хотите отключить:"
read int
sudo ifconfig $int down
ip link show
;;
-*) echo "Неизвестное действие"
;;
esac
else exit 1
fi
;;

-In)
#ifconfig eth0 192.168.33.42 netmask 255.255.0.
#Измените два последних символа в MAC-адресе вашей сетевой карты.
#ifconfig eth0 hw ether 08:00:27:ab:67:XX
ifconfig
echo "Введите имя интерфейса сети "
read link
echo "	-M - изменить маску
 	-Ip - изменить ip
	-G - изменить Gateway"
read v
if [ -n $v ]
then
case "$v" in
-M) echo "Введите маску "
read int
sudo ifconfig $link netmask $int
ifconfig
;;
-Ip) echo "Введите новый ip"
read int
sudo ifconfig $link $int
ifconfig
;;
-G) echo "Введите ip адрес шлюза, который нужно заменить:"
read int
sudo ip route del default via $int dev $link
ifconfig
echo "Введите новый ip адрес шлюза:"
read int
sudo ip route add default via $int dev $link
ifconfig
;;
-*) echo "Неизвестное действие"
;;
esac
else exit 1
fi
;;
-L) #Отображение сетевой статистики https://itproffi.ru/otslezhivanie-sostoyaniya-seti-v-..
#https://itproffi.ru/otslezhivanie-sostoyaniya-seti-v-..
netstat #netstat -a | more ||-atu
;;
-e) return 0
;;

esac
done

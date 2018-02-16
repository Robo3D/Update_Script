# -*- coding: utf-8 -*-
# @Author: Matt Pedler
# @Date:   2018-02-16 09:48:42
# @Last Modified by:   Matt Pedler
# @Last Modified time: 2018-02-16 10:53:35

import serial

def open_serial(port, speed):
    #create serial instance
    mainboard = serial.Serial(port, speed)

    #check if serial is closed or not
    if mainboard.is_open:
        mainboard.close()

    #open serial port
    mainboard.open()
    while mainboard.is_open:
        line = mainboard.readline()
        print line
        pc = get_percent(line)
        print pc

        #calculate if we are done
        if pc >= 100.00:
            mainboard.close()

    exit(0)


        
def get_percent(line):
    acceptable_chars = ['0','1','2','3','4','5','6','7','8','9','.']
    number = []
    for char in line:
        if char in acceptable_chars:
            number.append(char)

    number_string = ''.join(number)

    try:
        percent = float(number_string)
        return percent
    except Exception as e:
        print "ERROR"
        print number_string

   

open_serial('/dev/ttyACM0', 115200)



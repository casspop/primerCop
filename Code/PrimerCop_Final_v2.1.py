# PrimerCop_Final.py for Micropython on Pi Pico
# Copyright (C) 2022 Gregory A Sanders
# Rename to main.py and upload to Pico
# along with lcd_api.py and pico_i2c_lcd.py
# v2.1.1 - December 2022
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.

from utime import sleep, sleep_ms
import utime
from machine import Pin, PWM, I2C, Timer
import micropython
from pico_i2c_lcd import I2cLcd

i2c = I2C(0, sda=Pin(0), scl=Pin(1), freq=400000)
I2C_ADDR = i2c.scan()[0]
lcd = I2cLcd(i2c, I2C_ADDR, 2, 16)

micropython.alloc_emergency_exception_buf(100)
buzzer = PWM(Pin(2))
topIR = Pin(12, Pin.IN, Pin.PULL_UP)
bottomIR = Pin(14, Pin.IN, Pin.PULL_UP)
pausepin = Pin(16, Pin.IN, Pin.PULL_UP)
pluspin = Pin(17, Pin.IN, Pin.PULL_UP)
minuspin = Pin(18, Pin.IN, Pin.PULL_UP)

timer = Timer()

status = {12:0,14:3,16:0,17:0,18:0}
primercount = 0



def db16(pin):
    timer.init(mode=Timer.ONE_SHOT, period=200, callback=cb16)

def db17(pin):
    timer.init(mode=Timer.ONE_SHOT, period=200, callback=cb17)

def db18(pin):
    timer.init(mode=Timer.ONE_SHOT, period=200, callback=cb18)

def buzz():
    buzzer.freq(500)
    buzzer.duty_u16(1000)
    sleep(0.1)
    buzzer.duty_u16(0)

def beep():
    buzzer.freq(800)
    buzzer.duty_u16(1000)
    sleep(0.1)
    buzzer.duty_u16(0)

def warn():
    buzzer.freq(500)
    buzzer.duty_u16(1000)


def irqsetup():
    topIR.irq(trigger=Pin.IRQ_FALLING | Pin.IRQ_RISING, handler=cb12)
    bottomIR.irq(trigger=Pin.IRQ_FALLING | Pin.IRQ_RISING, handler=cb14)

    pluspin.irq(trigger=Pin.IRQ_FALLING, handler=db16)
    minuspin.irq(trigger=Pin.IRQ_FALLING, handler=db17)
    pausepin.irq(trigger=Pin.IRQ_FALLING, handler=db18)

def cb12(pin):
    global status,primercount
  
    if pin.value()==0:                 # blocked
        primercount = primercount + 1
        lcd.clear()
        lcd.putstr("Get primer " + str(primercount))
        status[12] = 1
        status[14] = 0
        buzz()

    if pin.value()==1:                # cleared
        status[12] = 0
        lcd.clear()
        lcd.putstr("Loaded primer " + str(primercount))
        beep()

def cb14(pin):
    global status,primercount
    if status[14] == 0 and pin.value() == 0:      ## blocked going down
        status[14] = 1
        lcd.clear()
        lcd.putstr("Seat primer.")
        warn()

    if status[14] == 1 and pin.value() == 1:      ## cleared going down
        status[14] = 2
        lcd.clear()
        lcd.putstr("Seating.")
        beep()
        sleep(0.2)

    if status[14] == 2 and pin.value() == 0:      ## blocked going up
        lcd.clear()
        lcd.putstr("Ready")
        lcd.move_to(0,1)
        if primercount == 1:
            primer = "primer"
        else:
            primer = "primers"
        lcd.putstr("Used " + str(primercount) + " " + primer + ".")
        status[14] = 3

def cb16(tim):
    global status,primercount
    status[16] += 1
    primercount += 1
    lcd.clear()
    lcd.putstr("Add 1 primer.")
    lcd.move_to(0,1)
    lcd.putstr("Count is : " + str(primercount))

def cb17(tim):
    global status,primercount
    status[17] += 1
    primercount -= 1
    lcd.clear()
    lcd.putstr("Minus 1 primer.")
    lcd.move_to(0,1)
    lcd.putstr("Count is : " + str(primercount))


def cb18(tim):
    global status,primercount
    status = {12:0,14:3,16:0,17:0,18:0}
    primercount = 0
    lcd.clear()
    lcd.putstr("Reset")
    sleep(2)
    lcd.clear()
    lcd.putstr("PrimerCop Ready")
    lcd.move_to(0,1)
    lcd.putstr("Primer count: " + str(primercount))

irqsetup()
lcd.clear()
lcd.putstr("PrimerCop v2.1.1")
lcd.move_to(0,1)
lcd.putstr("2022 drgerg.com")
sleep(3)
lcd.clear()
lcd.putstr("PrimerCop Ready")
lcd.move_to(0,1)
lcd.putstr("Primer count: " + str(primercount))


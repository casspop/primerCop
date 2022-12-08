# PrimerCop.py - 2022 Gregory A Sanders
# Rename: main.py and upload to Pi Pico
# along with lcd_api.py and pico_i2c_lcd.py
#
from utime import sleep, sleep_ms
import utime
from machine import Pin, PWM, I2C
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

status = "bc"
primercount = 0
cntstart = 0
prevstatus = ""

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

def top_handler(tpin):
    global status, primercount,cntstart
    topIR.irq(handler=None)    # type: ignore

    if status == "bc" and tpin.value()==0:  # blocked
        cntstart = utime.time() # type: ignore
        primercount = primercount + 1
        lcd.clear()
        lcd.putstr("Get primer " + str(primercount))
        status = "tf"
        buzz()

    if status == "tf" and tpin.value()==1:  # cleared
        now = utime.time()
        if now - cntstart > 3:
            primercount = 0
            lcd.clear()
            lcd.putstr("Reset to 0.")
            status = "reset"
        else:
            status="tc"
            lcd.clear()
            lcd.putstr("Loaded primer " + str(primercount))
            beep()

    irqsetup()

    
def bottom_handler(bpin):
    global status, primercount
    bottomIR.irq(handler=None)  # type: ignore
    if status == "tc" and bpin.value()==0:      ## blocked
        status="bt"
        lcd.clear()
        lcd.putstr("Seat primer.")
        warn()

    if status == "bc" and bpin.value()==0:      ## blocked
        lcd.clear()
        lcd.putstr("Ready.")
        lcd.move_to(0,1)
        if primercount == 1:
            primer = "primer"
        else:
            primer = "primers"
        lcd.putstr("Used " + str(primercount) + " " + primer + ".")

    if status == "reset" and bpin.value()==0:   ## blocked
        lcd.clear()
        lcd.putstr("Ready.")
        status = "bc"

    if status == "bt" and bpin.value()==1:      ## cleared
        status="bc"
        lcd.clear()
        lcd.putstr("Seating.")
        beep()
        sleep(0.2)
    irqsetup()

def pluspin_handler(pluspin):
    global status, primercount,cntstart
    pluspin.irq(handler=None)    # type: ignore
    if pluspin.value() == 0:
        primercount = primercount + 1
        lcd.clear()
        lcd.putstr("Added 1 to primer count.")
        lcd.move_to(0,1)
        lcd.putstr("Count is : " + str(primercount))
    irqsetup()

def minuspin_handler(minuspin):
    global status, primercount,cntstart
    minuspin.irq(handler=None)    # type: ignore
    if minuspin.value() == 0:
        primercount = primercount - 1
        lcd.clear()
        lcd.putstr("Minus 1 from primer count.")
        lcd.move_to(0,1)
        lcd.putstr("Count is : " + str(primercount))
    irqsetup()

def pausepin_handler(pausepin):
    global status, primercount,cntstart, prevstatus
    pausepin.irq(handler=None)    # type: ignore
    lcd.clear()
    lcd.putstr("Status: " + str(status))
    sleep_ms(500)
    if status == "pause" and pausepin.value() == 0:
        status = prevstatus
    else: 
        prevstatus = status
        status = "pause"


    lcd.move_to(0,1)
    lcd.putstr("Status: " + str(status))
    irqsetup()

def irqsetup():
    topIR.irq(trigger=Pin.IRQ_FALLING | Pin.IRQ_RISING, handler=top_handler)
    bottomIR.irq(trigger=Pin.IRQ_FALLING | Pin.IRQ_RISING, handler=bottom_handler)
    pluspin.irq(trigger=Pin.IRQ_FALLING, handler=pluspin_handler)
    minuspin.irq(trigger=Pin.IRQ_FALLING, handler=minuspin_handler)
    pausepin.irq(trigger=Pin.IRQ_FALLING, handler=pausepin_handler)
   
irqsetup()


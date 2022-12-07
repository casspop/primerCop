# PrimerCop_Final.py - 2022 Gregory A Sanders
# Rename to 'main.py' and upload to Pi Pico
# along with lcd_api.py and pico_i2c_lcd.py
#
from utime import sleep
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

status = "bc"
primercount = 0
cntstart = 0

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
        lcd.putstr("Getting primer " + str(primercount))
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

def irqsetup():
    topIR.irq(trigger=Pin.IRQ_FALLING | Pin.IRQ_RISING, handler=top_handler)
    bottomIR.irq(trigger=Pin.IRQ_FALLING | Pin.IRQ_RISING, handler=bottom_handler)
   
irqsetup()


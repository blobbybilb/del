from pynput.mouse import Button, Controller
from time import sleep

mouse = Controller()

number_of_notes = 20

from pynput.keyboard import Key, Controller
keyboard = Controller()

sleep(5)

for i in range(20):
    keyboard.press(Key.enter)
    keyboard.release(Key.enter)

    sleep(1.2)

    with keyboard.pressed(Key.cmd):
        with keyboard.pressed(Key.shift):
            keyboard.press('e')
            keyboard.release('e')

    sleep(1.2)

    keyboard.press(Key.enter)
    keyboard.release(Key.enter)

    sleep(1.2)

    mouse.position = (975, 23)
    mouse.click(Button.left)

    sleep(1.2)
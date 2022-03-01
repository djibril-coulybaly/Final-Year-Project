from time import sleep
from gpiozero import Button
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

seat1 = Button(2)
seat2 = Button(3)
seat3 = Button(17)
seat4 = Button(27)


def check_seat_status(button, seat):
    button.wait_for_press()
    if button.is_pressed:
        db.collection('available_seats').document('vehicle1').update(
            {
                seat: True
            }
        )
        print("Someone is sitting on ", seat, "!")
    else:
        db.collection('available_seats').document('vehicle1').update(
            {
                seat: False
            }
        )
        print(seat, " is free!")


print("-------------------------------------------------------")
print("This is a test to see if someone is sitting on the seat")
print("-------------------------------------------------------\n")
while True:
    #     print("Waiting for someone to sit on the seat...")
    #     button.wait_for_press()
    #     if button.is_pressed:
    #         print("Someone is sitting on the seat!")
    #     else:
    #         print("The seat is free!")
    #     sleep(2)
    check_seat_status(seat1, "seat1")
    check_seat_status(seat2, "seat2")
    check_seat_status(seat3, "seat3")
    check_seat_status(seat4, "seat4")

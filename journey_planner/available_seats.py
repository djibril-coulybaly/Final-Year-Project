#  Student Name: Djibril Coulybaly
#  Student Number: C18423664
#  Date: 15/04/2022
#  Application: Anseo Transit
#  File Name: available_seat.py
#  Description: This file contains the logic for detecting when a seat is available and subsequently updating the status
#               to the firebase database in the Available Seats screen (available_seats.dart).

#  Imports utilised in this file
from time import sleep
from gpiozero import Button
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Connecting to the Firebase database
cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# The pins that the seats are connected to on the Raspberry Pi i.e.
# Seat 1 = GPIO02
# Seat 2 = GPIO03
# Seat 3 = GPIO17
# Seat 4 = GPIO27
seat1 = Button(2)
seat2 = Button(3)
seat3 = Button(17)
seat4 = Button(27)


# If someone is sitting on a seat, its corresponding field in the database will be updated to false.
# Otherwise it will be set to true if a seat is not currently occupied
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

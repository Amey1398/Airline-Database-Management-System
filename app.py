import tkinter as tk
import mysql.connector
# from tkinter import *

# import tkinter as tk
from tkinter import ttk, messagebox
# import mysql.connector
from tkinter import *

global_username = input('Enter the database username: ')
global_password = input("Enter the password: ")

def get_value():
    e1.delete(0, END)
    e2.delete(0, END)

    row_id = listBox.selection()[0]
    select = listBox.set(row_id)
    e1.insert(0, select['Departure Airport'])
    e2.insert(0, select['Arrival Airport'])

def get_value2():
    e9.delete(0, END)
    row_id = listBox2.selection()[0]
    select = listBox2.set(row_id)
    e9.insert(0, select['Reservation Number'])

def show_flights():
    for item in listBox.get_children():
        listBox.delete(item)
    dep_air = e1.get()
    arr_air = e2.get()
    mysqldb = mysql.connector.connect(host="localhost", user=global_username, password=global_password,
                                      database="airline_dbms")
    mycursor = mysqldb.cursor()
    sql = "CALL get_flights(%s, %s)"
    val = (dep_air, arr_air)
    mycursor.execute(sql, val)
    records = mycursor.fetchall()
    print(records)

    for i, (flight_no, dep_date, dep_time, seats_available, dep_airport, arr_airport) in enumerate(records, start=1):
        listBox.insert("", "end", values=(flight_no, dep_date, dep_time, seats_available, dep_airport, arr_airport))
        mysqldb.close()

def display_airports():
    mysqldb = mysql.connector.connect(host="localhost", user=global_username, password=global_password,
                                      database="airline_dbms")
    mycursor = mysqldb.cursor()
    mycursor.execute("SELECT code, name FROM airport ORDER BY code")
    records = mycursor.fetchall()
    print(records)

    for i, (code, name) in enumerate(records, start=1):
        listBox3.insert("", "end", values=(code, name))
        mysqldb.close()


def view_reservation():
    for item in listBox2.get_children():
        listBox2.delete(item)
    res_no = e9.get()
    mysqldb = mysql.connector.connect(host="localhost", user=global_username, password=global_password,
                                      database="airline_dbms")
    mycursor = mysqldb.cursor()
    sql = "CALL read_reservation(%s)"
    mycursor.execute(sql, (res_no,))
    records = mycursor.fetchall()
    print(records)


    for i, (reservation_no, customer, first_name, last_name, flight_no, dep_date, dep_time, gate_no, status,
            is_seat_assigned, dep_airport, arr_airport) in enumerate(records, start=1):
        listBox2.insert("", "end", values=(reservation_no, customer, first_name, last_name, flight_no, dep_date, dep_time,
                                          gate_no, status, is_seat_assigned, dep_airport, arr_airport))
    mysqldb.close()

def new_reservation():
    f_name = e3.get()
    l_name = e4.get()
    f_no = e5.get()
    assign_seat = e6.get()
    id_type = e7.get()
    ccn = e8.get()
    mysqldb = mysql.connector.connect(host="localhost", user=global_username, password=global_password,
                                      database="airline_dbms")
    mycursor = mysqldb.cursor()
    sql = "CALL create_reservation(%s, %s, %s, %s, %s, %s)"
    val = (f_name, l_name, f_no, assign_seat, id_type, ccn)
    mycursor.execute(sql, val)
    mysqldb.commit()
    mysqldb.close()

root = Tk()

def update_reservation():
    res_no = e9.get()
    new_fli_no = e5.get()
    assign_seat = e6.get()
    mysqldb = mysql.connector.connect(host="localhost", user=global_username, password=global_password,
                                      database="airline_dbms")
    mycursor = mysqldb.cursor()
    sql = "CALL update_reservation(%s, %s, %s)"
    val = (res_no, new_fli_no, assign_seat)
    mycursor.execute(sql, val)
    mysqldb.commit()
    mysqldb.close()

def delete_reservation():
    res_no = e9.get()
    mysqldb = mysql.connector.connect(host="localhost", user=global_username, password=global_password,
                                      database="airline_dbms")
    mycursor = mysqldb.cursor()
    sql = "CALL delete_reservation(%s)"
    mycursor.execute(sql, (res_no,))
    mysqldb.commit()
    mysqldb.close()

root.geometry("1200x800")
global e1
global e2
global e3
global e4
global e5
global e6
global e7
global e8
global e9

tk.Label(root, text="Airline Management", fg="red", font=(None, 20)).place(x=450, y=10)

tk.Label(root, text="Departure Airport").place(x=10, y=50)
Label(root, text="Arrival Airport").place(x=350, y=50)
Label(root, text="First Name").place(x=10, y=300)
Label(root, text="Last Name").place(x=365, y=300)
Label(root, text="Flight Number").place(x=10, y=330)
Label(root, text="Is Seat Assigned").place(x=350, y=330)
Label(root, text="ID Provided").place(x=650, y=300)
Label(root, text="Credit Card Number").place(x=630, y=330)
Label(root, text="*Reservation Number*").place(x=300, y=370)

e1 = Entry(root)
e1.place(x=160, y=50)

e2 = Entry(root)
e2.place(x=460, y=50)

e3 = Entry(root)
e3.place(x = 160, y = 300)

e4 = Entry(root)
e4.place(x = 460, y = 300)

e5 = Entry(root)
e5.place(x = 160, y = 330)

e6 = Entry(root)
e6.place(x = 460, y = 330)

e7 = Entry(root)
e7.place(x = 760, y = 300)

e8 = Entry(root)
e8.place(x = 760, y = 330)

e9 = Entry(root)
e9.place(x = 450, y = 370)

Button(root, text="Show Flights", command=show_flights, height=3, width=13).place(x=650, y=30)


# #this will be the view of the flights
col2 = ('flight_no', 'dep_date', 'dep_time', 'seats_available', 'dep_airport', 'arr_airport')

listBox = ttk.Treeview(root, columns=col2, show='headings')

for cols in col2:
    listBox.heading(cols, text=cols)
    listBox.grid(row=1, column=1, columnspan=1)
    listBox.column(cols, anchor=CENTER, stretch=NO, width=150)
    listBox.place(x=10, y=80)
show_flights()

listBox.bind('<Double-Button-1>', get_value)

Button(root, text="View Reservations", command=view_reservation, height=3, width=13).place(x=660, y=350)
Button(root, text="Create Reservation", command=new_reservation, height=3, width=13).place(x=10, y=350)
Button(root, text="Update Reservation", command=update_reservation, height=3, width=14).place(x=810, y=350)
Button(root, text="Delete Reservation", command=delete_reservation, height=3, width=13).place(x=960, y=350)

cols1 = ('reservation_no', 'customer', 'first_name', 'last_name','flight_no', 'dep_date', 'dep_time', 'gate_no',
        'status', 'is_seat_assigned', 'dep_airport', 'arr_airport')

listBox2 = ttk.Treeview(root, columns=cols1, show='headings')

for col in cols1:
    listBox2.heading(col, text=col)
    listBox2.grid(row=1, column=1, columnspan=2)
    listBox2.column(col, anchor=CENTER, stretch=NO, width=90)
    listBox2.place(x=10, y=480)


listBox2.bind('<Double-Button-1>', get_value2)

cols3 = ('Airport', 'Name')
listBox3 = ttk.Treeview(root, columns = cols3, show = 'headings')

for col in cols3:
    listBox3.heading(col, text=col)
    listBox3.grid(row=1, column=1, columnspan=2)
    listBox3.column(col, anchor=CENTER, stretch=NO, width=150)
    listBox3.place(x=780, y=80)
ysb = ttk.Scrollbar(root, orient="vertical", command=listBox3.yview)
ysb.place(x=780, y=80, height=200)
listBox3.configure(yscrollcommand=ysb.set)
xsb = ttk.Scrollbar(root, orient="horizontal", command=listBox3.xview)
xsb.place(x=780, y=300, width=210)
listBox3.configure(xscrollcommand=xsb.set)
display_airports()


root.mainloop()
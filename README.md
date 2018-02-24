# README

* Ruby version:
    2.3.0
    
* Rails version:
    5.0.6    

* Default super admin credentials:  
Email: superadmin@carrental.com  
password: superadmin

* All basic functionalities, along with 1 extra credit functionality, have been implemented. 
* The booking table is named "acts_as_bookable_bookings", which is the default name for the gem named paranoia.
* When a user signs in, he will see a menu button on the top left. It works as a toggle, which has different links for different types of users.
* When a car is created, its status is "Available" by default.
* While booking a car, the minimum allowable time is the current time. If a previous time is entered, the system will show an error to the user. He can reserve a car for a time within the next 7 days.
* Admins and super admins cannot see the option to book cars; instead they see options to view checkout history and manage user reservations. Admin can edit pending user registrations via this link.
* A user will see an option to view his checkout history when he clicks the menu button. He will also see the pending rent of his last successful booking on that page.
* Admins and super admins will see an option to edit a booking for a user in the menu.
* If a user has a pending reservation, the admin or super admin will not be able to delete that user unless he cancels or completes the booking. This holds true for cars that are booked as well. The admins will not be able to delete that car.
* If a user reserves a car for 3 pm, at 3 pm he will see an option to check out that car. Until then, he will just see the option to cancel the reservation.
* If a car was reserved for 3 pm and it wasn't checked out until 3:30 pm, it will automatically become available at 3:31 pm. This is done by writing a rake task which executes after fixed intervals. Similarly, if a user doesn't return a checked out car on time, it will automatically become available, and that user will receive an email saying his car has become available.
* If one of the cars a user once checked out is deleted, the entries for that car will disappear from the user checkout history page. Similarly, if a user is deleted, his entry from the checkout history of a car will be deleted.
* The user model and members controller have been tested.
#Bonus credit
  A customer can register for receiving email notifications. This option only becomes available if a car is "Checked out". Otherwise, a user won't be able to see the link. Also, once that user receives an email saying that car has been made available, he will not receive further emails. He will need to register again for receiving more emails.
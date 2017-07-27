# LAB: creating a custom daemon with a startup script
* Write a script that prints the current date to a log file every second.
* Create a script that accepts ```start```, ```stop``` and ```restart``` command line arguments to start, stop and restart the script we just created.
* Add the required comment ```# chkconfig: 345 80 20```, where 345 is run levels 3, 4 and 5. 80 20 means that the start command will have the number 20 (```S20```), and 80 means that the kill command will have the number 80 (```K80```).
* Put this _**launcher**_ script in the ```/etc/init.d``` directory
* Use ```chkconfig``` to add this script to the respective ```rc``` directory.
* Use ```chkconfig``` to enable the script.
* Reboot the system to one of the configured run levels and ensure that the script has been launched.

# Raid Tester

*__This raid_tester.py is a python script used to test raid cards by writing data in multiple ways. Writing both large amounts of data in small counts and small amounts of data in large counts. Once all tests are completed, we then check for any errors using MegaCli.__*

To get this file, on a Linux type environment, you can just use wget:
```
wget https://raw.githubusercontent.com/aeyxa/raid-tester/master/raid_tester.py
```


## Dependencies
This script expects multiple programs to be installed and accessible on the system:

```
MegaCli, python-setuptools, easy_install sh, hdparm
```
  

## Note
This script expects a device to be passed when running the script:

```
python raid_tester.py /dev/sdb
```
  
The current testing platform we currently implement would be to create two raid 5 arrays on three drives. One array taking up 120GB of space with CentOS 7 being installed on that array. Then another array taking up the rest of the space (this would be /dev/sdb). Whatever the "data" raid array is on is what needs to be passed when calling the script.


## Warning
>Failure to create a raid in a correct manner for which this script can write large amounts of data (over 80GB) may result in data to your file system, such as total operating system loss, failed hard drives and raid card failure. Please do not run this script on an important environment, it should only be used on a stand alone server specifically build for the purposes of testing raid cards.

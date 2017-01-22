# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

raid_tester_depend()
{
        yum install epel-release, wget, vim, tmux -y
        yum install python-setuptools -y
        easy_install sh
        cd
        mkdir raid_tester
        cd raid_tester
        wget https://raw.githubusercontent.com/aeyxa/raid-tester/master/raid_tester.py
        cd
        tmux
}


raid_tester_script()
{
    python ~/raid_tester/raid_tester.py /dev/sdb
}

raid_tester_info()
{
    clear
    echo "Currently running:"
    echo "    python ~/raid_tester/raid_tester.py /dev/sdb"
    echo
    echo "For more information:"
    echo "    vim ~/raid_tester/readme.txt"
    echo
    echo "Tmux command to gain terminal access: "
    echo "    ctrl+b THEN ctrl+% OR ctrl+\"     "
    echo
    echo
    echo "#################################################"
    echo "                    NOTICE                       "
    echo "#################################################"
    echo
    echo " If you cancel the script and open a new shell,  "
    echo " the script will execute again. To prevent this  "
    echo " script from automatically executing, please     "
    echo " comment out the 'automatic_raid_tester' bottom  "
    echo " line in vim ~/.bashrc, leaving the other lines  "
    echo " untouched and unchanged.                        "
    echo
    echo "#################################################"
    echo
    echo
    echo "When this script finishes, it will display the   "
    echo "errors that are present. If anything other than  "
    echo "a zero is on the error list, please move this    "
    echo "RAID card to RMA location, then place it in the  "
    echo "closet with a post-it note labeled as RMA, and   "
    echo "notify your shift-lead, to notify the CTO.       "
    echo
    echo
    echo "If the raid you're testing was built on a device "
    echo "other than /dev/sdb, you will need to cancel the "
    echo "automated script, and run it yourself:           "
    echo "    python ~/raid_tester/raid_tester.py /dev/??? "

}

automatic_raid_tester()
{
    x=$(ps aux | grep "[r]aid_tester.py")

    if [[ $x == "" ]]; then
        tmux
        raid_tester_info
        raid_tester_script
    fi
}

automatic_raid_tester # Comment out this line to prevent automatic testing

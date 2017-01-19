# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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
    echo
    echo
    echo "################################################"
    echo "                    NOTICE                      "
    echo "################################################"
    echo
    echo " If you cancel the script and open a new shell, "
    echo " the script will execute again. To prevent this "
    echo " script from automatically executing, please    "
    echo " comment out the 'automatic_raid_tester' bottom "
    echo " line in vim ~/.bashrc, leaving the other lines "
    echo " untouched or unchanged.                        "
    echo
    echo "################################################"
    echo
    echo
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

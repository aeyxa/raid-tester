import sys
from sh import dd, hdparm, Command, grep

class RaidTester:

    def __init__(self):
        self.__device = sys.argv[1]
        self.__output = "/root/raid_tester/through.test"

    def __call__(self):
        self.__PhaseOne()
        self.__PhaseTwo()
        self.__PhaseThree()


    def __PhaseOne(self):

        def writeToEmpty():
            infile = "if=/dev/zero"
            outfile = "of=%s" % self.__device
            bytesize = "bs=1G"
            count = "count=80"
            oflag = "oflag=dsync"

            arguments = [ infile, outfile, bytesize, count, oflag ]

            return arguments


        def WriteToAFile():
            infile = "if=/dev/zero"
            outfile = self.__output
            bytesize = "bs=1G"
            count = "count=80"
            oflag = "oflag=sync"

            arguments = [ infile, outfile, bytesize, count, oflag ]

            return arguments


        functions = [ writeToEmpty(), WriteToAFile() ]

        for function in functions:
            try:
                task = dd(*function,_bg=True); task.wait()

            except KeyboardInterrupt:
                task.kill()



    def __PhaseTwo(self):

        def WriteWoutCaching():
            infile = "if=/dev/zero"
            outfile = "of=%s" % self.__device
            bytesize = "bs=512"
            count = "count=50000"
            oflag = "oflag=dsync"

            dd = [ infile, outfile, bytesize, count, oflag ]

            hdparm_no_cache = "-W0"
            hdparm_device = self.__device

            hd = [ hdparm_no_cache, hdparm_device ]

            arguments = [ dd, hd ]

            return arguments


        def WriteWithCaching():
            infile = "if=/dev/zero"
            outfile = "of=%s" % self.__device
            bytesize = "bs=512"
            count = "count=50000"
            oflag = "oflag=dsync"

            dd = [ infile, outfile, bytesize, count, oflag ]

            hdparm_no_cache = "-W1"
            hdparm_device = self.__device

            hd = [ hdparm_no_cache, hdparm_device ]

            arguments = [ dd, hd ]

            return arguments


        functions = [ WriteWoutCaching(), WriteWithCaching() ]

        for function in functions:
            ddArguments = function[0]
            hdArguments = function[1]

            try:
                task = dd(*ddArguments,_bg=True); task.wait()

            except KeyboardInterrupt:
                task.kill()

            try:
                task = hdparm(*hdArguments,_bg=True); task.wait()

            except KeyboardInterrupt:
                task.kill()



       def __PhaseThree(self):

            def SpeedTest():
                infile = "if=%s" % self.__output
                outfile = "of=/dev/null"
                bs = "bs=1024"

                arguments = [ infile, outfile, bs ]

                try:
                    task = dd(*arguments,_bg=True); task.wait()

                except KeyboardInterrupt:
                    task.kill()


            def ErrorTest():
                display_flag = "-CfgDsply"
                details_flag = "-aALL"

                MegaCliArguments = [ display_flag, details_flag ]

                MegaCli = Command("/opt/MegaRAID/MegaCli/MegaCli64")

                display_mega = MegaCli(*MegaCliArguments)
                display_grep = grep(display_mega,"Error")

                print("\n\n%s\n\n" % display_grep)


            def CleanTest():
                rm(self.__output)


        functions = [ SpeedTest, ErrorTest, CleanTest ]

        for function in functions:
            try:
                function()

            except:
                print("Error %s" % function)


tester = RaidTester()
tester()

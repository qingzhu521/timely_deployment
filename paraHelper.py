#!/usr/bin/python

import json

if __name__ == "__main__":
    parastr = ""
    with open("conf/setting.json") as f:
        para = json.load(f)
        for item in para:
            if type(item) != dict:
                parastr = parastr + str(item) + " "
            else:
                last=""
                for key in item:
                    if key == "workers":
                        last = "-w" + " " + str(item[key]) + " "
                    else:
                        parastr = parastr + "-" + str(key) + " " + str(item[key]) + " "
                if last != "":
                    parastr += last
                else:
                    parastr += "-w 1 "
        print(parastr)
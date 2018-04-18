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
                for key in item:
                    parastr = parastr + "-" + str(key) + " " + str(item[key]) + " "
        print(parastr)
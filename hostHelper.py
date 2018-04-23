import os

if __name__=="__main__":
    with open("conf/hosts") as f:
        for line in f:
            if line[0] != "#":
                words=line.split(":")
                print(words[0])
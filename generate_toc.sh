#!/usr/bin/env python3
# Copyright (c) 2021-present. All rights reserved. See license for more details.
# Open an issue for requests/bugs. Requests for features provided upon support.

import sys
import os
import re

def main():
  if (len(sys.argv)<2):
    print(r"Help:")
    print(sys.argv[0] + " README.md")
    print(r"Outputs a Table of Contents for a README file")
    quit()

  filepath = sys.argv[1]

  if not os.path.isfile(filepath):
    print("File path {} does not exist. Exiting...".format(filepath))
    sys.exit(-1)

  inCode = False  
  print("## Table Of Contents")
  print("<!-- Generated using  -->")

  with open(filepath) as fp:
    for line in fp:
      if (line.startswith("```")):
        inCode = ~inCode

      if (~inCode):
        printIndex(line)
           
def printIndex(line):
  if (line.startswith("#")) :
    identN = line.find(" ") - 1
    if (identN>-1):
      ident = "  " * identN
      line = line.strip("\n")
      title = line.replace('#','').strip()
      link = re.sub(r'[^\w]+',' ', line).strip().lower().replace(" ","-")
      if (link.startswith("-")):
        link = link[1:]
      print(ident + "* ["+title+"](#" + link + ")")

def alloweChar(c):
  if (ord(c)>96 and ord(c)<123 or ord(c) == 45):
    return c

if __name__ == '__main__':
    main()

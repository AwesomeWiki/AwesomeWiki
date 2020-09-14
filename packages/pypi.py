# -*- coding: utf-8 -*-
"""
Created on Mon Sep 14 10:54:49 2020

@author: slo4
"""

import json
import urllib.request
def findPackageFromPyPi(package):
    url = 'https://pypi.python.org/pypi/' + package + '/json'
    response = urllib.request.urlopen(url)
    result = json.loads(response.read())
    result.pop('urls')
    result.pop('last_serial')
    return result


if __name__ == '__main__':
    result = findPackageFromPyPi("pandas")


            
                    


  


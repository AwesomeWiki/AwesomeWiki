# -*- coding: utf-8 -*-
"""
Created on Mon Sep 14 10:54:49 2020

@author: slo4
"""
import json
from urllib.request import Request, urlopen
def findPackageFromNPM(package):
    url = 'https://api.npms.io/v2/package/' + package
    ##This is from https://stackoverflow.com/questions/16627227/http-error-403-in-python-3-web-scraping
    req = Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    web_byte = urlopen(req).read()
    webpage = web_byte.decode('utf-8')
    result1 = json.loads(webpage)
    result1.pop('analyzedAt')
    return result1


if __name__ == '__main__':    
    package = 'got'    
#    url = 'https://api.npms.io/v2/package/' + package
    result = findPackageFromNPM(package)
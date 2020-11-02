import sys
import os

import requests
from bs4 import BeautifulSoup
import re

from difflib import SequenceMatcher

from queue import PriorityQueue

# help from https://stackoverflow.com/questions/17388213/find-the-similarity-metric-between-two-strings


def similarity(a, b):
    return SequenceMatcher(None, a, b).ratio()

# help from https://pythonspot.com/extract-links-from-webpage-beautifulsoup/


def getLinks(soup, url_processed):
    links = PriorityQueue()
    for link in soup.findAll('a', attrs={'href': re.compile("^https?://")}):
        # print(link.get('href'))
        # print(similarity(url_processed, link.get('href')))
        priority = 2 - similarity(url_processed, link.get('href'))
        # give higher priorities to links that contain relevant keywords like "install"
        if "install" in link or "documentation" in link:
            priority -= 1
        links.put((priority, link.get('href')))

    return links


def getPackageName(url, search_expr="pip\sinstall\s((?:-U\s)?([\w-]+))", depth=0, results_pq = PriorityQueue(), url_processed=None):
    # cut off searches at a certain depth
    if depth >= 3:
        return None

    if url_processed == None:
        # get repo name (if github)
        if "//github" in url.casefold():
            url_processed = re.search("^https?://github.com/[^/]+/(.+)", url)
        # get meat of link
        else:
            url_processed = re.search("^https?://(?:[w]{3}.)?(\S+)", url)
        if url_processed != None:
            url_processed = url_processed.group(1)
        print(url_processed)

    try:
        response = requests.get(url).content
    except Exception:
        return None
    #print(response)
    soup = BeautifulSoup(response, features="lxml")
    text_of_soup = soup.get_text().strip()  # turn html into text

    regex_results = re.findall(search_expr, text_of_soup)
    print(regex_results)

    if regex_results != None:
        # loop through matches
        for regex in regex_results:  
            # loop through tuple of capture groups
            for cap_group in regex:  
                match_similarity = similarity(cap_group.casefold(), url_processed.casefold())
                if match_similarity >= 0.7:
                    return regex[0]
                else:
                    results_pq.put((1 - match_similarity, cap_group))
            print(regex)  # TODO add support for multiple pip-like keywords
    
    links = getLinks(soup, url_processed)

    # TODO Fix recursive searching - doesn't always work 
    # for each look on the page, look for for the package name 
    for link in links.queue:
        name = getPackageName(link[1], search_expr, depth+1, results_pq, url_processed)
        # if we find a match, return it 
        if name != None:
            return name

    if depth == 0 and not results_pq.empty():
        return results_pq.get()[1]
    elif depth == 0 and results_pq.empty():
        return url_processed
    else:
        return None

def assertCorrectPkgName(address, expected):
    print(address)
    package_name = getPackageName(address, search_expr="pip\sinstall\s((?:-U\s)?([\w-]+))")
    print("EXPECTED: " + expected)
    print("ACTUAL: " + package_name)

    return expected == package_name

def getMarkdownPkgNames(markdown_dict):
    results = []

    for category in my_dict:
        for address in my_dict[category]:
            address = address[address.find('(')+1:-1] # exclude parentheses 
            print(address)
            if address.find('http') != -1: # if valid address
                package_name = getPackageName(address)
                if package_name == None:
                    package_name = "None"
                print("RESULT: " + package_name)
                results.append(package_name)
    return results

if __name__ == '__main__':

    file_path = os.path.dirname(os.path.abspath(__file__)) + "\\source_data\\awesome-python-master-README.md"
    #file_path = "/Users/personal/Downloads/awesome-python-master/README.md"

    my_dict = {}
    process = False
    f = open(file_path, 'r')
    lines = f.readlines()
    key = ""
    values = []
    list1 = []
    for line in lines:
        if line == '\n':
            continue
        words = line.split()
        if words[0].startswith('##'):
            new_string = line.replace('##', '')
            if not process:
                process = True
            else:
                newList = tuple(values)
                my_dict[key] = newList
            key = new_string
            values = []
            list1.append(new_string)
        elif len(words) >= 3:
            if words[1].startswith('[') & process:
                values.append(words[1])
    newList = tuple(values)
    my_dict[key] = newList
    # print(my_dict)

    #getMarkdownPkgNames(my_dict)

    # standard case
    assertCorrectPkgName("https://github.com/tylerlaberge/PyPattyrn", "pypattyrn")
    # TODO -U case
    assertCorrectPkgName("https://github.com/tylerlaberge/PyPattyrn", "pypattyrn")
    # TODO -r red herring
    assertCorrectPkgName("https://github.com/tylerlaberge/PyPattyrn", "pypattyrn")
    # separate page starting at github
    # TODO support more complicated commands such as 
    # "sudo pip3 install ajenti-panel ajenti.plugin.core ajenti.plugin.dashboard ajenti.plugin.settings ajenti.plugin.plugins"
    # assertCorrectPkgName("https://github.com/ajenti/ajenti", "pypattyrn")
    # separate page
    assertCorrectPkgName("https://twistedmatrix.com/trac/", "twisted")
    # separate page with www
    assertCorrectPkgName("http://www.pyqtgraph.org/", "pyqtgraph")
    # separate page with totally different website name 
    assertCorrectPkgName("https://www.crummy.com/software/BeautifulSoup/bs4/doc/", "beautifulsoup4")
    # separate page with 2 clicks to get name
    assertCorrectPkgName("https://github.com/wooey/wooey", "wooey")

    original_stdout = sys.stdout  # Save a reference to the original standard output

    # TODO Store responses in something

    sys.stdout = original_stdout

import sys

import requests
from bs4 import BeautifulSoup
import re
    
def getPackageName(url):
    response = requests.get(url).content
    soup = BeautifulSoup(response, features="lxml")
    text_of_soup = soup.get_text().strip() # turn html into text 
    regex_results = re.search("pip install ([a-zA-Z\-]+)", text_of_soup)
    if regex_results != None:
        regex_results = regex_results.group()
        print(regex_results) #TODO add support for multiple pip-like keywords 
    return regex_results

if __name__ == '__main__':
    
    file_path = "source_data/awesome-python-master-README.md"
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
    #print(my_dict)

    results = []

    for category in my_dict:
        for address in my_dict[category]:
            address = address[address.find('(')+1:-1]
            if address.find('http') != -1:
                results.append(getPackageName(address))
            print(address)

    original_stdout = sys.stdout # Save a reference to the original standard output

    #TODO Store responses in file 

    print(results)
    with open('pip-out.txt', 'w') as f:
        sys.stdout = f # Change the standard output to the file we created.
        for pip in results:
            print(pip)

    sys.stdout = original_stdout


import sys
import scrapy
from scrapy.crawler import CrawlerProcess
from scrapy import signals
from scrapy.utils.project import get_project_settings

from scrapy.signalmanager import dispatcher
from LibToInstallerMatching import QuotesSpider
    
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

    def crawler_results(signal, sender, item, response, spider):
        if item != None:
            results.append(item)

    dispatcher.connect(crawler_results, signal=signals.item_passed)

    process = CrawlerProcess(get_project_settings())

    for category in my_dict:
        for address in my_dict[category]:
            address = address[address.find('(')+1:-1]
            if address.find('http') != -1:
                process.crawl(QuotesSpider, address)
            print(address)
    process.start() # the script will block here until the crawling is finished

    original_stdout = sys.stdout # Save a reference to the original standard output

    #TODO Store responses in file 

    print(results)
    with open('pip-out.txt', 'w') as f:
        sys.stdout = f # Change the standard output to the file we created.
        for pip in results:
            print(pip)

    sys.stdout = original_stdout
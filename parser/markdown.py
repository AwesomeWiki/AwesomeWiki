import scrapy
from scrapy.crawler import CrawlerProcess
import os
os.system("python ../library_scraper/library_scraper/spiders/LibToInstallerMatching.py")
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

    process = CrawlerProcess(settings={})

    for category in my_dict:
        for address in my_dict[category]:
            address = address[address.find('(')+1:-1]
            if address.find('http') != -1:
                process.crawl(QuotesSpider, start_url=address)
                process.start() # the script will block here until the crawling is finished
            print(address)
import sys
import scrapy
from bs4 import BeautifulSoup
import re

class QuotesSpider(scrapy.Spider):
    name = "keywords"
    start_urls = [
        #'https://github.com/PetrochukM/PyTorch-NLP',
        #'https://github.com/benedekrozemberczki/karateclub'
    ]

    def __init__(self, start_url, *args, **kwargs):
        super(QuotesSpider, self).__init__(*args, **kwargs)
        self.start_urls = [start_url]

    def parse(self, response):
        soup = BeautifulSoup(response.body, features="lxml")
        text_of_soup = soup.get_text().strip() # turn html into text 
        regex_results = re.search("pip install ([a-zA-Z\-]+)", text_of_soup)
        if regex_results != None:
            regex_results = regex_results.group()
            print(regex_results) #TODO add support for multiple pip-like keywords 
        return regex_results
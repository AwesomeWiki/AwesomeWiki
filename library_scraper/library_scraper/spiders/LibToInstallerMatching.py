import scrapy
from bs4 import BeautifulSoup
import re

class QuotesSpider(scrapy.Spider):
    name = "keywords"
    start_urls = [
        'https://github.com/PetrochukM/PyTorch-NLP',
        'https://github.com/benedekrozemberczki/karateclub'
    ]

    def parse(self, response):
        soup = BeautifulSoup(response.body, features="lxml")
        text_of_soup = soup.get_text().strip()
        regex_results = re.search("pip install ([a-zA-Z\-]+)", text_of_soup).group()
        print(regex_results) #TODO add support for multiple pip keywords 
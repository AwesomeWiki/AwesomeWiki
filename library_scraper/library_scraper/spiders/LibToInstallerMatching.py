import scrapy

class QuotesSpider(scrapy.Spider):
    name = "keywords"
    start_urls = [
        'https://github.com/PetrochukM/PyTorch-NLP',
    ]

    def parse(self, response):
        pip_siblings = response.xpath('//*[text()="pip"]/following-sibling::span/text()').getall()
        pip_keyword = [""]
        keyword_count = 0
        for word in pip_siblings:
            if word == "install":
                keyword_count += 1
                if keyword_count > 1: #TODO add support for multiple pip keywords 
                    break
                continue
            pip_keyword[0] += word

        print(pip_keyword)
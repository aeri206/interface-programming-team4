import scrapy
import json
import os, sys
#from selenium import webdriver
from .category import category_int, category_str
from crawl.items import ProductItem

class CategorySpider(scrapy.Spider):
    name = "category"
    
    def __init__(self):
        dir = os.path.dirname(os.path.abspath(sys.argv[0]))

        with open(os.path.join(dir, "spiders/index.json"), "r") as json_file:
            json_data = json.load(json_file)
            self.product = json_data

    def start_requests(self):
        urls = [ {"url" : ''.join(['https://www.glowpick.com/product/', x]), "id" : x} for x in self.product]
        
        for url in urls:
            yield scrapy.Request(
                url=url["url"],
                meta={"id":url["id"]},
                callback=self.parse
                )

    def parse(self, response):
        result = response.css('.product-detail__category::text').get().strip()
        yield ProductItem(
            product_id = response.meta["id"],
            category_id = category_int[result]
        )
        
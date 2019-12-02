# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html
import json

class JsonPipeline(object):
    def open_spider(self, spider):
        self.file = open('category.json', 'w')

    def close_spider(self, spider):
        self.file.close()

    def process_item(self, item, spider):
        result = { item['product_id'] : item['category_id']}
        res = {}
        with open ('result.json', 'r') as fw:
            res = json.load(fw)
            
        with open ('result.json', 'w') as f:
            res.update(result)
            f.write(json.dumps(res))

# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class ProductItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    product_id = scrapy.Field()
    category_id = scrapy.Field()

    def __repr__(self):
         return '{} : {}'.format(self['product_id'], self['category_id'])
    pass

//
//  ProductModel.swift
//  BeautyTube
//
//  Created by user on 09/12/2019.
//  Copyright © 2019 Aeri Cho. All rights reserved.
//

import Foundation

struct ProductModel {
    var data: [ProductData]
}
/*
{
       "id": 47,
       "name": "올리브 리얼 에센셜 오일 Ex",
       "product_id": 6857,
       "brand_name": "이니스프리(innisfree)",
       "img_url": "https://d9vmi5fxk1gsw.cloudfront.net/home/glowmee/upload/20170215/1487150967101_160.png",
       "category": 5
   },
*/
struct ProductData {
    let name, brand, img_url: String
    let id: Int
}

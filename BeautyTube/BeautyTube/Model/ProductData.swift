//
//  ProductData.swift
//  BeautyTube
//
//  Created by user on 09/12/2019.
//  Copyright © 2019 Aeri Cho. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let name: String
    let product_id: Int
    let brand_name: String
    let img_url: String
    let category: Int
    let score: Int
    let price: Int
    
}

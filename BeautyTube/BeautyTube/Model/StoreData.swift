//
//  StoreData.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/12/17.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation

struct Store: Decodable {
    let id: Int
    let name: String
    let product_id: Int
    let brand_name: String
    let img_url: String
    let category_name: String
    let price: Int
    let raking: Int
    let score: Int
    let description: String
    let seller: String
    let category: Int
    let map_url: String
}

//
//  StoreModel.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/12/17.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation

struct StoreModel {
    var data: [StoreData]
}
/*
{
       {
           "id": 14952,
           "name": "제로 오일 피지 조절 세럼",
           "product_id": 14803,
           "brand_name": "오리진스",
           "img_url": "https://d9vmi5fxk1gsw.cloudfront.net/home/glowmee/upload/20140811/1407808001948_160.jpg",
           "category_name": "에센스",
           "raking": 14951,
           "score": 0,
           "description": "번들거리는 피부 부위에 사용하는 피지 흡수제 액상\r\n\r\n점토처럼 만들어진 규산염이 과분비된 피지를 흡수하는 기능을 발휘하여 피부가 매트해집니다. 녹나무 성분이 과활성화된 피부를 진정시키고 리후레싱 시켜 줍니다.",
           "seller": "부츠",
           "price": 20000,
           "category": 122,
           "map_url": "https://v4.map.naver.com/?query=부츠 여의도IFC점&type=SITE_1&queryRank=0"
       }
   },
*/
struct StoreData {
    let name, brand_name, img_url, description, seller, map_url, category_name: String
    let id, score, price, product_id, raking, category: Int
}

//
//  K.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/20.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation

struct K {
    static let videoSearchResultSegue = "goToResult"
    static let tableCellIdentifier = "ReusableCell"
    static let cellNibName = "YoutubeCell"
    static let defaultURL = "https://www.youtube.com/watch?v=XYeuvbhKy4I" // 걍 제가 좋아하는 노래 링크ㅋㅋ
    static let defaultImageURL = "https://cdn.shopify.com/s/files/1/0783/9473/t/3/assets/twitter-white.png?0"
    static let selectCategorySegue = "SelectCategory"
    static let searchCategorySegue = "SearchCategory"
    static let selectSubCategorySegue = "SelectSubCategory"
    static let youtubeLoading = "유튜브 리뷰를 가져오는 중입니다 🥳"
    static let noProductInfo = "there is no product information"
    static let saveKey = "Preference"
    static let youtubeLoadFailed = "관련 리뷰를 찾지 못했습니다 😭"
    static let star = "star"
    static let starFill = "star.fill"
    static let categoryNames = [
        "스킨케어",
        "클렌징",
        "베이스메이크업",
        "색조메이크업",
        "마스크/팩",
        "선케어",
        "기능성화장품",
        "바디/핸드/풋",
        "헤어",
        "네일",
        "여성용품",
        "미용렌즈",
        "향수",
        "기타제품",
        "베이비&맘",
        "바디라인",
        "남성화장품"
    ]
}

//
//  YoutubeData.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/15.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation
// # 불러온 동영상 정보(JSON)를 Parsing할 때 사용하는 data 구조

struct YoutubeData: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let snippet: Snippet
    let id: ID
}

struct Snippet: Decodable {
    let title: String
    let description: String
    let channelTitle: String
    let publishedAt: Date
    let thumbnails: Thumbnails
}

struct Thumbnails: Decodable {
    let medium: Medium
}

struct Medium: Decodable {
    let url: String
}

struct ID: Decodable {
    let videoId: String
}

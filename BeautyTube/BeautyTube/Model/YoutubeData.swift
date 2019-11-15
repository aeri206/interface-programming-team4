//
//  YoutubeData.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/15.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation

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
    let thumbnails: Thumbnails
}

struct Thumbnails: Decodable {
    let `default`: Default
}

struct Default: Decodable {
    let url: String
}

struct ID: Decodable {
    let videoId: String
}

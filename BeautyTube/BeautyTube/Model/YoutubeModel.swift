//
//  YoutubeModel.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/16.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation

struct YoutubeModel {
    var data: [VideoData]
}

struct VideoData {
    let title: String
    let description: String
    let channelTitle: String
    let imageURL: String
    let videoURL: String
}

//
//  YoutubeModel.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/16.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation
// # 동영상 정보를 내부적으로 활용하기 위한 구조

struct YoutubeModel {
    var data: [VideoData]
}

struct VideoData {
    let title, description, channelTitle, imageURL, videoURL, dateTime: String
}

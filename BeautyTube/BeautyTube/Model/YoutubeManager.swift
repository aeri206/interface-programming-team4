//
//  YoutubeManager.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/15.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation


struct YoutubeManager {
    
    let videoURL = "https://www.googleapis.com/youtube/v3/search?part=snippet"
    let APIKey = "AIzaSyCD4_LqV6LtvdiaEWBz_9c03vVMfUNYzHU"
    
    func fetchVideo(searchName: String) {
        let urlString = "\(videoURL)&q=\(searchName)&key=\(APIKey)&maxResults=1&order=rating&type=video&regionCode=KR"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        let session = URLSession(configuration: .default)
        
        // 한글, 공백 encoding
        if let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encodedURL) {
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(videoData: safeData)
                }
            }
            
            //4. Start the tast
            task.resume()
            
        }
        
    }
    
    
    func parseJSON(videoData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(YoutubeData.self, from: videoData)
            print(decodedData.items[0].snippet.title)
            print(decodedData.items[0].snippet.description)
            print(decodedData.items[0].snippet.channelTitle)
            print(decodedData.items[0].snippet.thumbnails.default.url)
            print(decodedData.items[0].id.videoId)
            
        } catch {
            print(error)
        }
        
    }
}


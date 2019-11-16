//
//  YoutubeManager.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/15.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation

protocol YoutubeManagerDelegate {
    func didUpdateVideos(_ youtubeManager: YoutubeManager, with video: YoutubeModel)
    func didFailWithError(error: Error)
}

struct YoutubeManager {
    
    let videoURL = "https://www.googleapis.com/youtube/v3/search?part=snippet"
    let APIKey = "AIzaSyCD4_LqV6LtvdiaEWBz_9c03vVMfUNYzHU"
    
    var delegate: YoutubeManagerDelegate?
    
    func fetchVideo(searchName: String) {
        let urlString = "\(videoURL)&q=\(searchName)&key=\(APIKey)&maxResults=50&type=video&regionCode=KR"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        let session = URLSession(configuration: .default)
        
        // 한글, 공백 encoding
        if let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encodedURL) {
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let videos = self.parseJSON(videoData: safeData) {
                        self.delegate?.didUpdateVideos(self, with: videos)
                    }
                }
            }
            
            //4. Start the tast
            task.resume()
            
        }
        
    }
    
    
    func parseJSON(videoData: Data) -> YoutubeModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(YoutubeData.self, from: videoData)
            
            // initialization of YoutubeModel
            var videoData = VideoData(title: "", description: "", channelTitle: "", imageURL: "", videoURL: "")
            var dataModel = YoutubeModel(data: [videoData])
            dataModel.data.removeAll()
            
            // parsing & inserting datas into YoutubeModel
            for i in 0..<decodedData.items.count {
                
                let items = decodedData.items[i]
                
                let title = items.snippet.title
                let description = items.snippet.description
                let channelTitle = items.snippet.channelTitle
                let imageURL = items.snippet.thumbnails.default.url
                let videoURL = "https://www.youtube.com/watch?v=\(items.id.videoId)"
                
                videoData = VideoData(title: title, description: description, channelTitle: channelTitle, imageURL: imageURL, videoURL: videoURL)
                dataModel.data.append(videoData)
            }
            return dataModel
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}


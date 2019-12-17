//
//  YoutubeManager.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/15.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation
// # Youtube API를 사용해 동영상 정보를 불러오는 Model

protocol YoutubeManagerDelegate {
    func didUpdateVideos(_ youtubeManager: YoutubeManager, with video: YoutubeModel)
    func didFailWithError(error: Error)
}

struct YoutubeManager {
    
    let videoURL = "https://www.googleapis.com/youtube/v3/search?part=snippet"
    let APIKey = "AIzaSyCD4_LqV6LtvdiaEWBz_9c03vVMfUNYzHU"
    
    var delegate: YoutubeManagerDelegate?
    
    func fetchVideo(searchName: String) {
        let urlString = "\(videoURL)&q=\(searchName)&key=\(APIKey)&maxResults=10&type=video&regionCode=KR"
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
                    if let videos = self.parseJSON(with: safeData) {
                        self.delegate?.didUpdateVideos(self, with: videos)
                    }
                }
            }
            
            //4. Start the tast
            task.resume()
            
        }
        
    }
    
    
    func parseJSON(with videoData: Data) -> YoutubeModel? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        
        do {
            let decodedData = try decoder.decode(YoutubeData.self, from: videoData)
            
            // initialization of YoutubeModel
            var videoData = VideoData(title: "", description: "", channelTitle: "", imageURL: "", videoURL: "", dateTime: Date.init())
            var dataModel = YoutubeModel(data: [videoData])
            dataModel.data.removeAll()
            
            // parsing & inserting datas into YoutubeModel
            for i in 0..<decodedData.items.count {
                
                let items = decodedData.items[i]
                
                let title = items.snippet.title.html2AttributedString?.string
                let description = items.snippet.description
                let channelTitle = items.snippet.channelTitle
                let imageURL = items.snippet.thumbnails.medium.url
                let videoURL = "https://www.youtube.com/watch?v=\(items.id.videoId)"
                
                let dateTime = items.snippet.publishedAt
                
                videoData = VideoData(title: title!, description: description, channelTitle: channelTitle, imageURL: imageURL, videoURL: videoURL, dateTime: dateTime)
                dataModel.data.append(videoData)
            }
            return dataModel
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}

// MARK: - HTML to Attributed String
// Convert Unicode symbol or its XML/HTML entities into its Unicode number in Swift
extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print(error)
            return nil
        }
    }
    var unicodes: [UInt32] { return unicodeScalars.map{$0.value} }
}



//
//  YoutubeViewController.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/20.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import UIKit
import DateToolsSwift

class YoutubeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var rankingPrice: UILabel!
    @IBOutlet weak var nearestStore: UIButton!
    
    var youtubeManager = YoutubeManager()
    var videoData: YoutubeModel?
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youtubeManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        title = searchText ?? ""
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableCellIdentifier)
        
        if let text = searchText {
            youtubeManager.fetchVideo(searchName: text)
        } else {
            print("there is no searchText")
        }
        
        // nearstStoreButton Custom
        nearestStore.layer.borderWidth = 1.0
        nearestStore.layer.borderColor = UIColor.systemPink.cgColor
        nearestStore.layer.cornerRadius = 5
        
    }
    
    @IBAction func nearestStorePressed(_ sender: UIButton) {
        
    }
}

// MARK: - <#Section Heading#>
extension YoutubeViewController {
    
}

// MARK: - YoutubeManagerDelegate
extension YoutubeViewController: YoutubeManagerDelegate {
    
    func didUpdateVideos(_ youtubeManager: YoutubeManager, with video: YoutubeModel) {
        DispatchQueue.main.sync {
            videoData = video
            self.tableView.reloadData()
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


// MARK: - UITableViewDataSource
extension YoutubeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoData?.data.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableCellIdentifier, for: indexPath) as! YoutubeCell
        
        let url = URL(string: videoData?.data[indexPath.row].imageURL ?? "https://cdn.shopify.com/s/files/1/0783/9473/t/3/assets/twitter-white.png?0")
        let data = try? Data(contentsOf: url!)
        
        
        cell.titleLabel.text =
            videoData?.data[indexPath.row].title
        cell.channelTitleLabel.text = videoData?.data[indexPath.row].channelTitle
        cell.dateTimeLabel.text = videoData?.data[indexPath.row].dateTime.timeAgoSinceNow
        cell.thumbnailImageView.image =  UIImage(data: data!)
        
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension YoutubeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(videoData?.data[indexPath.row].dateTime ?? indexPath.row)
        
        
        if let link = URL(string: videoData?.data[indexPath.row].videoURL ?? K.defaultURL) {
          UIApplication.shared.open(link)
        }
        
    }

}


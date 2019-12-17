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
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var scorePriceLabel: UILabel!
    @IBOutlet weak var nearestStoreButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    
    var youtubeManager = YoutubeManager()
    var videoData: YoutubeModel?
    
    var productName: String?
    var brandName: String?
    var scorePrice: String?
    var productImgURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youtubeManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        title = productName ?? ""
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableCellIdentifier)
        
        if let name = productName, let brand = brandName, let img = productImgURL {
            youtubeManager.fetchVideo(searchName: name)
            
            productNameLabel.text = name
            brandNameLabel.text = brand
            
            let data = try? Data(contentsOf: URL(string: img)!)
            productImageView.image =  UIImage(data: data!)
            
        } else {
            print("there is no product information")
        }
        
        if let brandName = brandName {
            brandNameLabel.text = brandName
        }
        
        // nearstStoreButton Custom
        nearestStoreButton.layer.borderWidth = 1.0
        nearestStoreButton.layer.borderColor = UIColor.systemPink.cgColor
        nearestStoreButton.layer.cornerRadius = 5
        
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


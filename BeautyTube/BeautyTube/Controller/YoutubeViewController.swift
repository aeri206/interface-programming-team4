//
//  YoutubeViewController.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/20.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import UIKit
import DateToolsSwift
import CoreLocation

class YoutubeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var scorePriceLabel: UILabel!
    @IBOutlet weak var nearestStoreButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDetailStackView: UIStackView!
    @IBOutlet weak var youtubeActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var youtubeActivityStatusLabel: UILabel!
    
    var storeManager = StoreManager()
    var youtubeManager = YoutubeManager()
    let locationManager = CLLocationManager()
    
    var videoData: YoutubeModel?
    var storeData: StoreModel?
    
    var productName: String?
    var brandName: String?
    var scorePrice: String?
    var productImgURL: String?
    var productID: Int?
    var mapURL: String?
    
    var star: UIImage?
    var starfill: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youtubeActivityIndicatorView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        youtubeActivityIndicatorView.startAnimating()
        youtubeActivityStatusLabel.text = "유튜브 리뷰를 가져오는 중입니다 🥳"
        
        // custom spacing (UI)
        productDetailStackView.setCustomSpacing(13, after: productImageView)
        productDetailStackView.setCustomSpacing(3, after: brandNameLabel)
        productDetailStackView.setCustomSpacing(8, after: productNameLabel)
        productDetailStackView.setCustomSpacing(14, after: scorePriceLabel)
        
        //storeManagerDelgagte
        self.star = UIImage(systemName: "star")
        self.starfill = UIImage(systemName: "star.fill")
        
        storeManager.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        youtubeManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        title = productName ?? ""
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.tableCellIdentifier)
        
        if let name = productName, let brand = brandName, let img = productImgURL, let scorePrice = scorePrice {
            youtubeManager.fetchVideo(searchName: name)
            
            productNameLabel.text = name
            brandNameLabel.text = brand
            scorePriceLabel.text = scorePrice
            
            let data = try? Data(contentsOf: URL(string: img)!)
            productImageView.image =  UIImage(data: data!)
            
        } else {
            print("there is no product information")
        }
        
        // nearstStoreButton Custom
        nearestStoreButton.layer.borderWidth = 1.0
        nearestStoreButton.layer.borderColor = UIColor.systemPink.cgColor
        nearestStoreButton.layer.cornerRadius = 5
        
        
        
        let defaults = UserDefaults.standard
        let saved = defaults.object(forKey: "Preference") as? [Int] ?? [Int]()
        let thisID = self.productID ?? -1
        var image = self.star
        if saved.contains(thisID) {
            image = self.starfill
        }
        let preferenceButton = UIBarButtonItem.init(image: image, style: .plain,
                    target: self, action: #selector(favorite(sender:)))
                
        self.navigationItem.rightBarButtonItem = preferenceButton
        
    }
    
    @IBAction func nearestStorePressed(_ sender: UIButton) {
        
        
        let urlString = mapURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        print(urlString)
        guard let url = URL(string: urlString ?? K.defaultURL) else {
             return
            
         }
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
        
        print("왜 안 될 까")
    }
    
    @objc func favorite(sender: UIBarButtonItem) {
        
        let defaults = UserDefaults.standard
        var preferenceButton: UIBarButtonItem
        var saved = defaults.object(forKey: "Preference") as? [Int] ?? [Int]()
        let thisID = self.productID ?? -1
        
        if saved.contains(thisID) {
            preferenceButton = UIBarButtonItem.init(image: self.star, style: .plain,
                                                    target: self, action: #selector(favorite(sender:)))
            if let index = saved.firstIndex(of: thisID) {
                saved.remove(at: index)
            }
        } else {
            preferenceButton = UIBarButtonItem.init(image: self.starfill, style: .plain,
                                                    target: self, action: #selector(favorite(sender:)))
            saved.append(thisID)
        }
        self.navigationItem.rightBarButtonItem = preferenceButton
        defaults.set(saved, forKey: "Preference")
       }

}

// MARK: - CLLocationManagerDelegate
extension YoutubeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, let productID = productID {
            locationManager.stopUpdatingLocation()
            storeManager.fetchStore(with: productID, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

// MARK: - StoreManagerDelegate
extension YoutubeViewController: StoreManagerDelegate {
    func didUpdateStores(_ storeManager: StoreManager, with store: StoreModel) {
        
        if Thread.isMainThread {
            self.storeData = store
//            print(self.storeData?.data[0].map_url ?? K.defaultURL)
            
            self.mapURL = self.storeData?.data[0].map_url ?? K.defaultURL
            
            
        } else {
            DispatchQueue.main.sync {
                self.storeData = store
//                print(self.storeData?.data[0].map_url ?? K.defaultURL)
                
                self.mapURL = self.storeData?.data[0].map_url ?? K.defaultURL
            }
        }
    }
}





// MARK: - YoutubeManagerDelegate
extension YoutubeViewController: YoutubeManagerDelegate {
    
    func didUpdateVideos(_ youtubeManager: YoutubeManager, with video: YoutubeModel) {
        DispatchQueue.main.sync {
            videoData = video
            
            
            if (videoData?.data.count)! > 0 {
                self.tableView.reloadData()
                youtubeActivityIndicatorView.stopAnimating()
                youtubeActivityStatusLabel.text = ""
            } else {
                youtubeActivityIndicatorView.stopAnimating()
                youtubeActivityStatusLabel.text = "관련 리뷰를 찾지 못했습니다 😭"
            }
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
//        print(videoData?.data[indexPath.row].dateTime ?? indexPath.row)
        
        if let link = URL(string: videoData?.data[indexPath.row].videoURL ?? K.defaultURL) {
            UIApplication.shared.open(link)
        }
        
    }
    
}


//
//  YoutubeViewController.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/20.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import UIKit

class YoutubeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var youtubeManager = YoutubeManager()
    var videoData: YoutubeModel?
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        youtubeManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        if let text = searchText {
            youtubeManager.fetchVideo(searchName: text)
        } else {
            print("there is no searchText")
        }
        
    }
}

extension YoutubeViewController: YoutubeManagerDelegate {
    
    func didUpdateVideos(_ youtubeManager: YoutubeManager, with video: YoutubeModel) {
        DispatchQueue.main.sync {
            videoData = video
            print(video)
            self.tableView.reloadData()
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension YoutubeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoData?.data.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = videoData?.data[indexPath.row].title
        return cell
    }
    
    
    
}

extension YoutubeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

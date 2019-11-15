//
//  ViewController.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/15.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var youtubeManager = YoutubeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the
    }

    @IBAction func fetchData(_ sender: UIButton) {
        youtubeManager.fetchVideo(searchName: "seoul")
    }
    
}


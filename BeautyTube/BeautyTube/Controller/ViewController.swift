//
//  ViewController.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/11/15.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var youtubeManager = YoutubeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        youtubeManager.delegate = self
    }

    @IBAction func searchOnYouTube(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
        // 버튼 클릭시 Segue 호출
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    // TableViewController로 가기 전 필요한 것들을 발생시키는 함수입니다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! YoutubeViewController
        }
    }
    
}

// MARK: - UITextFieldDelegate

// 이 아래부터는 textField를 컨트롤하는 함수들입니다. 함수 자체는 추후 삭제가 필요합니다. 크게 신경쓰지 않으셔도 됩니다.
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // OS keyboard를 닫는 함수
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "검색어를 입력하세요"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchText = searchTextField.text {
            // 아래 함수를 통해 viewController는 UI에서 읽은 검색어를 YoutubeManager로 보내 API Request를 발생시킵니다.
            youtubeManager.fetchVideo(searchName: searchText)
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
        
        searchTextField.text = ""
    }
}


// MARK: - YoutubeManagerDelegate

extension ViewController: YoutubeManagerDelegate {
    
    func didUpdateVideos(_ youtubeManager: YoutubeManager, with video: YoutubeModel) {
        DispatchQueue.main.sync {
            print(video)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

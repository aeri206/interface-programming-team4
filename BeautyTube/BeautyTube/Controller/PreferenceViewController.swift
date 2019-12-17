//
//  PreferenceViewController.swift
//  BeautyTube
//
//  Created by user on 18/12/2019.
//  Copyright © 2019 Aeri Cho. All rights reserved.
//

import UIKit


class PreferenceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var preferenceTable: UITableView!
    
    var preferenceManager = PreferenceManager()
    var productData: ProductModel?
    
    var productName: String?
    var brandName: String?
    var productImgURL: String?
    var productPrice: Int?
    var productScore: Int?
    var productID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenceManager.delegate = self
        preferenceTable.delegate = self
        preferenceTable.dataSource = self
        
        preferenceTable.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        preferenceManager.fetchPreference()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.videoSearchResultSegue { // 이걸로 다 되었는지 확인
            let destinationVC = segue.destination as! YoutubeViewController
            
            if let name = self.productName, let brand = self.brandName, let img = self.productImgURL, let price = self.productPrice, let score = self.productScore, let id = self.productID {
                destinationVC.productName = name
                destinationVC.brandName = brand
                destinationVC.productImgURL = img
                destinationVC.scorePrice = "★\(score) | \(price)원"
                destinationVC.productID = id
                
            } else {
                print("there is no product info")
            }
            
        }
        
    }
    
    

}

extension PreferenceViewController: PreferenceManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdatePreference(_ preferenceManager: PreferenceManager, with product: ProductModel, done: Bool) {
        productData = product
        if (done) {self.preferenceTable.reloadData()}
    }
}

extension PreferenceViewController {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let url = URL(string: productData?.data[indexPath.row].img_url ?? "")
        if let realUrl = url {
            let data = try? Data(contentsOf: realUrl)
            if let img = data {
                cell.thumbnailImageView.image = UIImage(data: img)
            }
            
        }
        cell.productLabel.text = productData?.data[indexPath.row].name
        cell.brandLabel.text = productData?.data[indexPath.row].brand
        
        if let score =  productData?.data[indexPath.row].score, let price = productData?.data[indexPath.row].price{
            cell.scoreLabel.text = "★\(score) | \(price)원"
        }
        else{
           cell.scoreLabel.text = "";
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData?.data.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.productName = productData?.data[indexPath.row].name
        self.brandName = productData?.data[indexPath.row].brand
        self.productImgURL = productData?.data[indexPath.row].img_url
        self.productScore = productData?.data[indexPath.row].score
        self.productPrice = productData?.data[indexPath.row].price
        self.productID = productData?.data[indexPath.row].id
        
        self.performSegue(withIdentifier: K.videoSearchResultSegue, sender: self)
        // TODO ; Change Identifier
    }
}

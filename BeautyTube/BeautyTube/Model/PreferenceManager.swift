//
//  Productmanager.swift
//  BeautyTube
//
//  Created by user on 16/12/2019.
//  Copyright © 2019 Aeri Cho. All rights reserved.
//

import Foundation


protocol PreferenceManagerDelegate {
    func didUpdatePreference(_ preferenceManager: PreferenceManager, with product: ProductModel, done: Bool)
    func didFailWithError(error: Error)
}

struct PreferenceManager {
    
    var delegate: PreferenceManagerDelegate?
    
    func fetchPreference() {
        print("fetchPreference")
        let defaults = UserDefaults.standard
        let saved = defaults.object(forKey: "Preference") as? [Int] ?? [Int]()
        var dataModel = ProductModel(data:[])
        
        for id in saved {
        let uriString = "http://cbadrama.kr/api/products/\(id)/"
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let url = URL(string: uriString)!
        let task = session.dataTask(with: url){ data, response, error in
            if error != nil {
                //add error hadnler function
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                return
            }
            guard let mime = response?.mimeType, mime == "application/json" else {
                return
            }

            guard let data = data else {
                print("URLSession dataTask error:", error ?? "nil")
                return
            }
            do {
                let decodedProduct = try JSONDecoder().decode([Product].self, from: data)
                    
                for i in 0..<decodedProduct.count {
                    let item = decodedProduct[i]
                    let name = item.name
                    let brand = item.brand_name
                    let img_url = item.img_url
                    let id = item.product_id
                    let score = item.score
                    let price = item.price
                    let productData = ProductData(name: name, brand: brand, img_url: img_url, id: id, score: score, price: price)
                    
                    dataModel.data.append(productData)
                    if (dataModel.data.count == saved.count) {
                    self.delegate?.didUpdatePreference(self, with: dataModel, done: true)
                    }
                }
                }
             catch {
                print(error)
            }
        }
        task.resume()
    }
        
        // end (delegate
}
    
}


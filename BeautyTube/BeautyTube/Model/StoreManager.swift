//
//  StoreManager.swift
//  BeautyTube
//
//  Created by 백승호 on 2019/12/17.
//  Copyright © 2019 Seungho Baek. All rights reserved.
//

import Foundation

protocol StoreManagerDelegate {
    func didUpdateStores(_ storeManager: StoreManager, with store: StoreModel)
    func didFailWithError(error: Error)
}

struct StoreManager {
    
    var delegate: StoreManagerDelegate?
    
    func fetchStore(with productID: Int, latitude: Double, longitude: Double ) {
        let urlString = "http://cbadrama.kr/api/products/\(productID)/lat=\(latitude)&lon=\(longitude)"
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let url = URL(string: urlString)!
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
                let decodedStore = try JSONDecoder().decode([Store].self, from: data)
                    
                var dataModel = StoreModel(data:[])
                
                for i in 0..<decodedStore.count {
                    let item = decodedStore[i]
                    
                    let storeData = StoreData(name: item.name, brand_name: item.brand_name, img_url: item.img_url, description: item.description, seller: item.seller, map_url: item.map_url, category_name: item.category_name, id: item.id, score: item.score, price: item.price, product_id: item.product_id, raking: item.raking, category: item.category)
                    
                    dataModel.data.append(storeData)
//                    print(storeData)
                }
                 self.delegate?.didUpdateStores(self, with: dataModel)
                
//                print("update completed")
        
                }
             catch {
                print(error)
            }
            //
            
            
        }
        task.resume()
    }
    
}


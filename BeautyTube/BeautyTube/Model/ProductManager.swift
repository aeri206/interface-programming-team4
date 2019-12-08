//
//  Productmanager.swift
//  BeautyTube
//
//  Created by user on 09/12/2019.
//  Copyright © 2019 Aeri Cho. All rights reserved.
//

import Foundation


protocol ProductManagerDelegate {
    func didUpdateProducts(_ productManager: ProductManager, with product: ProductModel)
    func didFailWithError(error: Error)
}

struct ProductManager {
    
    var delegate: ProductManagerDelegate?
    
    func fetchProduct(categoryID: Int) {
        let urlString = "http://cbadrama.kr/api/products/category/\(categoryID)"
        print(urlString)

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
                let decodedProduct = try JSONDecoder().decode([Product].self, from: data)
                    
                var dataModel = ProductModel(data:[])
                
                for i in 0..<decodedProduct.count {
                    let item = decodedProduct[i]
                    let name = item.name
                    let brand = item.brand_name
                    let img_url = item.img_url
                    let id = item.product_id
                    
                    let productData = ProductData(name: name, brand: brand, img_url: img_url, id: id)
                    
                    dataModel.data.append(productData)
                }
                 self.delegate?.didUpdateProducts(self, with: dataModel)
                }
             catch {
                print(error)
            }
            //
            
            
        }
        task.resume()
    }
    
}


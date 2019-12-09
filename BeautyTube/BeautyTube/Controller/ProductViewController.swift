//
//  ProductViewController.swift
//  BeautyTube
//
//  Created by user on 09/12/2019.
//  Copyright © 2019 Aeri Cho. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var productTable: UITableView!
    
    var categoryID: Int?
    var productManager = ProductManager()
    var productData: ProductModel?
    var searchProduct: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        productManager.delegate = self
        productTable.delegate = self
        productTable.dataSource = self
        
        productTable.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        if let id = self.categoryID {
        productManager.fetchProduct(categoryID: id)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.videoSearchResultSegue { // 이걸로 다 되었는지 확ㅇ
            let destinationVC = segue.destination as! YoutubeViewController
            
            if let text = self.searchProduct {
                destinationVC.searchText = text
            }
        }
        else if segue.identifier == K.searchCategorySegue {
            let destVC = segue.destination as! YoutubeViewController
            destVC.searchText = self.title
        }
    }
    

    
}



extension ProductViewController: ProductManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    func didUpdateProducts(_ productManager: ProductManager, with product: ProductModel) {
        print("didUpdateProduct")
        if Thread.isMainThread {
          // do stuff
            productData = product
            //print(self.productData ?? "no dataa")
            self.productTable.reloadData()
        } else {
        DispatchQueue.main.sync {
            productData = product
            // print(self.productData ?? "no dataa")
            self.productTable.reloadData()
            }
        }
    }
}

extension ProductViewController {
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData?.data.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(productData?.data[indexPath.row] ?? "")
        self.searchProduct = productData?.data[indexPath.row].name
        self.performSegue(withIdentifier: K.videoSearchResultSegue, sender: self)
        // TODO ; Change Identifier
        
    }
    
}

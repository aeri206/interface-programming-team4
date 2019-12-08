//
//  ProductViewController.swift
//  BeautyTube
//
//  Created by user on 09/12/2019.
//  Copyright © 2019 Aeri Cho. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    
    @IBOutlet weak var productTable: UITableView!
    
    var categoryID: Int?
    var productManager = ProductManager()
    var productData: ProductModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        productManager.delegate = self
        productTable.delegate = self as? UITableViewDelegate
        productTable.dataSource = self
        
        productTable.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        
        if let id = self.categoryID {
        productManager.fetchProduct(categoryID: id)
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
            print(self.productData ?? "no dataa")
            self.productTable.reloadData()
        } else {
        DispatchQueue.main.sync {
            productData = product
            print(self.productData ?? "no dataa")
            self.productTable.reloadData()
            }
        }
    }
}

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let url = URL(string: productData?.data[indexPath.row].img_url ?? "")
        print(url)
        // let data = try? Data(contentsOf: url!)
        
        // cell.thumbnailImageView.image = UIImage(data: data!)
        cell.productLabel.text = productData?.data[indexPath.row].name
        cell.brandLabel.text = productData?.data[indexPath.row].brand
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData?.data.count ?? 1
    }
    
}

//
//  CategoryViewController.swift
//  BeautyTube
//
//  Created by user on 02/12/2019.
//  Copyright © 2019 Aeri Cho All rights reserved.
//

import UIKit

class CategoryViewController: UICollectionViewController  {
    var categoryNames = [String]()
    
    @IBOutlet weak var category: UICollectionView!
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setCategories()
    }
    
    func setCategories(){
        categoryNames = [
            "스킨케어",
            "클렌징",
            "베이스메이크업",
            "색조메이크업",
            "마스크/팩",
            "선케어",
            "기능성화장품",
            "바디/핸드/풋",
            "헤어",
            "네일",
            "여성용품",
            "미용렌즈",
            "향수",
            "기타제품",
            "베이비&맘",
            "바디라인",
            "남성화장품"
        ]
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categoryNames.count
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

            //  Configure the Cell
            cell.categoryName.text = categoryNames[indexPath.row]
            return cell

        }

    
    
    
    
}

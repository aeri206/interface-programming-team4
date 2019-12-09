//
//  CategoryViewController.swift
//  BeautyTube
//
//  Created by user on 02/12/2019.
//  Copyright © 2019 Aeri Cho All rights reserved.
//

import UIKit

class CategoryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    var categoryNames = [String]()
    var categoryInt: Int?
    
    @IBOutlet weak var category: UICollectionView!
    override func viewDidLoad(){
        super.viewDidLoad()
        category.delegate = self
        category.dataSource = self
        setCategories()
        title = "BeautyTube"
    }
    
    func setCategories(){
        categoryNames = K.categoryNames
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return categoryNames.count
       }
       /* override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return
        } */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (category.frame.size.width - space) / 2.0
           return CGSize(width: size, height: 50)
       }
    

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell

            //  Configure the Cell
            cell.categoryName.text = categoryNames[indexPath.row]
            return cell

        }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        if segue.identifier == K.selectCategorySegue {
            let destVC = segue.destination as! SubCategoryViewController
            if let category = self.categoryInt {
            destVC.categoryInt = category
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        categoryInt = indexPath.row
        self.performSegue(withIdentifier: K.selectCategorySegue, sender: self)
        
    }
    
    
    
    
}

//
//  SubCategoryViewController.swift
//  BeautyTube
//
//  Created by user on 08/12/2019.
//  Copyright © 2019 Aeri Cho. All rights reserved.
//

import UIKit


class SubCategoryViewController: UICollectionViewController {
    
    @IBOutlet weak var subCategory: UICollectionView!
    var categoryInt: Int?
    var subCategoryInt: Int?
    var subCategoryNames = [String]()
    var subCategoryInfo = [
        // 0부터 시작한다고 가정.
        -1:[],
        0:["토너/필링패드","스킨", "에센스", "크림", "페이스오일", "로션", "메이크업픽서", "미스트"],
        1:["클렌징폼", "클렌징오일", "클렌징밀크", "클렌징크림", "클렌징워터", "클렌징젤", "스크럽/필링", "포인트리무버", "클렌징티슈", "클렌징비누"],
        2:["메이크업베이스", "톤업크림", "베이스프라이머", "포인트프라이머", "파운데이션", "비비크림", "씨씨크림", "쿠션타입", "컨실러","팩트","파우더","트윈케익"],
        3:["립스틱", "립글로스/락커", "립틴트", "립밤", "립라이너", "아이라이너-펜슬&젤", "아이라이너-리퀴드", "마스카라", "픽서/영양제", "아이섀도우", "아이브로우-펜슬", "아이브로우-파우더", "아이브로우-마스카라&리퀴드", "하이라이터", "쉐딩", "블러셔"],
        4:["마스크시트", "수면팩", "워시오프", "필오프", "수딩젤/팩", "코팩"],
        5:["선블록", "선스프레이", "선스틱", "선쿠션", "태닝"],
        6:["링클케어", "트러블케어", "화이트닝케어", "모공케어", "아이케어", "넥케어"],
        7:["바디워시", "바디스크럽", "바디로션", "바디크림", "바디오일", "바디미스트", "바디에센스", "바디밤/파우더", "핸드케어", "풋케어", "데오도란트", "목욕비누", "입욕제", "아로마테라피"],
        8:["샴푸", "린스/컨디셔너", "트리트먼트/팩", "헤어소품", "헤어에센스", "헤어스타일링", "염색제/퍼머제", "헤어기기"],
        9:["네일컬러", "베이스/탑코트/퀵드라이", "네일아트/소품", "네일영양", "네일리무버"],
        10:["소형", "중형", "대형", "오버나이트", "팬티라이너", "체내형", "청결제"],
        11:["컬러렌즈", "렌즈관리용품", "투명렌즈"],
        12:["여성향수", "남성향수", "방향제", "향초", "디퓨저"],
        13:["브러쉬", "스펀지/퍼프", "뷰러", "페이스소품", "아이소품"],
        14:["베이비스킨케어", "베이비바디", "베이비클렌저/샴푸", "베이비선케어", "키즈제품", "맘케어"],
        15:["바디슬리밍", "제모제/용품", "건강/다이어트식품"],
        16:["스킨", "로션", "에센스", "크림", "클렌징", "스크럽/필링", "쉐이빙", "애프터쉐이브", "마스크/팩", "메이크업", "선케어", "헤어/바디", "헤어스타일링"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(SubCategoryCell.self, forCellWithReuseIdentifier: "SubCategoryCell")

        // Do any additional setup after loading the view.
        setSubCategories(largeOne: categoryInt)
        if let categoryID = categoryInt {
            title = K.categoryNames[categoryID]
        }
    }
    
    func setSubCategories(largeOne: Int?){
        if let largeCategoryInt = largeOne {
            if let subCategories = subCategoryInfo[largeCategoryInt] {
                subCategoryNames = subCategories
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return subCategoryNames.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryCell

            //  Configure the Cell
            cell.subCategoryName.text = subCategoryNames[indexPath.row]
            return cell

        }
    
    func calculateCategoryID(category: Int?, subCategory: Int?) -> Int {
        var res = 0
        if let id = category {
            for i in -1...id-1 {
                res += subCategoryInfo[i]!.count
                }
        }
        if let subId = subCategory {
            res += subId
        }
        return res
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        if segue.identifier == K.selectSubCategorySegue {
            let destVC = segue.destination as! ProductViewController
            if let categoryID = self.subCategoryInt {
                destVC.categoryID = categoryID
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        self.subCategoryInt = calculateCategoryID(category: self.categoryInt, subCategory:indexPath.row)
        print(self.subCategoryInt ?? -1)
        self.performSegue(withIdentifier: K.selectSubCategorySegue, sender: self)
        
    }
    
    
}

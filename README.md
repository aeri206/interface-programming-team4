# interface-programming-team4
2019 Fall Interface Programming
## Role Description
- 박민주(@minjupark): Category, SubCategory View, Product View & Model
- 백승호(@100seugnho, @Seungho Baek): Youtube와 관련된 MVC, API구현
- 손준혁(@happysmileboy): custom API Server 구현, 웹 크롤링
- 조애리(@aeri206): Category, SubCategoryVC & Model, PreferenceVC & Model, Product MVC 구현



for more information about **MVC design pattern** checkout [iOS: Three ways to pass data from Model to Controller](https://medium.com/@stasost/ios-three-ways-to-pass-data-from-model-to-controller-b47cc72a4336), [Modern MVC](https://medium.com/ios-os-x-development/modern-mvc-39042a9097ca) and [Lecture 2: MVC's by Stanford Univ.](https://www.youtube.com/watch?v=w7a79cx3UaY&t=1492s)


![Image of MVC design Pattern of Our Project](https://user-images.githubusercontent.com/37105201/71048532-e1718600-2182-11ea-9d59-5c99dc11047d.png)



## Model

### YoutubeManager.swift
Youtube API를 사용해 동영상 정보를 불러오는 Model입니다.

#### protocol YoutubeManagerDelegate
- `ViewController`와 소통하기 위한 `protocol`
- `func didUpdateVideos(_ youtubeManager: YoutubeManager, with video: YoutubeModel)`: video 정보 호출을 성공할 시, delegate은 해당 method를 부릅니다.
- `func didFailWithError(error: Error)`: error가 날 시, delegate은 해당 method를 부릅니다.


#### func fetchVideo(searchName: String)
Delegate(`YoutubeViewController`)은 이 method에 검색어를 parameter로 넘기고, 이 함수는 넘겨받은 검색어를 사용해 youtubeAPI에 사용할 url을 생성 후 이를 parameter로 `YoutubeManager.performRequest()`를 호출합니다.

#### func performRequest(urlString: String)
넘겨받은 url을 사용해 `URLSession`과 `URLSession.dataTask(with: url)`을 생성, data를 받아오는 함수입니다. 실패시 delegate method인 `didFailWithError()`를 호출하고, 성공시에는 `YoutubeManager.parseJSON(with: safeData)`를 호출합니다. 

#### func parseJSON(with: Data) -> YoutubeModel?
1. `Foundation` 라이브러리 내장함수인  `JSONDecoder()`를 사용해 받아온 JSONdata를 parsing합니다.
3. 미리 준비된 data model(`YoutubeModel`)에 집어넣는 함수입니다. 

### YoutubeData.swift
YoutubeAPI가 제공하는 JSON data file에서 필요한 정보들을 찾기 위한 data type입니다. 변수명이 달라질 시, 정확한 정보를 담을 수 없습니다. `YoutubeData.items[].snippet.thumnails.dafault` 는 `default`라는 swift 예약어를 사용하기 때문에, 백틱(`)을 사용해 변수명을 선언했습니다. 

### YoutubeModel.swift
동영상 정보를 내부적으로 활용하기 위한 data 구조입니다. 

### ProductManager.swift

### ProductData.swift

### ProductModel.swift

### PreferenceManager.swift

### StoreManager.swift
가까운 매장을 custom Server API를 써 받아오는 모델

### StoreData.swift

### StoreModel.swift


## View

### Main.stroyboard

### YoutubeCell
Custom Tableview를 구성하기 위한 Cell 입니다.

### CategoryCell

### SubCategoryCell

### ProductCell


## Controller

### ViewController.swift

### YoutubeViewController.swift

**Used Libraries**
- DateToolsSwift: 유튜브에서 받아온 날짜 정보를 '1년 전' 이런 식을 보여주는데 사용 (Cocoapods를 사용해 관리중)
- CoreLocation: Swift 내장 라이브러리, 사용자 위치정보를 받아 가까운 매장을 찾아주는데 사용


### CategoryViewController.swift

### SubCategoryViewController.swift

### ProductViewController.swift

### PreferenceViewController.swift

Created by 백승호 on 2019/11/15.
Edited by 백승호 on 2019/12/18.
Copyright © 2019 Seungho Baek. All rights reserved.

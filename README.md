# interface-programming-team4
2019 Fall Interface Programming

for more information about MVC design pattern checkout [here](https://medium.com/ios-os-x-development/modern-mvc-39042a9097ca)

![Image of MVC design Pattern](https://miro.medium.com/max/2608/1*la8KCs0AKSzVGShoLQo2oQ.png)


## Model
The Model component corresponds to all the data-related logic that the user works with. This can represent either the data that is being transferred between the View and Controller components or any other business logic-related data. For example, a Customer object will retrieve the customer information from the database, manipulate it and update it data back to the database or use it to render data.

### YoutubeManager.swift
Youtube API를 사용해 동영상 정보를 불러오는 Model입니다.

#### `protocol YoutubeManagerDelegate `
- `ViewController`와 소통하기 위한 `protocol`
- `func didUpdateVideos(_ youtubeManager: YoutubeManager, with video: YoutubeModel)`: video 정보 호출을 성공할 시, delegate은 해당 method를 부릅니다.
- `func didFailWithError(error: Error)`: error가 날 시, delegate은 해당 method를 부릅니다.


#### `func fetchVideo(searchName: String)`
Delegate(`YoutubeViewController`)은 이 method에 검색어를 parameter로 넘기고, 이 함수는 넘겨받은 검색어를 사용해 youtubeAPI에 사용할 url을 생성 후 이를 parameter로 `YoutubeManager.performRequest()`를 호출합니다.

#### `func performRequest(urlString: String)`
넘겨받은 url을 사용해 `URLSession`과 `URLSession.dataTask(with: url)`을 생성, data를 받아오는 함수입니다. 실패시 delegate method인 `didFailWithError()`를 호출하고, 성공시에는 `YoutubeManager.parseJSON(with: safeData)`를 호출합니다. 

#### `func parseJSON(videoData: Data) -> YoutubeModel?`
1. `Foundation` 라이브러리 내장함수인  `JSONDecoder()`를 사용해 받아온 JSONdata를 parsing합니다.
3. 미리 준비된 data model(`YoutubeModel`)에 집어넣는 함수입니다. 

### YoutubeData.swift
YoutubeAPI가 제공하는 JSON data file에서 필요한 정보들을 찾기 위한 data type입니다. 변수명이 달라질 시, 정확한 정보를 담을 수 없습니다. `YoutubeData.items[].snippet.thumnails.dafault` 는 `default`라는 swift 예약어를 사용하기 때문에, 백틱(`)을 사용해 변수명을 선언했습니다. 

### YoutubeModel.swift
동영상 정보를 내부적으로 활용하기 위한 data 구조입니다. 

## View
The View component is used for all the UI logic of the application. For example, the Customer view will include all the UI components such as text boxes, dropdowns, etc. that the final user interacts with.
**However in Swift, we call storyboard as a View**

### Main.stroyboard


## Controller
Controllers act as an interface between Model and View components to process all the business logic and incoming requests, manipulate data using the Model component and interact with the Views to render the final output. For example, the Customer controller will handle all the interactions and inputs from the Customer View and update the database using the Customer Model. The same controller will be used to view the Customer data.

### ViewController.swift

### YoutubeViewController.swift

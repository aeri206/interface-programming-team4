# interface-programming-team4
2019 Fall Interface Programming

for more information about MVC design pattern checkout [here](https://medium.com/ios-os-x-development/modern-mvc-39042a9097ca)
![Image of MVC design Pattern](https://miro.medium.com/max/2608/1*la8KCs0AKSzVGShoLQo2oQ.png)

## Model
The Model component corresponds to all the data-related logic that the user works with. This can represent either the data that is being transferred between the View and Controller components or any other business logic-related data. For example, a Customer object will retrieve the customer information from the database, manipulate it and update it data back to the database or use it to render data.

### YoutubeManager
Youtube API JSON Parser

### YoutubeData
Youtube API JSON Data structure

## View
The View component is used for all the UI logic of the application. For example, the Customer view will include all the UI components such as text boxes, dropdowns, etc. that the final user interacts with.
**However in Swift, we call storyboard as a View**

### Main.stroyboard
we should have three storyboards. Creating & Naming is up to 애리

## Controller
Controllers act as an interface between Model and View components to process all the business logic and incoming requests, manipulate data using the Model component and interact with the Views to render the final output. For example, the Customer controller will handle all the interactions and inputs from the Customer View and update the database using the Customer Model. The same controller will be used to view the Customer data.

### ViewController
we should have three view controllers. Creating & Naming is up to 애리

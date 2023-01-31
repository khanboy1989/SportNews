# SportNews

This project is created by using MVVM-C pattern. Where is it is defined as Clean Architecture in order to avoid code duplication and make the code readable for all developers.

ViewControllers are responsible to interact with user in case of any input is required by the user for example selecting an item from the list.
ViewModels are responsible to create bridge between ViewController and UseCases/Coordinators

Coordinators are responsible to handle navigation where UseCases are responsible to request the the business logic events from the repositories.

Dependency Injection Containers are used in order to be able to Inject relevant classes to necessary points.
The dependency injections order as follows:

ViewController injects -> ViewModel
ViewModel injects -> UseCase, Coordinators
UseCase injects -> Repository
Repository injects -> DataTransferService

In this project specifically the MVVM-C pattern is selected so in future when it is needed we can add more features and enhance the flows with a clean way.

Coordinators are separated for each flow in this case the project contains only one flow which is NewsOverviewCoordinator and all necessary navigation actions are defined in the relevant class.

NOTE: \*The application on purpose does not use the Combine/RxSwift libraries, It is implemented with custom Observable class in order to demonstrate different approach.

<h4>Let's observe the layers with more deeply:</h4>

- Domain Layer = Entities + Use Cases + Repositories Interfaces
- Data Repositories Layer = Repositories Implementations + API (Network) + Persistence DB (if applicable)
- Screen Layer (MVVM) = ViewModels + Views

<h4>Dependecy Direction:</h4>

Screen Layer (MVVM - Dependecy) => Domain Layer (Business Logic) <= Data Layer (Data Repositories)

Note: Domain Layer should not include anything from other layers(e.g Screen — UIKit or SwiftUI or Data Layer — Mapping Codable)

<h3>Additional Frameworks:</h3>

- Swiflint : Used to have standart on the code such as coloum spacing, vertical spacing (here the swiftlint.yml file is copied from AIRBNB app)
- Swiftgen: Used to create the assets for Images, Localizable and Colors
- KingFisher: Used for loading images with caching feature in order to avoid image loading each time when the app launches

<h3>Reactive Manner</h3>
 <p>Currently simple custome observer is used in order to handle reactivity and the states of the Application.</p>

<h3>Unit Testing</h3>
 
 - Unit Tests for Use Cases(Domain Layer), ViewModels(Screen Layer), NetworkService(Infrastructure Layer)
 
 NOTE: Use Cases are not necessary to test since we only return the data from the repositories, In future when we add persistance data saving 
 functionality we can improve our tests.

<h3>How to use app</h3>
<p>Launch the application and main screen will appear if you have the internet connection you will be receiving the News about sport events such as:</p>

- Football
- Winter Sports
- Motor Sports
- Sport Mix
- Esports

<p>In case if the app does not have internet connection at the beginning, we can use pull to refresh functionality.</p>

At the top of the page you will be able to see the categories depending on the selection of the category tableview will filter the specific category. You are free to select All categories again.

If specific item is clicked on the list the details will be demonstrated with url provided from the endpoint.

NewsOverviewViewController has pull to refresh functionality, where It will make request to server side to receive latest news. Pull to refresh can be used also for the case where the is no internet connection. User can pull to refresh and get latest sport news from the server side.

Details View Controler contains try again option in case of any network error.

<h4>Future Improvements</h4>

- For future the category filtering should be dynamic. Currently it is created statically.
- Search event can be added to the NewsOverviewViewController since currently lots of data is observed by the user
- Currently UITableViewDiffableDataSource is used and the difference is animated however needs to be improved.
- Custom Observable class is used, we can switch to Combine/RxSwift completely
- Adding Persistence data saving functionality by using CoreData/Realm
- Seperating Schemes such as DEBUG, STAGE, RELEASE

<h4>Requirements</h4>

- Xcode Version 14.2+ Swift 5.0+

<h4> Application's Screen Shots </h4>
 
 - MAIN Screen - (https://user-images.githubusercontent.com/11138262/215689825-6dd67327-d146-4a19-aef5-c2be5a4c7a4f.png)

- MAIN Screen - (With Winter Sport Selection)(https://user-images.githubusercontent.com/11138262/215689862-1ab0c4e8-549b-4f93-a3d2-e3ed1af5031c.png)

- Details Screen - (https://user-images.githubusercontent.com/11138262/215689883-ba18a31f-f48a-42f2-b2ad-92bae7ebbfc5.png)

<h4> Git Branches </h4>

- Develop: Keeps the new feature of the applicaion
- Main: Keeps the stable version of the application

Currently both branches are holding the same version of the application

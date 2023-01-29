# SportNews

This project is created by using MVVM-C pattern. Where is it is defined as Clean Architecture in order to avoid code duplication and make the code readable for all developers.

ViewControllers are responsible to interact with user in case of any input is required by the user for example selecting an item from the list.
ViewModels are responsible to create between ViewController and UseCases/Coordinators
Coordinators are responsible to handle navigation where UseCases are responsible to request the the business logic events from the repositories.

Dependency Injection Containers are used in order to be able to Inject relevant classes to necessary points.
The dependency injections order as follows:

ViewController injects -> ViewModel
ViewModel injects -> UseCase, Coordinators
UseCase injects -> Repository
Repository injects -> DataTransferService

In this project specifically the MVVM-C pattern is selected so in future when it is needed we can expand the future and enhance the flows with a clean way.
Coordinators are separated for each flow in this case the project contains one flow which is NewsOverviewCoordinator and all necessary navigation actions are defined in the relevant class.

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

<h3>How to use app</h3>

<p>Launch the application and main screen will appear if you have the internet connection you will be receiving the News about sport events such as:</p>

- Football
- Winter Sports
- Motor Sports
- Sport Mix
- Esports

At the top of the page you will be able to see the categories depending on the selection of the category tableview will filter the specific category. You are free to select All categories again.

<h3>Unit Testing</h3>

<h4>Future Improvements</h4>

- For future the category filtering should be dynamic. Currently it is created statically.
- Search event can be added to the NewsOverviewViewController since currently lots of data is observed by the user
- Currently UITableViewDiffableDataSource is used and the difference is animated however needs to be improved.
- Error handling during the network calls (we must separate when there is no internet connection)

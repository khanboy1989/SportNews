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

Let's observe the layers with more deeply:

- Domain Layer = Entities + Use Cases + Repositories Interfaces
- Data Repositories Layer = Repositories Implementations + API (Network) + Persistence DB (if applicable)
- Screen Layer (MVVM) = ViewModels + Views

Dependecy Direction:

Screen Layer (MVVM - Dependecy) => Domain Layer (Business Logic) <= Data Layer (Data Repositories)

Note: Domain Layer should not include anything from other layers(e.g Screen — UIKit or SwiftUI or Data Layer — Mapping Codable)

Additional Frameworks:
Swiflint : Used to have standart on the code such as coloum spacing, vertical spacing (here the swiftlint.yml file is copied from AIRBNB app)
Swiftgen: Used to create the assets for Images, Localizable and Colors
KingFisher: Used for loading images with caching feature in order to avoid image loading each time when the app launches

How to use app

Launch the application and main screen will be appear if you have the internet connection you will be receiving the News about sport events such as:

- Football
- Winter Sports
- Motor Sports
- Sport Mix
- Esports


# Soc App

### Prerequisite

 - Flutter Version: 3.10.0
 - Dart Version: 3.0.0
 ### Installation
 You can check on firebase app distribution:

 - Install firebase app distribution (appstore/playstore)
 - Accept invitation in your email
 - Open firebase distribution and install the app

### Codebase
- Clean Architecture:
Clean Architecture really makes the app more maintanable by seperating the layers, as we see in the codebase the goals is to make the relationship between layers loose coupled. So, for example if we want to change the data source method we can just change the module, as long as the return object is still the same. Because of that, we don't need to modify the entire codebase for the change. Here is the visualization:
	![Clean Coder Blog](https://blog.cleancoder.com/uncle-bob/images/2012-08-13-the-clean-architecture/CleanArchitecture.jpg)

In our code base the folder is seperated like this:
![enter image description here](https://gcdnb.pbrd.co/images/Lpi9OJG38mRY.png?o=1 )
The project goals is to seperate the folder by layer as the clean architecture principle. the project utility is in core folder such like dependency injections, network, module, and etc.

The features files contains the feature/requirements of the project, seperating feature by folders, so every feature folder has data, domain, and presentation layer.
![enter image description here](https://gcdnb.pbrd.co/images/QPf9Ys3SKjZ6.png?o=1)
 
 Using this this approach really helps me to have a clear understanding about the objects, how the object interact to another and how the object have a single responsibility of its own function.
### State Management
I am using bloc/cubit for the state management. Because, it is simple, makes our development time faster, and powerfull especially for our project scope.

### Packages
|Packages|  Descriptions|
|--|--|
| Graphql_flutter |Provides media communication between client and graphql server  |
| google_fonts| Easy implement of material fonts|
| firebase_auth| To using firebase authentication|
| firebase_core| To using firebase core functions and models|
| firebase_storage| To using firebase storage functions|
| hive| Helps to store the data, using for user's session|
| flutter_bloc| We use bloc/cubit for the state management|
| injectable| Helps to pattern mathcing for classes/objects|
| image_picker| for pick image from camera or directory|
| dartz| Cutting boilerplate codes in DTO from data to presentation layer|
| get_it| Just give the dependency injection works to get_it, it will generates our classes access|





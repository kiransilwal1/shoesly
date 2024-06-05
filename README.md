# This branch is still under development

# Shoesly Project

A Shoesly project created in flutter using Bloc. Shoesly supports web, mobile(iOS/Android),Linux, MacOS and web, clone the appropriate branches mentioned below:

* [HTTPS: [git@github.com:kiransilwal1/shoesly.git](https://github.com/kiransilwal1/shoesly.git)]

## Getting Started

The Shoesly contains the minimal implementation required to create a new library or project. The repository code is preloaded with some basic components like basidc app architecture, app theme, constants and required dependencies to create a new project. By using boiler plate code as standard initializer, we can have same patterns in all the projects that will inherit it. This will also help in reducing setup & development time by allowing you to use same code pattern and avoid re-writing from scratch.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/kiransilwal1/shoesy
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `vscode dart-dataclass generator` libpluginrary that works with code generation. It is recommended to use the package. Since the dataclass generates hashes for object comparisions, equatable is not used.
In addition to that, since there are less pages as of now, named routes are not used. Since it is eCommerce App, go_router shall be used in upcoming versions. 



## Boilerplate Features and Folder Structure:

```
└── 📁lib 
    └── 📁core 
        └── 📁constants
        └── 📁cubit 
        └── 📁entities
        └── 📁error
        └── 📁models
        └── 📁network
        └── 📁theme
        └── 📁usecase
        └── 📁utils
        └── 📁widgets
    └── dependencies.dart
    └── 📁features
        └── .DS_Store
        └── 📁paywall
        └── 📁product_cart
        └── 📁product_detail
        └── 📁product_discover
        └── 📁product_review
    └── firebase_options.dart
    └── main.dart
```

The folder structure for the project is illustrate above. The code is divided into two main parts.

* Core
* Features

### Features

Feature folder contains all the high level features the app has. For example the current app has, Product discover from where user can view the shoes. The Product detail feature is the feature that encompases all the details of the product and their variations and so on and so forth. The Features folder is divided more into subfolders.

* Data Folder: This layer is responsible for mainting incoming and outgoing of data that are relevant for the feature. If it is a product discover feature then this domain will want to connect to APIs across the internet, fetch data and prepares the data.

* Domain Folder: This is the major layer and acts as a proxy between data and presentation. Domain layers contains abstract interfaces that act as contracts for the state and data. Both data layer and presentation layer shall follow what the domain says. This will loosely couple data and UI. 

Presentation Layer: This layer contains all the UI and states that are relevant for the feature. 

```
└── 📁product_discover
    └── 📁data
    └── 📁domain
    └── 📁presentation
```


### Core

Core folder contains all the classes, objects and codes that are shared across the app. They are accessible from everywhere inside the project. Whenever two or more features need to access the same class, objects or helpers, such codes are moved upward in the tree to core features. The main purpose is, the app shall work perfectly even if we delete one feature. Helper classes, Error classes, Constants, Themedata, Buttons are some important files that are used across multiple features.


## Libraries and tools used:


   cupertino_icons: ^1.0.2
   flutter_bloc: ^8.1.5
   flutter_svg: ^2.0.10+1
   expandable: ^5.0.1
   firebase_core: ^2.24.2
   fpdart: ^1.1.0
   cloud_firestore: ^4.14.0
   cached_network_image: ^3.3.1
   path_provider: ^2.1.2
   supabase_flutter: ^2.5.4
   shimmer: ^3.0.0
   shared_preferences: ^2.2.2
   internet_connection_checker_plus: ^2.1.0
   get_it: ^7.7.0

  * The app uses Flutter bloc for state management. Bloc and cubits are extenisvely used across all the features to manage the state of the App. 
  
  * Flutter SVG is used to render SVG icons.
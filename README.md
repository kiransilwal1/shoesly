# This is a first version of the Shoesly App.

# Shoesly Project

A Shoesly project created in flutter using Bloc. Shoesly supports web, mobile(iOS/Android),Linux, MacOS and web, clone the appropriate branches mentioned below:

- [HTTPS: [git@github.com:kiransilwal1/shoesly.git](https://github.com/kiransilwal1/shoesly.git)]

## Getting Started

The Shoesly contains the minimal implementation required to create a new library or project. The repository code is preloaded with some basic components like basidc app architecture, app theme, constants and required dependencies to create a new project. By using boiler plate code as standard initializer, we can have same patterns in all the projects that will inherit it. This will also help in reducing setup & development time by allowing you to use same code pattern and avoid re-writing from scratch.

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/kiransilwal1/shoesly
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

This project uses `vscode dart-dataclass generator` library that works with code generation. It is recommended to use the package. Since the dataclass generates hashes for object comparisions, equatable is not used.
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

- Core
- Features

### Features

Feature folder contains all the high level features the app has. For example the current app has, Product discover from where user can view the shoes. The Product detail feature is the feature that encompases all the details of the product and their variations and so on and so forth. The Features folder is divided more into subfolders.

- Data Folder: This layer is responsible for mainting incoming and outgoing of data that are relevant for the feature. If it is a product discover feature then this domain will want to connect to APIs across the internet, fetch data and prepares the data.

- Domain Folder: This is the major layer and acts as a proxy between data and presentation. Domain layers contains abstract interfaces that act as contracts for the state and data. Both data layer and presentation layer shall follow what the domain says. This will loosely couple data and UI.

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

- **flutter_bloc:** The app uses Flutter bloc for state management. Bloc and cubits are extenisvely used across all the features to manage the state of the App.

- **flutter_svg** Flutter SVG is used to render SVG icons.

- **Expandable** is used to expand widgets to show more details.

- **fpdart** is used to encapsulate exceptions with erors and failures

- **Cached_network_image** is used for caching network image.

- **Path provider** to navigate between root folders.

- **supabase_flutter** instead of using firebase, this project uses supabase. Supabase makes backend handling pretty straight forward and super easy. On top of that, this is one of the best BaaS available without needing a Card.

- **Shimmer** This package is used to implement shimmer effect across multiple pages.

- **shared_preferences** Shared preferences is used to store cart data in local storage so that the state persists even after the user quits the app during purchase.

- **internet_connection_checker_plus** This is used to check internet connection and provide necessary information to the user.

- **get_it** Getit used for dependency injection.

# Major Assumptions

    Following are the assumptions made before developing the App.

    1. All the themes contained inside the figma are absolute and there are no customizations in the fonts, buttons and color that needs manual importing into themedata file.
    2. The backend doesn't remove background of the thumbnail image. An image without background shall be uploaded since the design expects it.
    3. Variations of products are not needed in landing page. They are only needed in detail and cart page.
    4. Supabase can be used in place of firebase.
    5. Brand Names and Brand Images are supposed to be imported from design file regardless of their performance and sizes.

# Challenges

    1. Extracting UI components according to the theme in design file.
    2. Some components need customizations from what flutter already has in the store.
    3. Preparing dummy data was a major challenge. Used locally installed Llama3:8b to create reviews, ratings and other dummy data.
    4. Though Fitler and Discover are supposed to be separate features, in this project they have a lot of components and states that are shared. Had to write the business logic twice.
    5. One button in product detail page doesn't uses button theme available across the app. Manually  created the button. Easier instead of sending text theme to the button component :D

# Additional Features

    1. Added pages for empty result.
    2. Added Alerts for errors and notifications.
    3. Added double support on ratings instead of int support. Rating 4.5 will paint 4 and half stars.
    4. Added Shimmer for proper loading.

Though the functionality of the app is in par with the initial thought process **(thanks to my previous projects on eCommerce I was able to bring in some of the features from there)**. The project is handled by a single person in 5 days. That included databse designs and setup Supabase from scratch. Code done in a rush is not a work done on a hush. The code is very poor and there are a lots of areas to improve. Some of the business logics are tightly coupled. In some usecases. Data Layer directly access the Data Entity instead of Data Model. These needs to be sorted out in upcoming versions.

https://github.com/kiransilwal1/shoesly/assets/88090804/b278b779-5967-4e17-8855-ca656e47f840

## Button Types

Mainly buttons can be catorized on the basis of variants and configurations.

1.  Variants
    Variants are the major categorization critera. It determines whether the button is primary or secondary.
    a. Primary
    b. Secondary
    c. text/minimal

2.  Configurations
    Either the button has only label, button has icon at the leading or trailing position and button has Icon only
    a. Label only
    b. Leading Icon with Label
    c. Trailing Icon with Label
    d. Icon only

So there will be (4 \* 3) = 12 different button variants. The style of the button shall be provided.
In the core folder, inside widget there are 4 files. button_styles.dart defines all the button configuration styles that are possible for the button. Remaining 3 files minimal_buttons.dart, primary_buttons.dart and secondary_button.dart defines the buttons on the basis of variants.

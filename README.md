# This branch is still under development

# Shoesly Project

A Shoesly project created in flutter using Bloc. Shoesly supports web, mobile(iOS/Android),Linux, MacOS and web, clone the appropriate branches mentioned below:

* [For Mobile: https://github.com/kiransilwal1/shoesly]

## Getting Started

The Shoesly contains the minimal implementation required to create a new library or project. The repository code is preloaded with some basic components like basic app architecture, app theme, constants and required dependencies to create a new project. By using boiler plate code as standard initializer, we can have same patterns in all the projects that will inherit it. This will also help in reducing setup & development time by allowing you to use same code pattern and avoid re-writing from scratch.

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

This project uses `vscode dart-dataclass generator` libpluginrary that works with code generation. It is recommended to use the package. Since the dataclass generates hashes for object comparisions, equatable is not used.
In addition to that, since there are less pages as of now, named routes are not used. Since it is eCommerce App, go_router shall be used in upcoming versions. 



## Boilerplate Features and Folder Structure:

```
└── 📁lib
    └── .DS_Store
    └── 📁core
        └── .DS_Store
        └── 📁constants
            └── constants.dart
        └── 📁cubit
            └── cart_status_cubit.dart
            └── cart_status_state.dart
        └── 📁entities
            └── brands.dart
            └── product_discover_entity.dart
            └── product_variation.dart
        └── 📁error
            └── exceptions.dart
            └── failures.dart
        └── 📁models
            └── brand_model.dart
            └── cart_model.dart
            └── product_model.dart
            └── product_variation_model.dart
        └── 📁network
            └── connection_checker.dart
        └── 📁theme
            └── app_theme.dart
        └── 📁usecase
            └── usecase.dart
        └── 📁utils
            └── snackbar.dart
        └── 📁widgets
            └── .DS_Store
            └── alert.dart
            └── 📁buttons
                └── button_styles.dart
                └── minimal_buttons.dart
                └── primary_buttons.dart
                └── secondary_buttons.dart
            └── custom_app_bar.dart
            └── rating_star.dart
            └── reviews.dart
            └── 📁shimmers
                └── horizontal_buttons_shimmer.dart
                └── horizontal_circular.dart
                └── shimmer_container_hard.dart
                └── shimmer_container_rounded.dart
            └── thumb_selector.dart
    └── dependencies.dart
    └── 📁features
        └── .DS_Store
        └── 📁paywall
            └── 📁data
                └── 📁datasources
                └── 📁models
                ├── repositories
            └── 📁domain
                └── 📁entities
                └── 📁repositories
                ├── usecases
            └── 📁presentation
                └── 📁bloc
                    └── paywall_bloc.dart
                    └── paywall_event.dart
                    └── paywall_state.dart
                └── 📁pages
                    └── order_summary.dart
                ├── widgets
        └── 📁product_cart
            └── 📁data
                └── 📁datasources
                    └── cart_local_data.dart
                └── 📁models
                └── 📁repositories
                    └── cart_repo_impl.dart
            └── 📁domain
                └── 📁entities
                    └── bulk_add_params.dart
                    └── cart.dart
                └── 📁repositories
                    └── cart_repo.dart
                └── 📁usecases
                    └── add_product_to_cart.dart
                    └── bulk_add_to_cart.dart
                    └── delete_from_cart.dart
                    └── remove_from_cart.dart
                    └── view_cart.dart
            └── 📁presentation
                └── 📁bloc
                    └── product_cart_bloc.dart
                    └── product_cart_event.dart
                    └── product_cart_state.dart
                └── 📁pages
                    └── cart_page.dart
                └── 📁widgets
                    └── shimmer_cart_page.dart
        └── 📁product_detail
            └── 📁data
                └── 📁datasources
                    └── product_detail_remote.dart
                └── 📁models
                    └── product_detail_model.dart
                    └── product_model.dart
                    └── product_review_mode.dart
                └── 📁repositories
                    └── product_detail_repo_impl.dart
            └── 📁domain
                └── 📁entities
                    └── product_detail_entity.dart
                    └── product_entity.dart
                    └── product_review.dart
                └── 📁repositories
                    └── product_detail_rep.dart
                └── 📁usecases
                    └── product_detail_load_usecase.dart
            └── 📁presentation
                └── 📁bloc
                    └── product_detail_bloc.dart
                    └── product_detail_event.dart
                    └── product_detail_state.dart
                └── 📁pages
                    └── product_detail_page.dart
                └── 📁widgets
                    └── product_detail_thumbnail.dart
                    └── shimmer_product_detail.dart
                    └── size_option_view.dart
                    └── text_field_plus_minus.dart
        └── 📁product_discover
            └── .DS_Store
            └── 📁data
                └── 📁datasources
                    └── product_remote_datasource.dart
                └── 📁models
                    └── filter_params_model.dart
                    └── product_data_model.dart
                    └── variation_model.dart
                └── 📁repositories
                    └── product_repo_impl.dart
            └── 📁domain
                └── 📁entities
                    └── color_entites.dart
                    └── filter_entity.dart
                    └── filter_params.dart
                    └── product_data_entity.dart
                    └── variation_entities.dart
                └── 📁repositories
                    └── product_discover_repo.dart
                └── 📁usecases
                    └── filter_params_collect.dart
                    └── filter_product_page_usecase.dart
                    └── product_discover_usecase.dart
            └── 📁presentation
                └── .DS_Store
                └── 📁bloc
                    └── product_discover_bloc.dart
                    └── product_discover_event.dart
                    └── product_discover_state.dart
                └── 📁pages
                    └── product_discover_page.dart
                    └── product_filter.dart
                └── 📁widgets
                    └── brand_search.dart
                    └── brand_selector.dart
                    └── chip_selector.dart
                    └── color_selector.dart
                    └── price_range_slider.dart
                    └── product_card.dart
                    └── product_rating.dart
                    └── shimmer_discover_page.dart
                    └── shimmer_filter_page.dart
        └── 📁product_review
            └── 📁data
                └── 📁datasources
                └── 📁models
                ├── repositories
            └── 📁domain
                └── 📁entities
                └── 📁repositories
                ├── usecases
            └── 📁presentation
                └── 📁bloc
                    └── product_review_bloc.dart
                    └── product_review_event.dart
                    └── product_review_state.dart
                └── 📁pages
                    └── product_review.dart
                ├── widgets
    └── firebase_options.dart
    └── main.dart
```

### Up-Coming Features:


### Libraries & Tools Used

* [Dio](https://github.com/flutterchina/dio)
* [Database](https://github.com/tekartik/sembast.dart)
* [MobX](https://github.com/mobxjs/mobx.dart) (to connect the reactive data of your application with the UI)
* [Provider](https://github.com/rrousselGit/provider) (State Management)
* [Encryption](https://github.com/xxtea/xxtea-dart)
* [Validation](https://github.com/dart-league/validators)
* [Logging](https://github.com/zubairehman/Flogs)
* [Notifications](https://github.com/AndreHaueisen/flushbar)
* [Json Serialization](https://github.com/dart-lang/json_serializable)
* [Dependency Injection](https://github.com/fluttercommunity/get_it)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- constants/
|- data/
|- stores/
|- ui/
|- utils/
|- widgets/
|- main.dart
|- routes.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
2- data - Contains the data layer of your project, includes directories for local, network and shared pref/cache.
3- stores - Contains store(s) for state-management of your application, to connect the reactive data of your application with the UI. 
4- ui — Contains all the ui of your project, contains sub directory for each screen.
5- util — Contains the utilities/common functions of your application.
6- widgets — Contains the common widgets for your applications. For example, Button, TextField etc.
7- routes.dart — This file contains all the routes for your application.
8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Constants

This directory contains all the application level constants. A separate file is created for each type as shown in example below:

```
constants/
|- app_theme.dart
|- dimens.dart
|- endpoints.dart
|- preferences.dart
|- strings.dart
```

### Data

All the business logic of your application will go into this directory, it represents the data layer of your application. It is sub-divided into three directories `local`, `network` and `sharedperf`, each containing the domain specific logic. Since each layer exists independently, that makes it easier to unit test. The communication between UI and data layer is handled by using central repository.

```
data/
|- local/
    |- constants/
    |- datasources/
    |- app_database.dart
   
|- network/
    |- constants/
    |- exceptions/
    |- rest_client.dart
    
|- sharedpref
    |- constants/
    |- shared_preference_helper.dart
    
|- repository.dart

```

### Stores

The store is where all your application state lives in flutter. The Store is basically a widget that stands at the top of the widget tree and passes it's data down using special methods. In-case of multiple stores, a separate folder for each store is created as shown in the example below:

```
stores/
|- login/
    |- login_store.dart
    |- form_validator.dart
```

### UI

This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `widgets` directory as shown in the example below:

```
ui/
|- login
   |- login_screen.dart
   |- widgets
      |- login_form.dart
      |- login_button.dart
```

### Utils

Contains the common file(s) and utilities used in a project. The folder structure is as follows: 

```
utils/
|- encryption
   |- xxtea.dart
|- date
  |- date_time.dart
```

### Widgets

Contains the common widgets that are shared across multiple screens. For example, Button, TextField etc.

```
widgets/
|- app_icon_widget.dart
|- empty_app_bar.dart
|- progress_indicator.dart
```

### Routes

This file contains all the routes for your application.

```dart
import 'package:flutter/material.dart';

import 'ui/post/post_list.dart';
import 'ui/login/login.dart';
import 'ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/post';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
  };
}
```

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:boilerplate/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'ui/splash/splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: SplashScreen(),
    );
  }
}
```

## Wiki

Checkout [wiki](https://github.com/zubairehman/flutter-boilerplate-project/wiki) for more info

## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the boilerplate then please feel free to submit an issue and/or pull request 🙂

Again to note, this is example can appear as over-architectured for what it is - but it is an example only. If you liked my work, don’t forget to ⭐ star the repo to show your support.

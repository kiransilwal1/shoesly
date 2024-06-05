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
    └── 📁core - ## Core common components and features used by all child features.
        └── 📁constants - Contain constants
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

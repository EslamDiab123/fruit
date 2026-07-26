# Grabber Grocery Home Page

Grabber is a Flutter grocery Home Page built for the FAD Flutter Qualification Challenge. It includes product search, category selection, favourites, a promotional carousel, cart quantity controls, a basket sheet, and bottom navigation.

## Responsive layout

The page keeps a compact two-column product grid on phones. Tablet layouts center the content, use a larger two-column grid, and scale the header, categories, product cards, and navigation without changing the mobile design.

## Project structure

```text
lib/
├── main.dart
├── core/
│   └── app_theme.dart
└── features/
    ├── home/
    │   ├── data/
    │   │   └── home_data.dart
    │   ├── models/
    │   │   └── home_models.dart
    │   ├── view_models/
    │   │   └── home_view_model.dart
    │   └── views/
    │       ├── home_page.dart
    │       └── widgets/
    │           ├── home_header.dart
    │           ├── promo_banner.dart
    │           ├── category_item.dart
    │           ├── product_card.dart
    │           └── home_bottom_bars.dart
    └── splash/
        └── views/
            └── splash_page.dart
```

The Home feature follows a lightweight MVVM structure. `HomeViewModel` manages search, category and navigation selection, favourites, cart state, and persistence. The views contain layout code, while the models and static data remain independent of the UI. Splash is a view-only feature because it has no application state of its own.

## Run the project

```bash
flutter pub get
flutter run
```

To check formatting, analysis, and widget tests:

```bash
dart format .
flutter analyze
flutter test
```

The tests cover the Home ViewModel, mobile and tablet rendering, product-grid geometry, scrolling, search, cart interaction, and layout overflows.

## Demo video

https://github.com/user-attachments/assets/49dc265e-b695-4ff2-9be6-bbf0ef1c987c

## Download APK

[Download the Android APK](https://docs.google.com/uc?export=download&id=1fePrrQ7S-su2XEEBrO0AEvITRVPZLkxi)

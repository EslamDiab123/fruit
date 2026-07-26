# Grabber – Grocery Store

A Flutter grocery-store application built for the **FAD Flutter Qualification Challenge**.

---

## Project description

Grabber is a mobile-first grocery-shopping app that lets users browse product categories, search for items, add them to a cart, and manage their basket — all with a clean, responsive UI that adapts from small phones to tablets.

---

## Challenge objective

This project was submitted for the FAD Flutter Qualification Challenge.

**Selected challenge screen: Home Page**

The Home Page was chosen as the challenge submission screen. It demonstrates responsive design, reusable widget architecture, local state management, SharedPreferences-backed cart persistence, and widget-test coverage at multiple viewport sizes.

---

## Home Page features

| Feature | Details |
|---|---|
| **Header** | Delivery address row + morning greeting |
| **Search field** | Live local filtering of the product grid |
| **Promo banner** | Auto-playing `CarouselSlider` with animated dot indicators |
| **Categories** | Horizontally scrolling, selectable category tiles |
| **Product grid** | Responsive `SliverGrid` (2 columns on phones, more on tablets) |
| **Product card** | Image, name, star rating, price, favourite button, add/remove controls |
| **Cart bar** | Floating green bar with item thumbnails and total badge |
| **Basket sheet** | Draggable bottom sheet with quantity controls |
| **Bottom nav** | Five-tab nav bar pre-selected on Home, green top-indicator |

---

## Responsive design

The layout uses:

- `CustomScrollView` + `SliverGrid` as the outer scroll container
- `SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 220)` so cards
  reflow automatically — 2 columns on 360 px phones, 3–4 on 768 px tablets
- `MediaQuery.sizeOf(context)` for banner height clamping (`150 – 300 px`)
- `Expanded` / `Flexible` throughout; no fixed pixel widths on containers
- `SafeArea` on the header sliver and the floating cart bar
- `SafeArea(top: false)` wrapping the bottom navigation bar

---

## Reusable widgets

| Widget | Location |
|---|---|
| `GroceryHeader` | `lib/features/home/presentation/widgets/grocery_header.dart` |
| `SearchField` | `lib/features/home/presentation/widgets/search_field.dart` |
| `PromoBanner` | `lib/features/home/presentation/widgets/promo_banner.dart` |
| `CategoryItem` | `lib/features/home/presentation/widgets/category_item.dart` |
| `SectionHeader` | `lib/features/home/presentation/widgets/section_header.dart` |
| `ProductCard` | `lib/features/home/presentation/widgets/product_card.dart` |
| `CartBottomBar` | `lib/features/home/presentation/widgets/cart_bottom_bar.dart` |
| `GroceryBottomNav` | `lib/features/home/presentation/widgets/grocery_bottom_nav.dart` |

---

## Project structure

```
lib/
├── core/
│   └── constants/
│       ├── app_colors.dart          # Brand color palette
│       └── app_text_styles.dart     # Typography (system font)
├── features/
│   └── home/
│       ├── data/
│       │   └── home_data.dart       # Static mock data
│       └── presentation/
│           ├── pages/
│           │   └── home_page.dart   # Page orchestrator (StatefulWidget)
│           └── widgets/             # 8 reusable widgets (see table above)
├── home.dart                        # Re-export + HomeScreen typedef (compat)
├── main.dart                        # App entry point + ThemeData
├── models.dart                      # Category, Products, CartItem
├── splash.dart                      # 2-second splash screen
└── widgets.dart                     # Legacy AddtoCart / RemoveFromCart (kept)
test/
└── widget_test.dart                 # Widget tests (mobile + tablet sizes)
assets/
├── banners/   Slider 1–3.png
├── Category/  5 category images
├── fruits/    Banana, Limon, Orange, Pepper
├── icons/     SVG + PNG icons
└── logo/      Grabber.svg
```

---

## Setup instructions

### Prerequisites

- Flutter **3.44.5** (stable channel)
- Dart **3.12.2**

Verify with:

```bash
flutter --version
```

### Install dependencies

```bash
flutter pub get
```

### Dependencies used

| Package | Version | Purpose |
|---|---|---|
| `flutter_svg` | ^2.3.0 | SVG asset rendering |
| `carousel_slider` | ^5.1.2 | Promotional banner |
| `shared_preferences` | ^2.5.5 | Cart persistence |

No new packages were added for the challenge work.

---

## How to run the app

```bash
# Android / iOS emulator
flutter run

# Chrome (web)
flutter run -d chrome

# Windows desktop
flutter run -d windows
```

---

## How to run the tests

```bash
flutter test
```

Tests are in `test/widget_test.dart` and cover:

- Rendering at **360 × 800** (narrow mobile)
- Rendering at **768 × 1024** (tablet)
- Search field presence
- `SectionHeader` visibility
- `ProductCard` presence
- No layout overflow at tablet size
- Search filtering (single match + no match + empty state)
- Add-to-cart interaction

Carousel auto-play is disabled in tests via `HomePage(enableBannerAutoPlay: false)`
to prevent timer-based hangs when using `WidgetTester.pump`.

---

## Screenshots

> Screenshots must be captured manually after running the app on a target device
> or emulator.  Run `flutter run` (or `flutter run -d chrome` / `flutter run -d windows`),
> resize the window, and save the captures to `screenshots/`.
>
> Suggested filenames:
> - `screenshots/home_mobile_360.png`
> - `screenshots/home_tablet_768.png`

---

## Analyzer and formatting

```bash
dart format .
flutter analyze
```

Both commands should complete with zero issues after `flutter pub get`.

---

## Git history

This project was not in a Git repository when the challenge work started.
To initialise and commit the implementation:

```bash
git init
git add .
git commit -m "chore: initial project state"
git add lib/core lib/features lib/home.dart lib/widgets.dart lib/main.dart
git commit -m "refactor: organise grocery home feature into lib/features"
git add test/widget_test.dart
git commit -m "test: add responsive grocery home widget tests"
git add README.md .gitignore
git commit -m "docs: update challenge README and gitignore"
```

/// Compatibility re-export so that [splash.dart] and any other file that
/// imports `package:fruit/home.dart` and references [HomeScreen] continues
/// to work without modification.
///
/// The actual implementation lives in:
///   lib/features/home/presentation/pages/home_page.dart
library;

import 'package:fruit/features/home/presentation/pages/home_page.dart';

export 'package:fruit/features/home/presentation/pages/home_page.dart';

/// Backward-compatible alias for [HomePage].
typedef HomeScreen = HomePage;

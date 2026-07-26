/// Responsive breakpoint constants for the Grabber grocery app.
///
/// Usage:
/// ```dart
/// final double w = MediaQuery.sizeOf(context).width;
/// if (w >= AppBreakpoints.tablet) { /* tablet layout */ }
/// ```
class AppBreakpoints {
  AppBreakpoints._();

  /// Screens narrower than this value are treated as **mobile**.
  static const double tablet = 600.0;

  /// Screens wider than this value are treated as **wide desktop**.
  static const double desktop = 1100.0;
}

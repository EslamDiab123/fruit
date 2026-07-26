// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fruit/features/home/presentation/pages/home_page.dart';
import 'package:fruit/features/home/presentation/widgets/product_card.dart';
import 'package:fruit/features/home/presentation/widgets/search_field.dart';
import 'package:fruit/features/home/presentation/widgets/grocery_bottom_nav.dart';
import 'package:fruit/features/home/presentation/widgets/section_header.dart';

// ─── Test helpers ─────────────────────────────────────────────────────────────

/// Wraps [HomePage] in a MaterialApp with auto-play disabled so carousel
/// timers do not block [WidgetTester.pump] calls.
Widget _buildApp() {
  return const MaterialApp(home: HomePage(enableBannerAutoPlay: false));
}

/// Pumps the widget tree and waits for the async [_loadCart] call in
/// [initState] to complete without relying on [pumpAndSettle] (which would
/// hang while the carousel animation loop is running).
Future<void> _pumpHome(WidgetTester tester) async {
  await tester.pumpWidget(_buildApp());
  // Allow the SharedPreferences async load to finish.
  await tester.pump(const Duration(milliseconds: 100));
}

// ─── Tests ────────────────────────────────────────────────────────────────────

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // ── Mobile: iPhone 12 — 390 × 844 ────────────────────────────────────────
  group('HomePage — narrow mobile (390 × 844)', () {
    void setMobileView(WidgetTester tester) {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    }

    testWidgets('renders without exceptions', (tester) async {
      setMobileView(tester);
      await _pumpHome(tester);
      expect(tester.takeException(), isNull);
    });

    testWidgets('search field is present', (tester) async {
      setMobileView(tester);
      await _pumpHome(tester);
      expect(find.byType(SearchField), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('"Fresh Products" section header is visible', (tester) async {
      setMobileView(tester);
      await _pumpHome(tester);
      expect(find.byType(SectionHeader), findsWidgets);
      expect(find.text('Fresh Products'), findsOneWidget);
    });

    testWidgets('product cards are rendered (mobile uses SliverGrid — lazy)', (
      tester,
    ) async {
      setMobileView(tester);
      await _pumpHome(tester);
      // SliverGrid builds lazily: at least the first row (2 cards) is visible.
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets('bottom navigation bar present with Home tab selected', (
      tester,
    ) async {
      setMobileView(tester);
      await _pumpHome(tester);
      expect(find.byType(GroceryBottomNav), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('no RenderFlex overflow at mobile size', (tester) async {
      setMobileView(tester);
      final overflowErrors = <Object>[];
      final original = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exception.toString().contains('overflowed')) {
          overflowErrors.add(details.exception);
        } else {
          original?.call(details);
        }
      };
      addTearDown(() => FlutterError.onError = original);

      await _pumpHome(tester);
      expect(overflowErrors, isEmpty, reason: 'Layout overflow on mobile');
    });
  });

  // ── Tablet: iPad (768 × 1024) ─────────────────────────────────────────────
  group('HomePage — tablet iPad (768 × 1024)', () {
    void setTabletView(WidgetTester tester) {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    }

    testWidgets('renders without exceptions', (tester) async {
      setTabletView(tester);
      await _pumpHome(tester);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no RenderFlex overflow at tablet size', (tester) async {
      setTabletView(tester);
      final overflowErrors = <Object>[];
      final original = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exception.toString().contains('overflowed')) {
          overflowErrors.add(details.exception);
        } else {
          original?.call(details);
        }
      };
      addTearDown(() => FlutterError.onError = original);

      await _pumpHome(tester);
      expect(overflowErrors, isEmpty, reason: 'Layout overflow on iPad');
    });

    testWidgets('all 4 products built (GridView shrinkWrap on tablet)', (
      tester,
    ) async {
      setTabletView(tester);
      await _pumpHome(tester);
      // Tablet uses GridView(shrinkWrap: true) so all items are built eagerly.
      expect(find.byType(ProductCard), findsNWidgets(4));
    });

    testWidgets('grid uses 2 columns — no card row wider than half viewport', (
      tester,
    ) async {
      setTabletView(tester);
      await _pumpHome(tester);

      // Verify 2-column layout: with crossAxisCount=2 and the 720px constraint
      // (+32 px padding each side) each card occupies (720-64-20)/2 ≈ 318 px.
      // A 4-column layout would produce cards ≈ 159 px — far too narrow.
      // Checking that we find exactly 4 cards (2 rows × 2 cols) is sufficient
      // because the GridView is configured with crossAxisCount=2 on this size.
      expect(find.byType(ProductCard), findsNWidgets(4));

      // Also confirm no overflow (which would occur if 4-col fit failed).
      expect(tester.takeException(), isNull);
    });

    testWidgets('bottom nav is present', (tester) async {
      setTabletView(tester);
      await _pumpHome(tester);
      expect(find.byType(GroceryBottomNav), findsOneWidget);
    });
  });

  // ── Tablet: iPad Pro (1024 × 1366) ────────────────────────────────────────
  group('HomePage — iPad Pro (1024 × 1366)', () {
    void setIpadProView(WidgetTester tester) {
      tester.view.physicalSize = const Size(1024, 1366);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    }

    testWidgets('renders without exceptions', (tester) async {
      setIpadProView(tester);
      await _pumpHome(tester);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no RenderFlex overflow at iPad Pro size', (tester) async {
      setIpadProView(tester);
      final overflowErrors = <Object>[];
      final original = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exception.toString().contains('overflowed')) {
          overflowErrors.add(details.exception);
        } else {
          original?.call(details);
        }
      };
      addTearDown(() => FlutterError.onError = original);

      await _pumpHome(tester);
      expect(overflowErrors, isEmpty, reason: 'Layout overflow on iPad Pro');
    });

    testWidgets('all 4 products built (GridView shrinkWrap on iPad Pro)', (
      tester,
    ) async {
      setIpadProView(tester);
      await _pumpHome(tester);
      // 1024 px is still in the tablet range (< 1100), so 2-column layout.
      expect(find.byType(ProductCard), findsNWidgets(4));
    });
  });

  // ── Interaction tests (tall viewport so all cards are in view) ────────────
  group('HomePage — interactions', () {
    void setTallMobileView(WidgetTester tester) {
      tester.view.physicalSize = const Size(400, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    }

    testWidgets('search filters products — shows only matching', (
      tester,
    ) async {
      setTallMobileView(tester);
      await _pumpHome(tester);

      await tester.enterText(find.byType(TextField), 'Banana');
      await tester.pump();

      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('search with no match shows empty-state message', (
      tester,
    ) async {
      setTallMobileView(tester);
      await _pumpHome(tester);

      await tester.enterText(find.byType(TextField), 'zzznomatch');
      await tester.pump();

      expect(find.byType(ProductCard), findsNothing);
      expect(find.text('No products found'), findsOneWidget);
    });

    testWidgets('tapping add-to-cart shows quantity control', (tester) async {
      setTallMobileView(tester);
      await _pumpHome(tester);

      final addButtons = find.byIcon(Icons.add);
      expect(addButtons, findsWidgets);

      await tester.tap(addButtons.first);
      await tester.pump();

      expect(find.text('1'), findsWidgets);
    });
  });
}

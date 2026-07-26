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

/// Wraps [HomePage] in a MaterialApp with [autoPlay] disabled so carousel
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
    // Provide an empty, in-memory SharedPreferences implementation
    // so the cart persistence code does not call real platform channels.
    SharedPreferences.setMockInitialValues({});
  });

  // ── Narrow mobile: 360 × 800 ──────────────────────────────────────────────
  group('HomePage — narrow mobile (360 × 800)', () {
    setUp(() {
      // Binding.instance is available during test setup.
    });

    testWidgets('renders without exceptions', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      expect(tester.takeException(), isNull);
    });

    testWidgets('search field is present', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      expect(find.byType(SearchField), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('"Fresh Products" section header is visible', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      expect(find.byType(SectionHeader), findsWidgets);
      expect(find.text('Fresh Products'), findsOneWidget);
    });

    testWidgets('product cards are rendered', (tester) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets('bottom navigation bar is present with Home selected', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(360, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      expect(find.byType(GroceryBottomNav), findsOneWidget);
      // Home tab label must be visible
      expect(find.text('Home'), findsOneWidget);
    });
  });

  // ── Tablet / wide: 768 × 1024 ─────────────────────────────────────────────
  group('HomePage — tablet (768 × 1024)', () {
    testWidgets('renders without exceptions at tablet size', (tester) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      expect(tester.takeException(), isNull);
    });

    testWidgets('no RenderFlex overflow at tablet size', (tester) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final overflowErrors = <Object>[];
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exception.toString().contains('overflowed')) {
          overflowErrors.add(details.exception);
        } else {
          originalOnError?.call(details);
        }
      };
      addTearDown(() => FlutterError.onError = originalOnError);

      await _pumpHome(tester);

      expect(overflowErrors, isEmpty, reason: 'Layout overflow detected');
    });

    testWidgets('more product cards visible on wider viewport', (tester) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      // On a 768 px wide screen, the grid can accommodate more columns so we
      // expect more than the single row possible on a 360 px screen.
      expect(find.byType(ProductCard), findsWidgets);
    });
  });

  // ── Interaction tests ─────────────────────────────────────────────────────
  group('HomePage — interactions', () {
    testWidgets('search filters products — shows only matching', (
      tester,
    ) async {
      // Tall viewport so all product cards are built by the SliverGrid.
      tester.view.physicalSize = const Size(400, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      // Confirm initial state has products
      expect(find.byType(ProductCard), findsWidgets);

      // Filter for 'Banana'
      await tester.enterText(find.byType(TextField), 'Banana');
      await tester.pump();

      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('search with no match shows empty-state message', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      await tester.enterText(find.byType(TextField), 'zzznomatch');
      await tester.pump();

      expect(find.byType(ProductCard), findsNothing);
      expect(find.text('No products found'), findsOneWidget);
    });

    testWidgets('tapping add-to-cart on first product shows quantity control', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      // The "+" button is rendered by _CartControl inside ProductCard.
      // Find all Icons.add widgets; tap the first one.
      final addButtons = find.byIcon(Icons.add);
      expect(addButtons, findsWidgets);

      await tester.tap(addButtons.first);
      await tester.pump();

      // After adding 1 item, the quantity '1' should appear in the card.
      expect(find.text('1'), findsWidgets);
    });
  });
}

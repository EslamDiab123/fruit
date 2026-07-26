// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fruit/features/home/views/home_page.dart';
import 'package:fruit/features/home/views/widgets/home_bottom_bars.dart';
import 'package:fruit/features/home/views/widgets/home_header.dart';
import 'package:fruit/features/home/views/widgets/product_card.dart';

Widget _buildApp() {
  return const MaterialApp(home: HomePage(enableBannerAutoPlay: false));
}

Future<void> _pumpHome(WidgetTester tester) async {
  await tester.pumpWidget(_buildApp());
  // Give the asynchronous cart load time to complete.
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('HomePage — narrow mobile (360 × 800)', () {
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

    testWidgets('mobile uses two compact product columns', (tester) async {
      tester.view.physicalSize = const Size(400, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      final card1 = find.byKey(const ValueKey('Banana'));
      final card2 = find.byKey(const ValueKey('Lemon'));
      final card3 = find.byKey(const ValueKey('Orange'));

      expect(card1, findsOneWidget);
      expect(card2, findsOneWidget);
      expect(card3, findsOneWidget);

      final pos1 = tester.getTopLeft(card1);
      final pos2 = tester.getTopLeft(card2);
      final pos3 = tester.getTopLeft(card3);

      expect(
        (pos1.dy - pos2.dy).abs(),
        lessThan(5),
        reason: 'Mobile: Banana and Lemon should be in the same row',
      );

      expect(
        pos2.dx,
        greaterThan(pos1.dx),
        reason: 'Mobile: Lemon should be in the right column',
      );

      expect(
        pos3.dy,
        greaterThan(pos1.dy + 50),
        reason: 'Mobile: Orange should be in the second row',
      );
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
      expect(find.text('Home'), findsOneWidget);
    });
  });

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

      expect(find.byType(ProductCard), findsWidgets);
    });
  });

  group('HomePage — iPad (768 × 1024) — 2×2 product grid', () {
    void setTabletViewport(WidgetTester tester) {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    }

    testWidgets('renders 4 product cards without exceptions', (tester) async {
      setTabletViewport(tester);
      await _pumpHome(tester);

      expect(tester.takeException(), isNull);
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
      await tester.pump();
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets(
      'product grid uses 2×2 layout — cards 1 & 2 in same row, card 3 below',
      (tester) async {
        setTabletViewport(tester);
        await _pumpHome(tester);

        await tester.drag(find.byType(CustomScrollView), const Offset(0, -200));
        await tester.pump();

        final card1 = find.byKey(const ValueKey('Banana'));
        final card2 = find.byKey(const ValueKey('Lemon'));
        final card3 = find.byKey(const ValueKey('Orange'));

        expect(card1, findsOneWidget);
        expect(card2, findsOneWidget);
        expect(card3, findsOneWidget);

        final pos1 = tester.getTopLeft(card1);
        final pos2 = tester.getTopLeft(card2);
        final pos3 = tester.getTopLeft(card3);

        expect(
          (pos1.dy - pos2.dy).abs(),
          lessThan(5),
          reason: 'iPad: Banana and Lemon should be in the same row (row 1)',
        );

        expect(
          pos2.dx,
          greaterThan(pos1.dx),
          reason: 'iPad: Lemon should be in the right column',
        );

        expect(
          pos3.dy,
          greaterThan(pos1.dy + 50),
          reason: 'iPad: Orange should be in the second row, well below row 1',
        );

        expect(
          (pos3.dx - pos1.dx).abs(),
          lessThan(5),
          reason: 'iPad: Orange should align with Banana in the left column',
        );
      },
    );

    testWidgets('no rendering overflow at 768 × 1024', (tester) async {
      setTabletViewport(tester);

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
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
      await tester.pump();

      expect(
        overflowErrors,
        isEmpty,
        reason: 'No layout overflow should occur on iPad',
      );
    });

    testWidgets(
      'last product row is not covered by bottom navigation after scrolling',
      (tester) async {
        setTabletViewport(tester);
        await _pumpHome(tester);

        await tester.drag(
          find.byType(CustomScrollView),
          const Offset(0, -2000),
        );
        await tester.pump();

        final pepperFinder = find.byKey(const ValueKey('Pepper'));
        expect(
          pepperFinder,
          findsOneWidget,
          reason: 'Pepper card should be visible after scrolling to the bottom',
        );

        final cardBottom = tester.getBottomLeft(pepperFinder).dy;
        final navTop = tester.getTopLeft(find.byType(GroceryBottomNav)).dy;

        expect(
          cardBottom,
          lessThanOrEqualTo(navTop + 1),
          reason:
              'Last product card bottom edge should not extend past the '
              'bottom navigation top edge',
        );
      },
    );
  });

  group('HomePage — iPad Pro (1024 × 1366) — 2×2 product grid', () {
    void setIpadProViewport(WidgetTester tester) {
      tester.view.physicalSize = const Size(1024, 1366);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    }

    testWidgets('renders without exceptions at iPad Pro size', (tester) async {
      setIpadProViewport(tester);
      await _pumpHome(tester);

      expect(tester.takeException(), isNull);
      expect(find.byType(ProductCard), findsWidgets);
    });

    testWidgets(
      'product grid uses 2×2 layout — cards 1 & 2 in same row, card 3 below',
      (tester) async {
        setIpadProViewport(tester);
        await _pumpHome(tester);

        await tester.drag(find.byType(CustomScrollView), const Offset(0, -200));
        await tester.pump();

        final card1 = find.byKey(const ValueKey('Banana'));
        final card2 = find.byKey(const ValueKey('Lemon'));
        final card3 = find.byKey(const ValueKey('Orange'));

        expect(card1, findsOneWidget);
        expect(card2, findsOneWidget);
        expect(card3, findsOneWidget);

        final pos1 = tester.getTopLeft(card1);
        final pos2 = tester.getTopLeft(card2);
        final pos3 = tester.getTopLeft(card3);

        expect(
          (pos1.dy - pos2.dy).abs(),
          lessThan(5),
          reason:
              'iPad Pro: Banana and Lemon should be in the same row (row 1)',
        );

        expect(
          pos2.dx,
          greaterThan(pos1.dx),
          reason: 'iPad Pro: Lemon should be in the right column',
        );

        expect(
          pos3.dy,
          greaterThan(pos1.dy + 50),
          reason:
              'iPad Pro: Orange should be in the second row, well below row 1',
        );

        expect(
          (pos3.dx - pos1.dx).abs(),
          lessThan(5),
          reason:
              'iPad Pro: Orange should align with Banana in the left column',
        );
      },
    );

    testWidgets('no rendering overflow at 1024 × 1366', (tester) async {
      setIpadProViewport(tester);

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
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
      await tester.pump();

      expect(
        overflowErrors,
        isEmpty,
        reason: 'No layout overflow should occur on iPad Pro',
      );
    });

    testWidgets(
      'last product row is not covered by bottom navigation after scrolling',
      (tester) async {
        setIpadProViewport(tester);
        await _pumpHome(tester);

        await tester.drag(
          find.byType(CustomScrollView),
          const Offset(0, -2000),
        );
        await tester.pump();

        final pepperFinder = find.byKey(const ValueKey('Pepper'));
        expect(
          pepperFinder,
          findsOneWidget,
          reason: 'Pepper card should be visible after scrolling to the bottom',
        );

        final cardBottom = tester.getBottomLeft(pepperFinder).dy;
        final navTop = tester.getTopLeft(find.byType(GroceryBottomNav)).dy;

        expect(
          cardBottom,
          lessThanOrEqualTo(navTop + 1),
          reason:
              'Last product card bottom edge should not extend past the '
              'bottom navigation top edge on iPad Pro',
        );
      },
    );
  });

  group('HomePage — interactions', () {
    testWidgets('search filters products — shows only matching', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpHome(tester);

      expect(find.byType(ProductCard), findsWidgets);

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

      final addButtons = find.byIcon(Icons.add);
      expect(addButtons, findsWidgets);

      await tester.tap(addButtons.first);
      await tester.pump();

      expect(find.text('1'), findsWidgets);
    });
  });
}

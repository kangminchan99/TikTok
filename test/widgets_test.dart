import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

void main() {
  group('Form Button Tests', () {
    testWidgets("Enabled State", (WidgetTester tester) async {
      await tester.pumpWidget(
        Theme(
          data: ThemeData(primaryColor: Colors.red),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: false, onTap: () {}),
          ),
        ),
      );
      expect(find.text("Next"), findsOneWidget);
      expect(
        tester
            .firstWidget<AnimatedDefaultTextStyle>(
              find.byType(AnimatedDefaultTextStyle),
            )
            .style
            .color,
        Colors.white,
      );
      expect(
        (tester
                    .firstWidget<AnimatedContainer>(
                      find.byType(AnimatedContainer),
                    )
                    .decoration
                as BoxDecoration)
            .color,
        Colors.red,
      );
    });

    testWidgets("Disabled State", (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: FormButton(disabled: true, onTap: () {}),
        ),
      );
      expect(find.text("Next"), findsOneWidget);
      expect(
        tester
            .firstWidget<AnimatedDefaultTextStyle>(
              find.byType(AnimatedDefaultTextStyle),
            )
            .style
            .color,
        Colors.grey.shade400,
      );
    });

    testWidgets('Disabled State DarkMode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(platformBrightness: Brightness.dark),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: true, onTap: () {}),
          ),
        ),
      );
      expect(
        (tester
                    .firstWidget<AnimatedContainer>(
                      find.byType(AnimatedContainer),
                    )
                    .decoration
                as BoxDecoration)
            .color,
        Colors.grey.shade800,
      );
    });

    testWidgets('Disabled State lightMode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(platformBrightness: Brightness.light),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: true, onTap: () {}),
          ),
        ),
      );
      expect(
        (tester
                    .firstWidget<AnimatedContainer>(
                      find.byType(AnimatedContainer),
                    )
                    .decoration
                as BoxDecoration)
            .color,
        Colors.grey.shade300,
      );
    });
  });
}

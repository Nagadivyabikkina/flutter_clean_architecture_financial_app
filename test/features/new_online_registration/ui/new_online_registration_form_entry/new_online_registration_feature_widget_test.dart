import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_form_entry/new_online_registration_presenter.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_form_entry/new_online_registration_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('OnlineRegistration Widget loaded successfully!',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(buildTestableWidget(NewOnlineRegistrationRequestWidget()));
    await tester.pumpAndSettle();
    expect(find.byType(NewOnlineRegistrationRequestPresenter), findsOneWidget);
  });
}

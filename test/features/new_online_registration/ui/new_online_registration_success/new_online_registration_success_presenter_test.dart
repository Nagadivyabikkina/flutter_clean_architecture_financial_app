// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_success_screen/new_online_registration_success_presenter.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_success_screen/new_online_registration_success_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('UI TEST: should add presenter to widget tree', (tester) async {
    final testWidget = MaterialApp(
      home: NewOnlineRegistrationRequestSuccessWidget(),
    );
    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    expect(find.byType(NewOnlineRegistrationSuccessPresenter), findsOneWidget);
  });
}

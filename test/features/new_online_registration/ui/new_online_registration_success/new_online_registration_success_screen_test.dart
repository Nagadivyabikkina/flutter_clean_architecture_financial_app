// @dart = 2.9
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_enums.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_success/new_online_registration_success_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_success_screen/new_online_registration_success_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MaterialApp testWidgetSucceed;
  MaterialApp testWidgetFailed;
  NewOnlineRegistrationRequestSuccessViewModel
      onlineRegistrationViewModelSucceed;
  NewOnlineRegistrationRequestSuccessViewModel
      onlineRegistrationViewModelFailed;

  setUp(() async {
    onlineRegistrationViewModelSucceed =
        NewOnlineRegistrationRequestSuccessViewModel(
            cardHolderName: 'Tyler',
            accountNumberGenerated: '123456789',
            serviceResponseStatus:
                NewOnlineRegistrationServiceResponseStatus.succeed);

    onlineRegistrationViewModelFailed =
        NewOnlineRegistrationRequestSuccessViewModel(
            cardHolderName: 'Tyler',
            accountNumberGenerated: '',
            serviceResponseStatus:
                NewOnlineRegistrationServiceResponseStatus.failed);

    testWidgetSucceed = MaterialApp(
      home: NewOnlineRegistrationSuccessScreen(
          viewModel: onlineRegistrationViewModelSucceed),
    );

    testWidgetFailed = MaterialApp(
      home: NewOnlineRegistrationSuccessScreen(
          viewModel: onlineRegistrationViewModelFailed),
    );
  });

  tearDown(() {
    onlineRegistrationViewModelSucceed = null;
    onlineRegistrationViewModelFailed = null;
  });
  group('Create Online Account Success', () {
    testWidgets('should show the screen', (tester) async {
      await tester.pumpWidget(testWidgetSucceed);
      await tester.pump(Duration(milliseconds: 500));
      final widgetType = find.byType(NewOnlineRegistrationSuccessScreen);
      expect(widgetType, findsOneWidget);
    });

    testWidgets(
        'should show account holder name and account Number generated on Confirmation page with succeed response',
        (tester) async {
      await tester.pumpWidget(testWidgetSucceed);
      await tester.pump(Duration(milliseconds: 500));
      expect(find.text('REGISTRATION CONFIRMATION'), findsOneWidget);
      expect(find.text('Account created for user'), findsOneWidget);
      expect(find.text('${onlineRegistrationViewModelSucceed.cardHolderName}'),
          findsOneWidget);
      expect(find.text('Account Number'), findsOneWidget);
      expect(
          find.text(
              '${onlineRegistrationViewModelSucceed.accountNumberGenerated}'),
          findsOneWidget);
      expect(
          find.text(
              'Login with email ID and password you used while registration to access your account'),
          findsOneWidget);
    });
    testWidgets(
        'should show account info on Confirmation page with failed response',
        (tester) async {
      await tester.pumpWidget(testWidgetFailed);
      await tester.pump(Duration(milliseconds: 500));
      expect(find.text('REGISTRATION CONFIRMATION'), findsOneWidget);
      expect(find.text('Account creation failed for user'), findsOneWidget);
      expect(find.text('${onlineRegistrationViewModelSucceed.cardHolderName}'),
          findsOneWidget);
      // expect(find.text('Please try again later!'), findsOneWidget);
    });
  });
}

// @dart=2.9
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_bloc.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_form_entry/new_online_registration_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../bloc/new_online_registration_form_entry/new_online_registration_bloc_mock.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MaterialApp testWidget;
  setUp(() {
    testWidget = MaterialApp(
      home: BlocProvider<NewOnlineRegistrationBloc>(
        create: (_) => NewOnlineRegistrationBlocMock(),
        child: NewOnlineRegistrationRequestPresenter(),
      ),
    );
  });
  tearDown(() {
    testWidget = null;
  });
  group('Create New account online', () {
    testWidgets('should show the presenter', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pump(Duration(milliseconds: 500));
      final widgetType = find.byType(NewOnlineRegistrationRequestPresenter);
      expect(widgetType, findsOneWidget);
    });
  });
}

// @dart = 2.9
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/model/login_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/ui/login_presenter.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/ui/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../new_online_registration/ui/new_online_registration_form_entry/new_online_registration_actions_test.dart';

void main() {
  LoginViewModel loginViewModel;

  setUp(() {
    loginViewModel = LoginViewModel(
      username: 'Tyler',
      password: 'TestPassword@123',
      dataStatus: DataStatus.valid,
      serviceStatus: ServiceStatus.success,
    );
  });

  tearDown(() {
    loginViewModel = null;
  });
  group('Login screen', () {
    testWidgets('Login screen loads static contents', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(viewModel: loginViewModel),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Register Account online'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(
          find.text('Securely access financial information'), findsOneWidget);
      expect(find.byKey(const Key('usename_key')), findsOneWidget);
      expect(find.byKey(const Key('password_key')), findsOneWidget);
    });

    testWidgets(
        'navigate to newOnlineRegistrationScreen on call of tap callback',
        (WidgetTester tester) async {
      Widget buildWidget({
        String initialRoute = '/',
        CFRouteGenerator generator,
        void Function(CFRoutePage) onUpdate,
      }) {
        return CFRouterScope(
          initialRoute: initialRoute,
          routeGenerator: generator,
          builder: (context) {
            return MaterialApp.router(
              routerDelegate: CFRouterDelegate(context, onUpdate: onUpdate),
              routeInformationParser: CFRouteInformationParser(),
            );
          },
        );
      }

      await tester.pumpWidget(buildWidget(generator: (name) {
        switch (name) {
          case '/':
            return OnTapButton(
              id: 'newOnlineRegistrationScreen',
              onTap: (context) =>
                  LoginPresenter().navigateToAccountRegistrationScreen(context),
            );
          default:
            return Container();
        }
      }));
      expect(navElement.router.previousPage?.name, isNull);
      expect(navElement.router.currentPage.name, '/');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(
          navElement.router.currentPage.name, '/newOnlineRegistrationScreen');
    });
  });
}

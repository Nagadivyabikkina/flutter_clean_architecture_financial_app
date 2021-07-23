import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/ui/login_feature_widget.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_form_entry/new_online_registration_widget.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_success_screen/new_online_registration_success_widget.dart';

abstract class FinancialAppRouter {
  static const String initialRoute = '/';
  static const String newOnlineRegistrationScreen =
      '/newOnlineRegistrationScreen';
  static const String NewSuccessScreen = '/NewSuccessScreen';

  static Widget generate(String name) {
    switch (name) {
      case initialRoute:
        return LoginFeatureWidget();

      case newOnlineRegistrationScreen:
        return NewOnlineRegistrationRequestWidget();

      case NewSuccessScreen:
        return NewOnlineRegistrationRequestSuccessWidget();
      default:
        return const PageNotFound();
    }
  }
}

class PageNotFound extends StatelessWidget {
  const PageNotFound();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('404, Page Not Found!')));
  }
}

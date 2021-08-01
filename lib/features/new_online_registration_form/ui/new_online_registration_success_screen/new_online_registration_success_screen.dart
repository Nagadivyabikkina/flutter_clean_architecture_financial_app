import 'package:auto_size_text/auto_size_text.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_enums.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_success/new_online_registration_success_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_success_screen/new_online_registration_success_presenter.dart';

class NewOnlineRegistrationSuccessScreen extends Screen {
  final NewOnlineRegistrationRequestSuccessViewModel viewModel;
  final NewOnlineRegistrationConfirmPresenterActions presenterAction;
  NewOnlineRegistrationSuccessScreen({
    required this.viewModel,
    required this.presenterAction,
  });

  @override
  Widget build(BuildContext context) {
    print('success screen');
    print(viewModel.serviceResponseStatus);
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.blue,
          title: AutoSizeText(
            'REGISTRATION CONFIRMATION',
            maxFontSize: 16,
            minFontSize: 10,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                presenterAction.popNavigationListener(context);
              },
            )
          ],
        ),
        backgroundColor: Colors.grey[300],
        body: viewModel.serviceResponseStatus ==
                NewOnlineRegistrationServiceResponseStatus.succeed
            ? SuccessWidget(viewModel: viewModel)
            : FailedWidget(viewModel: viewModel));
  }
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final NewOnlineRegistrationRequestSuccessViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Account created for user',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    viewModel.cardHolderName!,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 40,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Account Number',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    viewModel.accountNumberGenerated!,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 40,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 5.0)
                ]),
            child: Center(
              child: Text(
                'Login with email ID and password you used while registration to access your account',
                style: TextStyle(color: Colors.black54, fontSize: 17),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      )),
    );
  }
}

class FailedWidget extends StatelessWidget {
  const FailedWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final NewOnlineRegistrationRequestSuccessViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    print('Failed Widget');
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Account creation failed for user',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    viewModel.cardHolderName!,
                    style: TextStyle(color: Colors.red, fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                      child: Column(children: [
                    Image.asset(
                      'assets/images/server_error.png',
                      height: 300,
                      width: 400,
                    )
                  ])),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      )),
    );
  }
}

import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/model/login_view_model.dart';

class LoginScreen extends Screen {
  final LoginViewModel? viewModel;
  final Function? onChangeUsermame;
  final Function? onChangePassword;
  final Function? onTapSubmit;
  final Function? onTapAccountOnline;

  LoginScreen({
    this.onChangeUsermame,
    this.onChangePassword,
    this.onTapSubmit,
    this.onTapAccountOnline,
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.withOpacity(0.7),
        title: Text(
          'Login Online',
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Form(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: media.width * .1),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                child: Text(
                  'Securely access financial information',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(height: media.width * .03),
            _textFormField(Key('usename_key'), 'Username', onChangeUsermame,
                TextInputType.emailAddress),
            SizedBox(height: media.width * .01),
            _textFormField(Key('password_key'), 'Password', onChangePassword,
                TextInputType.visiblePassword),
            SizedBox(height: media.width * .02),
            ElevatedButton(
              key: Key('login_button_key'),
              onPressed: onTapSubmit as void Function()?,
              child: Text('Login', style: TextStyle(color: Colors.white)),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    child: Text(
                      'Register Account online',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: onTapAccountOnline as void Function()?,
                  )
                ])),
          ],
        ),
      ),
    );
  }

  Widget _textFormField(Key key, String hintText, Function? onChangeTextField,
      TextInputType textInputType) {
    return TextFormField(
      key: key,
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        filled: true,
        hintText: hintText,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 2.0)),
      ),
      onChanged: (value) {
        onChangeTextField!(value);
      },
    );
  }
}

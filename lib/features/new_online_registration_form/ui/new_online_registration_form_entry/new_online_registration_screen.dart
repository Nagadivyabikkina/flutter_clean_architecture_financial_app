import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_form_entry/new_online_registration_actions.dart';
import 'package:flutter_clean_architecture_financial_app/utils/card_expiry_date_formatter.dart';
import 'package:flutter_clean_architecture_financial_app/utils/card_number_formatter.dart';

class NewOnlineRegistrationScreen extends Screen {
  final NewOnlineRegistrationViewModel viewModel;
  final NewOnlineRegistrationRequestActions actions;

  NewOnlineRegistrationScreen({
    required this.viewModel,
    required this.actions,
  });

  final _form = GlobalKey<FormState>();

  final _nameValueTextEditingController = TextEditingController();
  final _cardNumberValueTextEditingController = TextEditingController();
  final _userEmailAddressController = TextEditingController();
  final _userPasswordValueTextEditingController = TextEditingController();
  final _validThruController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameValueTextEditingController.text = viewModel.cardHolderName!;
    _cardNumberValueTextEditingController.text = viewModel.cardNumber!;
    _validThruController.text = viewModel.validThru!;
    _userEmailAddressController.text = viewModel.email!;
    _userPasswordValueTextEditingController.text = viewModel.userPassword!;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            key: const Key('back-button'),
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.withOpacity(0.7),
          title: Text(
            'Create New Account Online',
          ),
        ),
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 5.0),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ElevatedButton(
                            key: Key("scanButton"),
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 16),
                                primary: Colors.blue.withOpacity(0.7)),
                            onPressed: () async {
                              actions.onCardScanned();
                              _cardNumberValueTextEditingController.text =
                                  viewModel.cardNumber!;
                              _validThruController.text = viewModel.validThru!;
                            },
                            child: Text('Scan your card or enter manually'),
                          )),
                      customTextField(
                        textFieldKey: Key('cardHolderName-TxtField'),
                        controller: _nameValueTextEditingController,
                        inputStatus: viewModel.cardHolderNameStatus,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                        labelText: 'Card Holder Name',
                        onSaved: (val) {
                          actions.onUpdateNameParam(val!);
                        },
                      ),
                      customTextField(
                        textFieldKey: Key('cardHolderNumber-TxtField'),
                        controller: _cardNumberValueTextEditingController,
                        inputStatus: viewModel.cardNumberStatus,
                        labelText: 'Credit Card Number',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(19),
                          CardNumberInputFormatter()
                        ],
                        hintText: 'xxxx xxxx xxxx xxxx xxx',
                        onSaved: (val) {
                          actions.onUpdateNumberParam(val!);
                        },
                      ),
                      customTextField(
                        textFieldKey: Key('validThru-TxtField'),
                        controller: _validThruController,
                        inputStatus: viewModel.cardExpiryDateStatus,
                        labelText: 'Valid Thru',
                        hintText: "MM/YY",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                          CardMonthInputFormatter()
                        ],
                        onSaved: (val) {
                          actions.onUpdateCardExpiryDate(val!);
                        },
                      ),
                      customTextField(
                        textFieldKey: Key('userEmailAddress-TxtField'),
                        controller: _userEmailAddressController,
                        inputStatus: viewModel.userEmailStatus,
                        labelText: 'Email for login',
                        onSaved: (val) {
                          actions.onUpdateEmailAddress(val!);
                        },
                      ),
                      customTextField(
                        textFieldKey: Key('userPassword-TxtField'),
                        controller: _userPasswordValueTextEditingController,
                        inputStatus: viewModel.userPasswordStatus,
                        labelText: 'Password',
                        onSaved: (val) {
                          actions.onUpdatePassword(val!);
                        },
                        obscureText: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              key: Key("createButton"),
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 18),
                                  primary: Colors.blue.withOpacity(0.7)),
                              onPressed: () async {
                                _form.currentState!.save();
                                actions.pressCreateButton(
                                    context,
                                    _nameValueTextEditingController.text,
                                    _cardNumberValueTextEditingController.text,
                                    _validThruController.text,
                                    _userEmailAddressController.text,
                                    _userPasswordValueTextEditingController
                                        .text);
                              },
                              child: Text('Create Account',
                                  style: TextStyle(fontSize: 20.0))),
                        ],
                      ),
                    ],
                  ))))
        ]))));
  }

  Widget customTextField({
    TextEditingController? controller,
    String? labelText,
    String hintText = '',
    final FormFieldSetter<String>? onSaved,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    final String? inputStatus,
    List<TextInputFormatter>? inputFormatters,
    Key? textFieldKey,
  }) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          key: textFieldKey,
          controller: controller,
          inputFormatters: inputFormatters ?? <TextInputFormatter>[],
          //viewModel.paymentValueTextEditingController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixStyle: TextStyle(color: Colors.orangeAccent),
              labelText: labelText,
              hintText: hintText),

          textInputAction: TextInputAction.done,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onSaved: onSaved,
        ),
      ),
      checkInputStatus(inputStatus),
    ]);
  }

  Widget checkInputStatus(
    String? inputStatus,
  ) {
    if (inputStatus!.isNotEmpty) {
      return Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10),
          child: Row(children: [
            Expanded(
                child: Text(
              inputStatus,
              style: TextStyle(color: Colors.red, fontSize: 12),
            )),
          ]));
    } else {
      return Container();
    }
  }
}

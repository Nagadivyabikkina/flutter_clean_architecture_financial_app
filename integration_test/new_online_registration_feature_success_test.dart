// @dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'integration_test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      "User filling new online registration form end with success response",
      (WidgetTester tester) async {
    await startTest(tester);
    await didWidgetAppear('signInText');
    await tapText('Register Account online');
    await didTextAppear('Create New Account Online');

    //Register new account online account form
    await didWidgetAppear('cardHolderName-TxtField');
    await didWidgetAppear('cardHolderNumber-TxtField');
    await didWidgetAppear('userEmailAddress-TxtField');
    await didWidgetAppear('userPassword-TxtField');
    await didWidgetAppear('createButton');
    await tapWidget('createButton');
    await didTextAppear('Invalid Information!');
    await didTextAppear('Please fill in all fields properly');
    await didTextAppear('OK');
    await tapText('OK');
    await tapWidget('cardHolderName-TxtField');
    await enterText('cardHolderName-TxtField', 'TestUser');
    await tapWidget('createButton');
    await didTextNeverAppear('Please provide valid name.');
    await tapText('OK');
    await tapWidget('cardHolderName-TxtField');
    await enterText('cardHolderName-TxtField', '1234');
    await tapWidget('createButton');
    await didTextAppear('Please provide valid name.');
    await tapText('OK');
    await tapWidget('cardHolderNumber-TxtField');
    await enterText('cardHolderNumber-TxtField', '1234');
    await tapWidget('createButton');
    await didTextAppear('Please provide valid credit card Number.');
    await tapText('OK');
    await tapWidget('cardHolderNumber-TxtField');
    await enterText('cardHolderNumber-TxtField', '345246807615128');
    await tapWidget('createButton');
    await didTextNeverAppear('Please provide valid credit card Number.');
    await tapText('OK');
    await tapWidget('userPassword-TxtField');
    await enterText('userPassword-TxtField', 'test');
    await tapWidget('createButton');
    await didTextAppear(
        'Password should be minimum eight characters, at least one uppercase letter, one lowercase letter and one number.');
    await tapText('OK');
    await tapWidget('userPassword-TxtField');
    await enterText('userPassword-TxtField', 'Test123test');
    await tapWidget('createButton');
    await didTextNeverAppear(
        'Password should be minimum eight characters, at least one uppercase letter, one lowercase letter and one number.');
    await tapText('OK');
    await tapWidget('userEmailAddress-TxtField');
    await enterText('userEmailAddress-TxtField', 'test');
    await tapWidget('createButton');
    await didTextAppear('Please, provide a valid email.');
    await tapText('OK');
    await tapWidget('userEmailAddress-TxtField');
    await enterText('userEmailAddress-TxtField', 'Test@test.com');
    await tapWidget('createButton');
    await tapText('OK');
    await didTextNeverAppear('Please, provide a valid email.');
    await tapWidget('validThru-TxtField');
    await enterText('validThru-TxtField', '08/20');
    await tapWidget('createButton');
    await didTextAppear('Card has expired');
    await tapText('OK');
    await tapWidget('validThru-TxtField');
    await enterText('validThru-TxtField', '08/50');
    await tapWidget('createButton');
    await tapText('OK');
    await tapWidget('cardHolderName-TxtField');
    await enterText('cardHolderName-TxtField', 'TestUser');
    await tapWidget('createButton');
    await didTextAppear('REGISTRATION CONFIRMATION');
    await didTextAppear('Account created for user');
    await didTextAppear('TestUser');
    await didTextAppear('Account Number');
    await didTextAppear('123456789');
    await didTextAppear(
        'Login with email ID and password you used while registration to access your account');
  });
}

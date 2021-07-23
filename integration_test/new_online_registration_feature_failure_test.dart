// @dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'integration_test_helpers.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//stop Mockoon instance
  testWidgets(
      "User filling new online registration form end with failure response",
      (WidgetTester tester) async {
    await startTest(tester);
    await didWidgetAppear('signInText');
    await tapText('Register Account online');
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
    await tapWidget('cardHolderNumber-TxtField');
    await enterText('cardHolderNumber-TxtField', '345246807615128');
    await tapWidget('userPassword-TxtField');
    await enterText('userPassword-TxtField', 'Test123test');
    await tapWidget('userEmailAddress-TxtField');
    await enterText('userEmailAddress-TxtField', 'Test@test.com');
    await tapWidget('validThru-TxtField');
    await enterText('validThru-TxtField', '08/50');
    await tapWidget('createButton');
    await didTextAppear('REGISTRATION CONFIRMATION');
    await didTextAppear('Account creation failed for user');
    await didTextAppear('TestUser');
  });
}

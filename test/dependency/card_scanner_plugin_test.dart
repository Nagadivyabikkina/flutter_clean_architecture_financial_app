// ignore: import_of_legacy_library_into_null_safe
import 'package:card_scanner/card_scanner.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_financial_app/dependency/card_scanner_plugin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('nateshmbhat/card_scanner');

  TestWidgetsFlutterBinding.ensureInitialized();
  Map<String, String> sampleResult = {
    'cardNumber': '345246807615128',
    'cardIssuer': '',
    'cardHolderName': '',
    'expiryDate': '08/50',
  };

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return sampleResult;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('Testing scanning wrapper with success Data', () async {
    CardDetails cardDetails = await CardScannerPlugin().scanCard();
    expect(cardDetails.cardNumber, '345246807615128');
    expect(cardDetails.expiryDate, '08/50');
  });

  test('Testing scanning wrapper with some errors', () async {
    Map<String, String> cardNumberScanFailedForCardNumber = {
      'cardNumber': '',
      'cardIssuer': '',
      'cardHolderName': '',
      'expiryDate': '08/50',
    };
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return cardNumberScanFailedForCardNumber;
    });
    CardDetails cardDetailsEmptyCardNumber =
        await CardScannerPlugin().scanCard();
    expect(cardDetailsEmptyCardNumber.cardNumber, '');
    expect(cardDetailsEmptyCardNumber.expiryDate, '08/50');
    Map<String, String> cardExpiryDateFailed = {
      'cardNumber': '345246807615128',
      'cardIssuer': '',
      'cardHolderName': '',
      'expiryDate': '',
    };
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return cardExpiryDateFailed;
    });
    CardDetails cardDetailsWithEmptyExpiry =
        await CardScannerPlugin().scanCard();
    expect(cardDetailsWithEmptyExpiry.cardNumber, '345246807615128');
    expect(cardDetailsWithEmptyExpiry.expiryDate, '');
    Map<String, String> cardScanningFailed = {
      'cardNumber': '',
      'cardIssuer': '',
      'cardHolderName': '',
      'expiryDate': '',
    };
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return cardScanningFailed;
    });
    CardDetails cardScanningFailure = await CardScannerPlugin().scanCard();
    expect(cardScanningFailure.cardNumber, '');
    expect(cardScanningFailure.expiryDate, '');
  });
}

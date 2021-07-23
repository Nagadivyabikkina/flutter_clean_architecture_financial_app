// @dart=2.9
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_event.dart';
import 'package:test/test.dart';

void main() {
  group('Online Registration Event', () {
    test(
        'should props match and stringify be true on UpdateCardHolderNameEvent',
        () {
      final event = UpdateCardHolderNameRequestEvent('Tyler');
      expect(event.props, ['Tyler']);
      expect(event.stringify, true);
    });
    test('should props match and stringify be true on UpdateCardNumberEvent',
        () {
      final event = UpdateCardHolderNumberRequestEvent('379260567141018');
      expect(event.props, ['379260567141018']);
      expect(event.stringify, true);
    });

    test('should props match and stringify be true on UpdateUserEmailEvent',
        () {
      final event = UpdateEmailAddressRequestEvent('test@test.com');
      expect(event.props, ['test@test.com']);
      expect(event.stringify, true);
    });

    test('should props match and stringify be true on UpdateUserPasswordEvent',
        () {
      final event = UpdateUserPasswordRequestEvent('Test123test');
      expect(event.props, ['Test123test']);
      expect(event.stringify, true);
    });

    test(
        'should props match and stringify be true on UpdateCardExpiryRequestEvent',
        () {
      final event = UpdateCardExpiryRequestEvent('08/50');
      expect(event.props, ['08/50']);
      expect(event.stringify, true);
    });

    test('should props match and stringify be true on CardScannerEvent', () {
      final event = CardScannerEvent();
      expect(event.props, []);
      expect(event.stringify, true);
    });
  });
}

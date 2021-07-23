// @dart=2.9
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnlineRegistration Entity', () {
    final tEntity = NewOnlineRegistrationEntity(
        errors: [],
        cardHolderName: 'Tyler',
        cardNumber: '378282246310005',
        validThru: '08/50',
        email: 'test@test.com',
        userPassword: 'TestPassword@123',
        accountNumberGenerated: '123456789');

    test('should properties match', () {
      expect(tEntity.cardHolderName, 'Tyler');
      expect(tEntity.cardNumber, '378282246310005');
      expect(tEntity.validThru, '08/50');
      expect(tEntity.email, 'test@test.com');
      expect(tEntity.userPassword, 'TestPassword@123');
      expect(tEntity.accountNumberGenerated, '123456789');
    });

    test('should props match', () async {
      expect(tEntity.props, [
        tEntity.errors,
        tEntity.cardHolderName,
        tEntity.cardNumber,
        tEntity.validThru,
        tEntity.email,
        tEntity.userPassword,
        tEntity.accountNumberGenerated,
      ]);
    });

    test('should merge func return new Entity with updated data', () async {
      NewOnlineRegistrationEntity newEntity =
          tEntity.merge(cardHolderName: 'Tyler');
      expect(newEntity.cardHolderName, 'Tyler');
      newEntity = tEntity.merge(cardNumber: '379260567141018');
      expect(newEntity.cardNumber, '379260567141018');
      newEntity = tEntity.merge(validThru: '08/50');
      expect(newEntity.validThru, '08/50');
      newEntity = tEntity.merge(email: 'test@test.com');
      expect(newEntity.email, 'test@test.com');
      newEntity = tEntity.merge(userPassword: 'test@Test123');
      expect(newEntity.userPassword, 'test@Test123');
    });
  });
}

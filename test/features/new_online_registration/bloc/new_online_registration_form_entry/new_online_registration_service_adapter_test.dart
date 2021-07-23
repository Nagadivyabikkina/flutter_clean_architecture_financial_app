// @dart=2.9
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/api/new_online_registration_service_request_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/api/new_online_registration_service_response_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_service_adapter.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_entity.dart';
import 'package:test/test.dart';

void main() {
  group('Online Registration service adapter test', () {
    final tEntity = NewOnlineRegistrationEntity(
        errors: [],
        cardHolderName: 'Tyler',
        cardNumber: '378282246310005',
        validThru: '08/50',
        email: 'test@test.com',
        userPassword: 'TestPassword@123',
        accountNumberGenerated: '123456789');

    final tRequestModel = NewOnlineRegistrationServiceRequestModel(
      cardHolderName: 'Tyler',
      cardNumber: '378282246310005',
      validThru: '08/50',
      email: 'test@test.com',
      userPassword: 'TestPassword@123',
    );

    final tJsonResponse = {"accountNumberGenerated": "123456789"};

    test('should received a json response and return account number generated',
        () async {
      final entity = NewOnlineRegistrationRequestServiceAdapter().createEntity(
          NewOnlineRegistrationEntity(),
          NewOnlineRegistrationServiceResponseModel.fromJson(tJsonResponse));
      expect(entity.accountNumberGenerated, tEntity.accountNumberGenerated);
    });
    test(
        'should receive a NewOnlineRegistrationEntity and return NewOnlineRegistrationServiceRequestModel',
        () async {
      final requestModel =
          NewOnlineRegistrationRequestServiceAdapter().createRequest(tEntity);
      expect(requestModel.cardHolderName, tRequestModel.cardHolderName);
      expect(requestModel.cardNumber, tRequestModel.cardNumber);
      expect(requestModel.validThru, tRequestModel.validThru);
      expect(requestModel.email, tRequestModel.email);
      expect(requestModel.userPassword, tRequestModel.userPassword);
    });
  });
}

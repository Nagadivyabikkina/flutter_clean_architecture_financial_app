// @dart=2.9
import 'package:card_scanner/card_scanner.dart';
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter_clean_architecture_financial_app/dependency/card_scanner_plugin.dart';
import 'package:flutter_clean_architecture_financial_app/dependency/permission_handler_plugin.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_usecase.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_entity.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_enums.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPermissionHandlerPlugin extends Mock
    implements PermissionHandlerPlugin {
  @override
  Future<bool> isGrantedAccessCamera() async {
    return true;
  }
}

class MockCardScannerPlugin extends Mock implements CardScannerPlugin {
  @override
  Future<dynamic> scanCard() async {
    Map<String, String> map = {
      'cardNumber': '345246807615128',
      'cardIssuer': '',
      'cardHolderName': '',
      'expiryDate': '08/50',
    };
    return CardDetails.fromMap(map);
  }
}

void main() {
  NewOnlineRegistrationRequestUseCase useCase;

  NewOnlineRegistrationViewModel onlineRegistrationViewModel;

  setUp(() {
    useCase = NewOnlineRegistrationRequestUseCase((viewModel) {
      onlineRegistrationViewModel = viewModel;
      return true;
    }, MockPermissionHandlerPlugin(), MockCardScannerPlugin());
  });

  group('Online Registration UseCase', () {
    test('should value receive from pipe be the same as source value',
        () async {
      useCase.create();
      expect(onlineRegistrationViewModel, isNotNull);
    });
    test(
        'should updates for CardHolderName, number, ssn, email, password method receive data and update view Model',
        () async {
      useCase.create();
      useCase.updateUserName('Tyler');
      expect(onlineRegistrationViewModel.cardHolderName, 'Tyler');
      useCase.updateCardNumber('378282246310005');
      expect(onlineRegistrationViewModel.cardNumber, '378282246310005');
      useCase.updateCardExpireDate('08/50');
      expect(onlineRegistrationViewModel.validThru, '08/50');
      useCase.updateEmailAddress('test@test.com');
      expect(onlineRegistrationViewModel.email, 'test@test.com');
      useCase.updatePassword('TestPassword@123');
      expect(onlineRegistrationViewModel.userPassword, 'TestPassword@123');
      expect(onlineRegistrationViewModel.cardHolderNameStatus, '');
      expect(onlineRegistrationViewModel.cardNumberStatus, '');
      expect(onlineRegistrationViewModel.userEmailStatus, '');
      expect(onlineRegistrationViewModel.userPasswordStatus, '');
    });
    test(
        'should updateUserName method return a status and invalid UserFormInputStatus, if user insert not valid Name',
        () async {
      useCase.create();
      useCase.updateUserName('12345');
      expect(onlineRegistrationViewModel.cardHolderNameStatus,
          'Please provide valid name.');
    });
    test(
        'should updateCardNumber method return a status and invalid UserFormInputStatus, if user insert not valid Card Number',
        () async {
      useCase.create();
      useCase.updateCardNumber('123454');
      expect(onlineRegistrationViewModel.cardNumberStatus,
          'Please provide valid credit card Number.');
    });

    test(
        'should updateCardNumber method return a status and invalid updateCardExpireDateStatus, if user insert not valid Card Number',
        () async {
      useCase.create();
      useCase.updateCardExpireDate('08/10');
      expect(
          onlineRegistrationViewModel.cardExpiryDateStatus, 'Card has expired');
      useCase.updateCardExpireDate('13/21');
      expect(onlineRegistrationViewModel.cardExpiryDateStatus,
          'Expiry month is invalid');
      useCase.updateCardExpireDate('08/50');
      expect(onlineRegistrationViewModel.cardExpiryDateStatus, '');
      useCase.updateCardExpireDate('01');
      expect(onlineRegistrationViewModel.cardExpiryDateStatus,
          'Expiry year is invalid');
    });

    test(
        'should updateEmail method return a status and invalid UserFormInputStatus, if user inserted non valid email',
        () async {
      useCase.create();
      useCase.updateEmailAddress('test');
      expect(onlineRegistrationViewModel.userEmailStatus,
          'Please, provide a valid email.');
    });

    test(
        'should update Password method return a status and invalid UserFormInputStatus, if user inserted non valid Password',
        () async {
      useCase.create();
      useCase.updatePassword('test');
      expect(onlineRegistrationViewModel.userPasswordStatus,
          'Password should be minimum eight characters, at least one uppercase letter, one lowercase letter and one number.');
    });

    test(
        'should getCardInformation method receive Card details and update view Model',
        () async {
      useCase.create();
      await useCase.getCardInformation();

      expect(onlineRegistrationViewModel.cardNumber, '345246807615128');
      expect(onlineRegistrationViewModel.validThru, '08/50');
    });

    test('should submit form with valid data', () async {
      final tEntity = NewOnlineRegistrationEntity(
          errors: [],
          cardHolderName: 'Tyler',
          validThru: '08/50',
          cardNumber: '378282246310005',
          email: 'test@test.com',
          userPassword: 'TestPassword@123');
      useCase.create();
      onlineRegistrationViewModel =
          useCase.buildViewModel(newOnlineRegistrationEntity: tEntity);
      expect(onlineRegistrationViewModel.serviceResponseStatus,
          NewOnlineRegistrationServiceResponseStatus.succeed);
    });

    test(
        'should service response be failed when built view model with entity that has error',
        () async {
      final tEntity = NewOnlineRegistrationEntity(
          errors: [EntityFailure()],
          cardHolderName: '',
          cardNumber: '378282246310005',
          validThru: '',
          email: 'test@test.com',
          userPassword: 'TestPassword@123');
      onlineRegistrationViewModel =
          useCase.buildViewModel(newOnlineRegistrationEntity: tEntity);

      expect(onlineRegistrationViewModel.serviceResponseStatus,
          NewOnlineRegistrationServiceResponseStatus.failed);
    });
  });
}

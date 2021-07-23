// @dart=2.9
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_bloc.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_event.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_usecase.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_success/new_online_registration_success_usecase.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_enums.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_success/new_online_registration_success_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockNewOnlineRegistrationRequestUseCase extends Mock
    implements NewOnlineRegistrationRequestUseCase {}

class MockNewOnlineRegistrationRequestSuccessUseCase extends Mock
    implements NewOnlineRegistrationRequestSuccessUseCase {}

void main() {
  NewOnlineRegistrationBloc bloc;
  MockNewOnlineRegistrationRequestUseCase
      mockNewOnlineRegistrationRequestUseCase;

  MockNewOnlineRegistrationRequestSuccessUseCase
      mockNewOnlineRegistrationRequestSuccessUseCase;

  setUp(() {
    mockNewOnlineRegistrationRequestUseCase =
        MockNewOnlineRegistrationRequestUseCase();

    mockNewOnlineRegistrationRequestSuccessUseCase =
        MockNewOnlineRegistrationRequestSuccessUseCase();

    bloc = NewOnlineRegistrationBloc(
      newOnlineRegistrationRequestSuccessUseCase:
          mockNewOnlineRegistrationRequestSuccessUseCase,
      newOnlineRegistrationRequestUseCase:
          mockNewOnlineRegistrationRequestUseCase,
    );
  });

  tearDown(() {
    bloc.dispose();
    expect(bloc.newOnlineRegistrationViewModelPipe.receive, emitsDone);
    expect(bloc.newOnlineRegistrationEventsPipe.receive, emitsDone);
    expect(bloc.newOnlineRegistrationSuccessViewModelPipe.receive, emitsDone);
  });
  group('OnlineRegistration Bloc', () {
    String cardHolderName = 'Tyler';
    String cardNumber = '378282246310005';
    String email = 'test@test.com';
    String userPassword = 'TestPassword@123';
    String expiryDate = '08/50';
    NewOnlineRegistrationViewModel onlineRegistrationViewModelSucceed =
        NewOnlineRegistrationViewModel(
            cardHolderName: 'Tyler',
            cardNumber: '378282246310005',
            validThru: '08/50',
            email: 'test@test.com',
            userPassword: 'TestPassword@123',
            cardHolderNameStatus: '',
            cardNumberStatus: '',
            cardExpiryDateStatus: '',
            userEmailStatus: '',
            userPasswordStatus: '',
            serviceResponseStatus:
                NewOnlineRegistrationServiceResponseStatus.succeed);

    NewOnlineRegistrationRequestSuccessViewModel
        newOnlineRegistrationRequestSuccessViewModel =
        NewOnlineRegistrationRequestSuccessViewModel(
            cardHolderName: 'Tyler',
            accountNumberGenerated: '123456',
            serviceResponseStatus:
                NewOnlineRegistrationServiceResponseStatus.succeed);

    test(
        'should newOnlineRegistrationViewModelPipe gets view model with real usecase',
        () {
      bloc.newOnlineRegistrationViewModelPipe
          .send(onlineRegistrationViewModelSucceed);
      bloc.newOnlineRegistrationViewModelPipe.receive.listen((model) {
        verify(mockNewOnlineRegistrationRequestUseCase.create()).called(1);
      });
    });
    test(
        'should newOnlineRegistrationSuccessViewModelPipe gets view model with real usecase',
        () {
      bloc.newOnlineRegistrationSuccessViewModelPipe
          .send(newOnlineRegistrationRequestSuccessViewModel);
      bloc.newOnlineRegistrationSuccessViewModelPipe.receive.listen((model) {
        verify(mockNewOnlineRegistrationRequestSuccessUseCase.create())
            .called(1);
      });
    });

    test('should newOnlineRegistrationEventsPipeHandler calls correct method',
        () {
      bloc.newOnlineRegistrationEventsPipe.receive.listen((event) {
        if (event is UpdateCardExpiryRequestEvent) {
          verify(mockNewOnlineRegistrationRequestUseCase
                  .updateCardExpireDate(expiryDate))
              .called((1));
        }
        if (event is CardScannerEvent) {
          verify(mockNewOnlineRegistrationRequestUseCase.getCardInformation())
              .called((1));
        }

        if (event is UpdateCardHolderNameRequestEvent) {
          verify(mockNewOnlineRegistrationRequestUseCase
                  .updateUserName(cardHolderName))
              .called(1);
        }
        if (event is UpdateCardHolderNumberRequestEvent) {
          verify(mockNewOnlineRegistrationRequestUseCase
                  .updateCardNumber(cardNumber))
              .called((1));
        }
        if (event is UpdateEmailAddressRequestEvent) {
          verify(mockNewOnlineRegistrationRequestUseCase
                  .updateEmailAddress(email))
              .called(1);
        }
        if (event is UpdateUserPasswordRequestEvent) {
          verify(mockNewOnlineRegistrationRequestUseCase
                  .updatePassword(userPassword))
              .called((1));
        }
      });

      bloc.newOnlineRegistrationEventsPipeHandler(
          UpdateCardHolderNameRequestEvent(cardHolderName));
      bloc.newOnlineRegistrationEventsPipeHandler(
          UpdateCardHolderNumberRequestEvent(cardNumber));
      bloc.newOnlineRegistrationEventsPipeHandler(
          UpdateEmailAddressRequestEvent(email));
      bloc.newOnlineRegistrationEventsPipeHandler(
          UpdateUserPasswordRequestEvent(userPassword));
    });

    test('should update the fields and fieldStatus by respective Event func',
        () {
      bloc.newOnlineRegistrationViewModelPipe.receive.listen((event) {
        expect(event.cardHolderName, cardHolderName);
        expect(event.cardNumber, cardNumber);
        expect(event.email, email);
        expect(event.userPassword, userPassword);
        expect(event.cardHolderNameStatus, '');
        expect(event.cardNumberStatus, '');
        expect(event.userEmailStatus, '');
        expect(event.userEmailStatus, '');
      });
      bloc.newOnlineRegistrationEventsPipe
          .send(UpdateCardHolderNameRequestEvent(cardHolderName));
      bloc.newOnlineRegistrationEventsPipe
          .send(UpdateCardHolderNumberRequestEvent(cardNumber));
      bloc.newOnlineRegistrationEventsPipe
          .send(UpdateEmailAddressRequestEvent(email));
      bloc.newOnlineRegistrationEventsPipe
          .send(UpdateUserPasswordRequestEvent(userPassword));
    });

    test('NewOnlineRegistrationBloc newOnlineRegistrationEventsPipeHandler',
        () async {
      var event;
      NewOnlineRegistrationBloc bloc = NewOnlineRegistrationBloc(
          newOnlineRegistrationRequestUseCase:
              mockNewOnlineRegistrationRequestUseCase,
          newOnlineRegistrationRequestSuccessUseCase:
              mockNewOnlineRegistrationRequestSuccessUseCase);

      event = CardScannerEvent();
      bloc.newOnlineRegistrationEventsPipeHandler(event);
      verify(mockNewOnlineRegistrationRequestUseCase.getCardInformation())
          .called(1);
      event = UpdateCardHolderNameRequestEvent('Tyler');
      bloc.newOnlineRegistrationEventsPipeHandler(event);
      verify(mockNewOnlineRegistrationRequestUseCase.updateUserName(any))
          .called(1);
      event = UpdateCardHolderNumberRequestEvent('12345678901234567');
      bloc.newOnlineRegistrationEventsPipeHandler(event);
      verify(mockNewOnlineRegistrationRequestUseCase.updateCardNumber(any))
          .called(1);
      event = UpdateCardExpiryRequestEvent('08/50');
      bloc.newOnlineRegistrationEventsPipeHandler(event);
      verify(mockNewOnlineRegistrationRequestUseCase.updateCardExpireDate(any))
          .called(1);
      event = UpdateEmailAddressRequestEvent('test@test.com');
      bloc.newOnlineRegistrationEventsPipeHandler(event);
      verify(mockNewOnlineRegistrationRequestUseCase.updateEmailAddress(any))
          .called(1);
      event = UpdateUserPasswordRequestEvent('test@test.com');
      bloc.newOnlineRegistrationEventsPipeHandler(event);
      verify(mockNewOnlineRegistrationRequestUseCase.updatePassword(any))
          .called(1);
    });

    test('NewOnlineRegistrationBloc validationOfFields', () async {
      NewOnlineRegistrationBloc bloc = NewOnlineRegistrationBloc(
          newOnlineRegistrationRequestUseCase:
              mockNewOnlineRegistrationRequestUseCase,
          newOnlineRegistrationRequestSuccessUseCase:
              mockNewOnlineRegistrationRequestSuccessUseCase);
      bloc.validateUserName('Tyler');
      verify(mockNewOnlineRegistrationRequestUseCase.validateUserName(any))
          .called(1);
      bloc.validateCardHolderNumber('12345678901234567');
      verify(mockNewOnlineRegistrationRequestUseCase.validateCardNumber(any))
          .called(1);
      bloc.validateCardExpiryDate('08/50');
      verify(mockNewOnlineRegistrationRequestUseCase.validateDate(any))
          .called(1);
      bloc.validateEmailAddress('test@test.com');
      verify(mockNewOnlineRegistrationRequestUseCase.validateEmailAddress(any))
          .called(1);
      bloc.validateUserPassword('Test@test123');
      verify(mockNewOnlineRegistrationRequestUseCase.validateUserPassword(any))
          .called(1);
    });
  });
}

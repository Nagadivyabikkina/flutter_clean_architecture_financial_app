// @dart=2.9
import 'package:clean_framework/clean_framework.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_success/new_online_registration_success_usecase.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_entity.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_enums.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_success/new_online_registration_success_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final useCase = NewOnlineRegistrationRequestSuccessUseCase((viewModel) {
    return true;
  });
  NewOnlineRegistrationRequestSuccessViewModel viewModel;

  test('NewOnlineRegistrationRequestSuccessUseCase success service call',
      () async {
    var entity = NewOnlineRegistrationEntity(
        errors: [],
        cardHolderName: 'Tyler',
        cardNumber: '378282246310005',
        email: 'test@test.com',
        userPassword: 'TestPassword@123',
        accountNumberGenerated: '123456789');

    viewModel = useCase.buildViewModel(entity);
    expect(viewModel.cardHolderName, entity.cardHolderName);
    expect(viewModel.serviceResponseStatus,
        NewOnlineRegistrationServiceResponseStatus.succeed);
    expect(viewModel.accountNumberGenerated, '123456789');
  });

  test('NewOnlineRegistrationRequestSuccessUseCase success service call',
      () async {
    var entity = NewOnlineRegistrationEntity(
        errors: [EntityFailure()],
        cardHolderName: 'Tyler',
        cardNumber: '378282246310005',
        email: 'test@test.com',
        userPassword: 'TestPassword@123',
        accountNumberGenerated: '');

    viewModel = useCase.buildViewModel(entity);
    expect(viewModel.cardHolderName, entity.cardHolderName);
    expect(viewModel.serviceResponseStatus,
        NewOnlineRegistrationServiceResponseStatus.failed);
    expect(viewModel.accountNumberGenerated, '');
  });
}

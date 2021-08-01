import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_service_adapter.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_entity.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_enums.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_success/new_online_registration_success_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/locator.dart';

class NewOnlineRegistrationRequestSuccessUseCase extends UseCase {
  RepositoryScope? _scopeRegistrationStatusResponse;
  final ViewModelCallback<ViewModel> _viewModelCallBack;

  NewOnlineRegistrationRequestSuccessUseCase(
      ViewModelCallback<ViewModel> viewModelCallBack)
      : _viewModelCallBack = viewModelCallBack;

  Future<void> create() async {
    _scopeRegistrationStatusResponse = ExampleLocator()
        .repository
        .create<NewOnlineRegistrationEntity>(
            NewOnlineRegistrationEntity(), _notifySubscribers);

    await ExampleLocator().repository.runServiceAdapter(
        _scopeRegistrationStatusResponse!,
        NewOnlineRegistrationRequestServiceAdapter());

    sendViewModelToSubscribers();
  }

  void sendViewModelToSubscribers() {
    NewOnlineRegistrationEntity newOnlineRegistrationEntity =
        ExampleLocator().repository.get(_scopeRegistrationStatusResponse!);
    _notifySubscribers(newOnlineRegistrationEntity);
  }

  void _notifySubscribers(entity) {
    _viewModelCallBack(buildViewModel(entity));
  }

  void resetViewModel() {
    final emptyEntity = NewOnlineRegistrationEntity(
        cardHolderName: '',
        cardNumber: '',
        email: '',
        userPassword: '',
        validThru: '');
    ExampleLocator().repository.update<NewOnlineRegistrationEntity>(
        _scopeRegistrationStatusResponse!, emptyEntity);
    _notifySubscribers(emptyEntity);
  }

  NewOnlineRegistrationRequestSuccessViewModel buildViewModel(
      NewOnlineRegistrationEntity newOnlineRegistrationEntity) {
    if (newOnlineRegistrationEntity.errors.length > 0)
      return buildViewModelStatusError(newOnlineRegistrationEntity);
    else
      return buildViewModelStatusOK(newOnlineRegistrationEntity);
  }

  NewOnlineRegistrationRequestSuccessViewModel buildViewModelStatusOK(
      NewOnlineRegistrationEntity newOnlineRegistrationEntity) {
    return NewOnlineRegistrationRequestSuccessViewModel(
      cardHolderName: newOnlineRegistrationEntity.cardHolderName,
      accountNumberGenerated:
          newOnlineRegistrationEntity.accountNumberGenerated ?? '',
      serviceResponseStatus: NewOnlineRegistrationServiceResponseStatus.succeed,
    );
  }

  NewOnlineRegistrationRequestSuccessViewModel buildViewModelStatusError(
      NewOnlineRegistrationEntity newOnlineRegistrationEntity) {
    return NewOnlineRegistrationRequestSuccessViewModel(
      cardHolderName: newOnlineRegistrationEntity.cardHolderName,
      accountNumberGenerated:
          newOnlineRegistrationEntity.accountNumberGenerated,
      serviceResponseStatus: NewOnlineRegistrationServiceResponseStatus.failed,
    );
  }
}

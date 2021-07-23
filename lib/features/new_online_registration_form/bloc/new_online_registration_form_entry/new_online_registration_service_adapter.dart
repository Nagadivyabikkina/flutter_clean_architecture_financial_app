import 'package:clean_framework/clean_framework.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/api/new_online_registration_service.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/api/new_online_registration_service_request_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/api/new_online_registration_service_response_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_entity.dart';

class NewOnlineRegistrationRequestServiceAdapter extends ServiceAdapter<
    NewOnlineRegistrationEntity,
    NewOnlineRegistrationServiceRequestModel,
    NewOnlineRegistrationServiceResponseModel,
    NewOnlineRegistrationService> {
  NewOnlineRegistrationRequestServiceAdapter()
      : super(NewOnlineRegistrationService());

  @override
  NewOnlineRegistrationEntity createEntity(initialEntity, responseModel) {
    return initialEntity.merge(
      errors: <EntityFailure>[],
      accountNumberGenerated: responseModel.accountNumberGenerated,
    ) as NewOnlineRegistrationEntity;
  }

  @override
  NewOnlineRegistrationServiceRequestModel createRequest(
      NewOnlineRegistrationEntity entity) {
    return NewOnlineRegistrationServiceRequestModel(
      cardHolderName: entity.cardHolderName,
      cardNumber: entity.cardNumber,
      validThru: entity.validThru,
      email: entity.email,
      userPassword: entity.userPassword,
    );
  }
}

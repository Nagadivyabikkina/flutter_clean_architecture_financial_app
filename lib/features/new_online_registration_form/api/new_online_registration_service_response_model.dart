import 'package:clean_framework/clean_framework_defaults.dart';

class NewOnlineRegistrationServiceResponseModel extends JsonResponseModel {
  final String accountNumberGenerated;

  NewOnlineRegistrationServiceResponseModel.fromJson(Map<String, dynamic> json)
      : accountNumberGenerated = json['accountNumberGenerated'] ?? '';

  @override
  List<Object> get props => [accountNumberGenerated];
}

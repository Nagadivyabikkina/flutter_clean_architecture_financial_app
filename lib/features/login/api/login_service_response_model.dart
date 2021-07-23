import 'package:clean_framework/clean_framework_defaults.dart';

class LoginServiceResponseModel extends JsonResponseModel {
  final bool didSucceed;

  LoginServiceResponseModel.fromJson(Map<String, dynamic> json)
      : didSucceed = true;

  @override
  List<Object> get props => [didSucceed];
}

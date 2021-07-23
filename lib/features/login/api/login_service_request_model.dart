import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:equatable/equatable.dart';

class LoginServiceRequestModel extends Equatable implements JsonRequestModel {
  final String? userName;
  final String? password;

  LoginServiceRequestModel({this.userName, this.password});

  @override
  Map<String, dynamic> toJson() {
    return {'userName': userName, 'password': password};
  }

  @override
  List<Object?> get props => [userName, password];
}

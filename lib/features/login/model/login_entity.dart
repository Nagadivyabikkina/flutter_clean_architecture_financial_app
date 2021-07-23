import 'package:clean_framework/clean_framework.dart';

class LoginEntity extends Entity {
  final String userName;
  final String password;

  LoginEntity(
      {List<EntityFailure> errors = const [], String? userName, String? password})
      : userName = userName ?? '',
        password = password ?? '',
        super(errors: errors);

  @override
  List<Object> get props => [userName, password, errors];

  @override
  merge({errors, String? userName, String? password}) {
    return LoginEntity(
        errors: errors ?? this.errors,
        userName: userName ?? this.userName,
        password: password ?? this.password);
  }
}

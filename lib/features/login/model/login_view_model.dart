import 'package:clean_framework/clean_framework.dart';

class LoginViewModel extends ViewModel {
  final String? username;
  final String? password;
  final serviceStatus;
  final dataStatus;

  LoginViewModel({this.username, this.password, this.serviceStatus = ServiceStatus.unknown, this.dataStatus = DataStatus.unknown})
      : assert(username != null && password != null);

  @override
  List<Object?> get props => [username, password, serviceStatus, dataStatus];
}

enum ServiceStatus { success, fail, unknown }
enum DataStatus { valid, invalid, unknown }

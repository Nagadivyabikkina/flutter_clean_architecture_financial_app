import 'package:clean_framework/clean_framework.dart';

class NewOnlineRegistrationRequestSuccessViewModel extends ViewModel {
  final String? cardHolderName;
  final String? accountNumberGenerated;
  final serviceResponseStatus;

  NewOnlineRegistrationRequestSuccessViewModel(
      {required this.cardHolderName,
      required this.accountNumberGenerated,
      required this.serviceResponseStatus});

  @override
  List<Object> get props => [
        cardHolderName!,
        accountNumberGenerated!,
        serviceResponseStatus,
      ];
}

import 'package:equatable/equatable.dart';

abstract class NewOnlineRegistrationEvent extends Equatable {}

class CardScannerEvent extends NewOnlineRegistrationEvent {
  CardScannerEvent();
  @override
  List<Object?> get props => [];
  @override
  bool get stringify => true;
}

class UpdateCardHolderNameRequestEvent extends NewOnlineRegistrationEvent {
  final String username;

  UpdateCardHolderNameRequestEvent(this.username);

  @override
  List<Object?> get props => [username];
  @override
  bool get stringify => true;
}


class UpdateCardHolderNumberRequestEvent extends NewOnlineRegistrationEvent {
  final String cardNumber;

  UpdateCardHolderNumberRequestEvent(this.cardNumber);

  @override
  List<Object?> get props => [cardNumber];
  @override
  bool get stringify => true;
}

class UpdateCardExpiryRequestEvent extends NewOnlineRegistrationEvent {
  final String expiryDate;

  UpdateCardExpiryRequestEvent(this.expiryDate);

  @override
  List<Object?> get props => [expiryDate];
  @override
  bool get stringify => true;
}

class UpdateUserPasswordRequestEvent extends NewOnlineRegistrationEvent {
  final String password;

  UpdateUserPasswordRequestEvent(this.password);

  @override
  List<Object?> get props => [password];
  @override
  bool get stringify => true;
}

class UpdateEmailAddressRequestEvent extends NewOnlineRegistrationEvent {
  final String email;

  UpdateEmailAddressRequestEvent(this.email);

  @override
  List<Object?> get props => [email];
  @override
  bool get stringify => true;
}

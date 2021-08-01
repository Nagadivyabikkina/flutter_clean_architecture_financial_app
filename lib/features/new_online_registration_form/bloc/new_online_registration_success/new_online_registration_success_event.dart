import 'package:equatable/equatable.dart';

abstract class NewOnlineRegistrationConfirmEvent extends Equatable {}

class ResetNewOnlineRegistrationViewModelEvent
    implements NewOnlineRegistrationConfirmEvent {
  ResetNewOnlineRegistrationViewModelEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ResetServiceStatusEvent implements NewOnlineRegistrationConfirmEvent {
  ResetServiceStatusEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

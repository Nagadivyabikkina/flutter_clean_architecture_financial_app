// @dart=2.9
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_enums.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_success/new_online_registration_success_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Online Registration View Model', () {
    final tViewModel = NewOnlineRegistrationRequestSuccessViewModel(
        cardHolderName: 'Tyler',
        accountNumberGenerated: '123456789',
        serviceResponseStatus:
            NewOnlineRegistrationServiceResponseStatus.unknown);

    test('should properties match', () {
      expect(tViewModel.cardHolderName, 'Tyler');
      expect(tViewModel.accountNumberGenerated, '123456789');
      expect(tViewModel.serviceResponseStatus,
          NewOnlineRegistrationServiceResponseStatus.unknown);
    });

    test('should props match', () async {
      expect(tViewModel.props, [
        tViewModel.cardHolderName,
        tViewModel.accountNumberGenerated,
        tViewModel.serviceResponseStatus,
      ]);
    });
  });
}

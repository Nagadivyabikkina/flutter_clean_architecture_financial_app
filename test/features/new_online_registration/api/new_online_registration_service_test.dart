// @dart=2.9
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/api/new_online_registration_service.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/api/new_online_registration_service_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' show Request, Response;
import 'package:http/testing.dart';

void main() {
  group('NewOnlineRegistrationService Test', () {
    test("RestAPI POST call", () async {
      final client = MockClient((Request request) async {
        return Response('{"accountNumberGenerated": "123456789"}', 200);
      });
      final resp =
          await client.post(Uri.https('test.com', 'create-new-account'));
      expect(resp.body, '{"accountNumberGenerated": "123456789"}');
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient((Request request) async {
        return Response('{"accountNumberGenerated": ""}', 404);
      });
      final resp =
          await client.post(Uri.https('test.com', 'create-new-account'));

      expect(resp.statusCode, 404);
    });

    test('NewOnlineRegistrationService parseResponse', () async {
      final json = {
        'cardHolderName': 'Test',
        'cardNumber': '12345',
        'validThru': '08/50',
        'email': 'test@test.com',
        'userPassword': ''
      };

      final service = NewOnlineRegistrationService();

      NewOnlineRegistrationServiceResponseModel response =
          service.parseResponse(json);

      expect(
          response, NewOnlineRegistrationServiceResponseModel.fromJson(json));
    });
  });
}

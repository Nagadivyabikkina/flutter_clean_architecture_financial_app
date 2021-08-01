import 'package:clean_framework/clean_framework.dart';
import 'package:flutter_clean_architecture_financial_app/core/patch_simple_rest_api.dart';
import 'package:flutter_test/flutter_test.dart';

final String baseUrl = "http://localhost:3001/";

void main() {
  test("PatchSimpleRestAPI post call", () async {
    PatchSimpleRestApi api = PatchSimpleRestApi(baseUrl: baseUrl);
    RestResponse resp =
        await api.request(method: RestMethod.post, path: 'create-new-account');
    expect(resp.type, RestResponseType.success);

    expect(
        resp.content,
        '{\n'
        '  "accountNumberGenerated": "123456789"\n'
        '}');
  });
}

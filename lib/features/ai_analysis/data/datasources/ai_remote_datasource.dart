import 'package:celluweather_task1/core/utils/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AiRemoteDataSource {
  Future<int> predict(List<int> inputs);
}

class AiRemoteDataSourceImpl implements AiRemoteDataSource {
  final http.Client client;

  AiRemoteDataSourceImpl(this.client);
  @override
  Future<int> predict(List<int> inputs) async {
    final url = Uri.parse('${ApiKeys.ipconfig}/predict');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'features': inputs}),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['prediction'][0] as int;
    } else {
      throw Exception('Failed to get prediction');
    }
  }
}

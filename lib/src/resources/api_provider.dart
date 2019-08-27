import 'package:http/http.dart' show Client;
import '../../secret.dart';
import 'dart:convert';

final String _key = api['key'];
final _root = 'https://pixabay.com/api/?key=$_key';

class ApiProvider {
  Client client = Client();
  Future<Map<String, dynamic>> fetchItemList({String query = 'nature'}) async {
    final response = await client.get('$_root&q=$query');
    final body = json.decode(response.body);
    return body;
  }
}

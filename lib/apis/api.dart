import '../environment/env.dart';
import 'package:http/http.dart' as http;

class APIService {
  static Future<String> fetchData(String endpoint) async {
    var url = Uri.parse('${Environment.baseUrl}$endpoint');
    var response = await http.get(url);
    return response.body;
  }
}

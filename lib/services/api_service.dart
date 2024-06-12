import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> createTransaction(Map<String, dynamic> transaction) async {
    final url = Uri.parse('$baseUrl/dataset/input');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transaction),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create transaction: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> checkFraudStatus(int id) async {
    final url = Uri.parse('$baseUrl/api/is-fraud/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check fraud status');
    }
  }

  Future<List<Map<String, dynamic>>> fetchTransactions() async {
    final url = Uri.parse('$baseUrl/dataset/input');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((transaction) => transaction as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }

  Future<Map<String, dynamic>> fetchTransactionById(String id) async {
    final url = Uri.parse('$baseUrl/dataset/input/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch transaction by ID');
    }
  }
}
import 'dart:convert';
import 'package:employee_data/models/employee_model.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static Future<List<Employee>> fetchEmployees() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
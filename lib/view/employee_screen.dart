import 'package:employee_data/models/employee_model.dart';
import 'package:employee_data/services/employee_service.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<Employee> employees = [];
  bool isLoading = false;

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Employee> data = await EmployeeService.fetchEmployees();
      setState(() {
        employees = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: fetchData,
            child: Text('Fetch Employees'),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      final employee = employees[index];
                      return ListTile(
                        title: Text(employee.name),
                        subtitle: Text(employee.email),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

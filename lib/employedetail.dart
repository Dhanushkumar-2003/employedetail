import 'package:flutter/material.dart';
import 'package:work/apimodel.dart';

class Employedetail extends StatelessWidget {
  final User employee;

  const Employedetail({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Detail')),
      body: Container(
        width: double.infinity,
        // padding: const EdgeInsets.all(8.0),
        child: Card(
          // margin: EdgeInsets.only(left: ),
          color: Colors.yellow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${employee.firstName}',
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 8),
              Text('phone: ${employee.phone}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('email: ${employee.email}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('gender: ${employee.gender}',
                  style: TextStyle(fontSize: 18)),
              Text('address: ${employee.address!.address}',
                  style: TextStyle(fontSize: 18)),
              Text('bank: ${employee.bank!.currency}',
                  style: TextStyle(fontSize: 18)),
              Text('birthdate: ${employee.birthDate}',
                  style: TextStyle(fontSize: 18))
            ],
          ),
        ),
      ),
    );
  }
}
// https://dummyjson.com/users
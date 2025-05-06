import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:work/apimodel.dart';

import 'package:http/http.dart' as http;
import 'package:work/employedetail.dart';

class Employeelist extends StatefulWidget {
  const Employeelist({super.key});

  @override
  State<Employeelist> createState() => _EmployeelistState();
}

class _EmployeelistState extends State<Employeelist> {
  @override
  // void initState() {
  //   super.initState();
  //   futureEmployee = fetchData();
  // }

  Future<Userdetail> fetchData() async {
    final uri = Uri.parse('https://dummyjson.com/users');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      var userdetail = Userdetail.fromJson(user);
      return userdetail;
    } else {
      throw Exception('Failed to fetch data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("employelist"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: FutureBuilder<Userdetail>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              var userdata = snapshot.data!;
              return ListView.builder(
                itemCount: userdata.users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = userdata.users[index];
                  return Card(
                    child: Container(
                      height: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.firstName.toString(),
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                          Text(user.email.toString()),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 100,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Employedetail(employee: user),
                                    ),
                                  );
                                },
                                child: Center(child: Text("detail")),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: Text('No data'));
          },
        ),
      ),
    );
  }
}

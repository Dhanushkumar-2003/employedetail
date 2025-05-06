import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:work/apimodel.dart';

import 'package:http/http.dart' as http;
import 'package:work/employelist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();
  Future<Userdetail> fetchData() async {
    final uri = Uri.parse('https://dummyjson.com/users');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      print("use>>>>$user");
      var userdetail = Userdetail.fromJson(user);
      // return product = user1;
      print("usersDEATIL>>>>${userdetail.users[1].address}");

      // return product;
      // product = userdetail.toJson;
      // print("PRODUCT>>$product");
      return userdetail;
    } else {
      throw Exception('Failed to update album.');
    }
  }

  Future LoginApi() async {
    try {
      print('step11>>>');

      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        headers: {
          'x-api-key': 'reqres-free-v1',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({"email": username.text, "password": password.text}),
      );
      print("post2>>>$response");

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Employeelist()));
      } else {
        print(response.reasonPhrase);
        const snackdemo = SnackBar(
          content: Text('somwething went wrong'),
          backgroundColor: Colors.green,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      }
    } catch (e) {
      const snackdemo = SnackBar(
        content: Text('somwething went wrong'),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      setState(() {});
      print("errroerr>>$e");
    }
  }

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "username",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: username,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  prefixIcon: Icon(Icons.person_2_outlined),
                  hintText: 'enter user name'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "password",
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  prefixIcon: Icon(Icons.person_2_outlined),
                  hintText: 'enter password'),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  LoginApi();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                  width: double.infinity,
                  height: 50,
                  child: GestureDetector(child: Center(child: Text("signup"))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talktalk/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //late Token usertoken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "email",
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: ((value) {
                setState(() {
                  Provider.of<User>(context, listen: false).changeEmail(value);
                });
              }),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "password",
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onChanged: ((value) {
                setState(() {
                  Provider.of<User>(context, listen: false)
                      .changePassword(value);
                });
              }),
            ),
            ElevatedButton(
              onPressed: () async {
                Token usertoken = await _login(
                    Provider.of<User>(context, listen: false).email,
                    Provider.of<User>(context, listen: false).password);
                Provider.of<User>(context, listen: false)
                    .changeAccess(usertoken.access.toString());
                Provider.of<User>(context, listen: false)
                    .changeRefresh(usertoken.refresh.toString());
              },
              child: const Text("로그인"),
            ),
            Text("nickname: ${Provider.of<User>(context).nickname}"),
            Text("username: ${Provider.of<User>(context).username}"),
            Text("email: ${Provider.of<User>(context).email}"),
            Text("refresh: ${Provider.of<User>(context).refresh}"),
            Text("access: ${Provider.of<User>(context).access}"),
            Text("password: ${Provider.of<User>(context).password}"),
          ],
        ),
      ),
    );
  }
}

Future<Token> _login(String userEmail, String userPassword) async {
  print(userEmail);
  print(userPassword);

  final response = await http.post(
      Uri.parse('${dotenv.get('MainURL')}account/login/'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": userEmail, "password": userPassword}));

  if (response.statusCode == 200) {
    return Token.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load Token');
  }
}

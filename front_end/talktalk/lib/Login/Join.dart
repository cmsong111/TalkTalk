import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talktalk/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  String email = "";
  String nickname = "";
  String username = "";
  String password = "";
  String password2 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "이메일",
              ),
              onChanged: (value) => {
                email = value,
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "닉네임",
              ),
              onChanged: (value) => {
                nickname = value,
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "이름",
              ),
              onChanged: (value) => {
                username = value,
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "password",
              ),
              onChanged: (value) => {
                password = value,
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "password 확인",
              ),
              onChanged: (value) => {
                password2 = value,
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            ElevatedButton(
              onPressed: () async {
                Join JoinInfo =
                    await _Join(email, nickname, username, password, password2);
                setState(() {
                  Provider.of<User>(context, listen: false)
                      .changeEmail(JoinInfo.email.toString());
                  Provider.of<User>(context, listen: false)
                      .changeNickname(nickname);
                  Provider.of<User>(context, listen: false)
                      .changeUsername(username);
                  Provider.of<User>(context, listen: false)
                      .changePassword(password);
                });
              },
              child: const Text("회원가입"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Join> _Join(
  String email,
  String nickname,
  String username,
  String password,
  String password2,
) async {
  final response = await http.post(
      Uri.parse('${dotenv.get('MainURL')}api/v1/accounts/register/'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": email,
        "nickname": nickname,
        "username": username,
        "password": password,
        "is_admin": false,
        "password_confirm": password2,
      }));
  print(response.body.toString());
  print(utf8.decode(response.bodyBytes));
  print(response.statusCode);

  if (response.statusCode == 201) {
    return Join.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load Token');
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:talktalk/Login/Join.dart';
import 'package:talktalk/Login/Login.dart';
import 'package:talktalk/Models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => User(
            email: "email",
            username: "username",
            nickname: "nickname",
            refresh: "refresh",
            access: "access",
            password: "password",
          ),
        )
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("시작화면"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Image.asset("images/Logo.jpg"),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const LoginPage());
              },
              child: const Text("로그인"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(const JoinPage());
              },
              child: const Text("회원가입"),
            ),
          ],
        ),
      ),
    );
  }
}

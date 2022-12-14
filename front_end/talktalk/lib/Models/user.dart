import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String email;
  String username;
  String nickname;
  String refresh;
  String access;
  String password;

  User({
    required this.email,
    required this.username,
    required this.nickname,
    required this.refresh,
    required this.access,
    required this.password,
  });

  void changeUsername(String temp) {
    email = username;
    notifyListeners();
  }

  void changeEmail(String temp) {
    email = temp;
    notifyListeners();
  }

  void changeNickname(String temp) {
    nickname = temp;
    notifyListeners();
  }

  void changeRefresh(String temp) {
    refresh = temp;
    notifyListeners();
  }

  void changeAccess(String temp) {
    access = temp;
    notifyListeners();
  }

  void changePassword(String temp) {
    password = temp;
    notifyListeners();
  }
}

class Token {
  String? refresh;
  String? access;

  Token({this.refresh, this.access});

  Token.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}

class Join {
  int? id;
  String? email;
  String? username;
  String? nickname;
  String? createdAt;
  String? updatedAt;

  Join({
    this.id,
    this.email,
    this.username,
    this.nickname,
    this.createdAt,
    this.updatedAt,
  });

  Join.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    nickname = json['nickname'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

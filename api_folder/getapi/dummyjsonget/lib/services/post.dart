// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    int userId;
    int id;
    String title;
    bool completed;

    Post({
        required this.userId,
        required this.id,
        required this.title,
        required this.completed,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
    };
}
// To parse this JSON data, do
//
//     final postpractice = postpracticeFromJson(jsonString);

// import 'dart:convert';

// To parse this JSON data, do
//
//     final postpractice = postpracticeFromJson(jsonString);

// import 'dart:convert';

Postpractice postpracticeFromJson(String str) => Postpractice.fromJson(json.decode(str));

String postpracticeToJson(Postpractice data) => json.encode(data.toJson());

class Postpractice {
    String userName;
    String password;
    String mailId;
    int mobileNo;
    DateTime dob;
    String address;

    Postpractice({
        required this.userName,
        required this.password,
        required this.mailId,
        required this.mobileNo,
        required this.dob,
        required this.address,
    });

    factory Postpractice.fromJson(Map<String, dynamic> json) => Postpractice(
        userName: json["userName"],
        password: json["password"],
        mailId: json["mailID"],
        mobileNo: json["mobileNo"],
        dob: DateTime.parse(json["dob"]),
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
        "mailID": mailId,
        "mobileNo": mobileNo,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "address": address,
    };
}

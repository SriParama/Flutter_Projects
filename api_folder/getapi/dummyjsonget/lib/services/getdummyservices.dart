// To parse this JSON data, do
//
//     final getUserdetials = getUserdetialsFromJson(jsonString);

import 'dart:convert';


GetUserdetials getUserdetialsFromJson(String str) => GetUserdetials.fromJson(json.decode(str));

String getUserdetialsToJson(GetUserdetials data) => json.encode(data.toJson());

class GetUserdetials {
    List<Product> products;
    int total;
    int skip;
    int limit;

    GetUserdetials({
        required this.products,
        required this.total,
        required this.skip,
        required this.limit,
    });

    factory GetUserdetials.fromJson(Map<String, dynamic> json) => GetUserdetials(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Product {
    int id;
    String title;
    String description;
    int price;
    double discountPercentage;
    double rating;
    int stock;
    String brand;
    String category;
    String thumbnail;
    List<String> images;

    Product({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.discountPercentage,
        required this.rating,
        required this.stock,
        required this.brand,
        required this.category,
        required this.thumbnail,
        required this.images,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        brand: json["brand"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        images: List<String>.from(json["images"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images": List<dynamic>.from(images.map((x) => x)),
    };
}


// To parse this JSON data, do
//
//     final getpractice = getpracticeFromJson(jsonString);

// import 'dart:convert';

// To parse this JSON data, do
//
//     final getpractice = getpracticeFromJson(jsonString);

// import 'dart:convert';

Getpractice getpracticeFromJson(String str) => Getpractice.fromJson(json.decode(str));

String getpracticeToJson(Getpractice data) => json.encode(data.toJson());

class Getpractice {
    List<Comment> comments;
    int total;
    int skip;
    int limit;

    Getpractice({
        required this.comments,
        required this.total,
        required this.skip,
        required this.limit,
    });

    factory Getpractice.fromJson(Map<String, dynamic> json) => Getpractice(
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Comment {
    int id;
    String body;
    int postId;
    User user;

    Comment({
        required this.id,
        required this.body,
        required this.postId,
        required this.user,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        postId: json["postId"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "postId": postId,
        "user": user.toJson(),
    };
}

class User {
    int id;
    String username;

    User({
        required this.id,
        required this.username,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
    };
}

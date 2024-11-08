// To parse this JSON data, do
//
//     final carddetails = carddetailsFromJson(jsonString);

import 'dart:convert';

Carddetails carddetailsFromJson(String str) => Carddetails.fromJson(json.decode(str));

String carddetailsToJson(Carddetails data) => json.encode(data.toJson());

class Carddetails {
    List<Cart> carts;
    int total;
    int skip;
    int limit;

    Carddetails({
        required this.carts,
        required this.total,
        required this.skip,
        required this.limit,
    });

    factory Carddetails.fromJson(Map<String, dynamic> json) => Carddetails(
        carts: List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "carts": List<dynamic>.from(carts.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Cart {
    int id;
    List<Product> products;
    int total;
    int discountedTotal;
    int userId;
    int totalProducts;
    int totalQuantity;

    Cart({
        required this.id,
        required this.products,
        required this.total,
        required this.discountedTotal,
        required this.userId,
        required this.totalProducts,
        required this.totalQuantity,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        discountedTotal: json["discountedTotal"],
        userId: json["userId"],
        totalProducts: json["totalProducts"],
        totalQuantity: json["totalQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "discountedTotal": discountedTotal,
        "userId": userId,
        "totalProducts": totalProducts,
        "totalQuantity": totalQuantity,
    };
}

class Product {
    int id;
    String title;
    int price;
    int quantity;
    int total;
    double discountPercentage;
    int discountedPrice;

    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.quantity,
        required this.total,
        required this.discountPercentage,
        required this.discountedPrice,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        discountedPrice: json["discountedPrice"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "quantity": quantity,
        "total": total,
        "discountPercentage": discountPercentage,
        "discountedPrice": discountedPrice,
    };
}

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:dummyjsonget/services/getdummyservices.dart';
import 'package:dummyjsonget/services/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
// import 'getuserlist.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // GetUserList - Model name
  // getuserlistModel - Object name

   GetUserdetials? getuserlistModel;
  // late Getpractice getcomments;
  var isLoaded = true;

  @override
  void initState() {
      //  getData() ;
    _getData();
 
    super.initState();
  }
  //it was the getData function it will stored the getUserfunction

  void _getData() async {
    getuserlistModel = (await getUsers())!;
    //  getcomments= (await getcommentUsers())!;
    // print(getuserlistModel);
    setState(() {
      Getcategaryfun();
      // Getcommentsfun() ;
    });
  }

  //it was the getUser function it was used to like remote folder it was used to response from the
  //url and check the conditions...

  Future<GetUserdetials?> getUsers() async {
/*
When it is from button click
isLoaded = true;
setState(() {  
});
*/
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/product'),
      );
      if (response.statusCode == 200) {
        isLoaded = false;
        // setState(() {});
        var json = response.body;
        // print(json);
        return getUserdetialsFromJson(json);
      } else {
        isLoaded = false;
        // setState(() {});
      }
    } catch (e) {
      print("Exception" + e.toString());
    }
    return null;
  }

// List<Post>? posts;
//   List<Post> filterdata = [];

//  getData() async {
//     posts = await getPosts();

//     for (int i = 0; i < posts!.length; i++) {
//          print(filterdata.length);
//       //That condition is checked by the either posts variable is add the filterdata list
//       if (posts![i].title.isNotEmpty) {
//         filterdata.add(posts![i]);
//       }
//     }

//     if (posts != null) {
//       setState(() {
//         isLoaded = false;
//       });
//     }
 
//   }




  Future<List<Post>?>getPosts() async{

     try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      
      );
      if (response.statusCode == 200) {
        isLoaded = false;
        // setState(() {});
          var json = response.body;
      return postFromJson(json);
        // print(json);
      
      } else {
        isLoaded = false;
        print('no data found');
        // setState(() {
          
        // });
      }
    } catch (e) {
      print("Exception" + e.toString());
    }
    return null;

  }











//   Future<Getpractice?> getcommentUsers() async {
// /*
// When it is from button click
// isLoaded = true;
// setState(() {  
// });
// */
//     try {
//       final response = await http.get(
//         Uri.parse('https://dummyjson.com/comments'),
//       );
//       if (response.statusCode == 200) {
//         isLoaded = false;
//         // setState(() {});
//         var json = response.body;
//         // print(json);
//         return getpracticeFromJson(json);
//       } else {
//         isLoaded = false;
//         // setState(() {});
//       }
//     } catch (e) {
//       print("Exception" + e.toString());
//     }
//     return null;
//   }

  //getcategaryfun is used to return the list from the empty list names us categries it will stored the add the different
  //categries from the json so add the list from the getuserlistModel object .product .category to the users finaly return the categries list

  List Getcategaryfun() {
    List categories = ['All'];
    for (var i = 0; i < getuserlistModel!.products.length; i++) {
      if (!categories.contains(getuserlistModel!.products[i].category)) {
        categories.add(getuserlistModel!.products[i].category);
      }
    }
    return categories;
  }
  //   List Getcommentsfun() {
  //   List comments = ['All'];
  //   for (var i = 0; i < getcomments.comments.length; i++) {
  //     if (!comments.contains(getcomments.comments[i])) {
  //       comments.add(getcomments.comments[i]);
  //     }
  //   }
  //   return comments;
  // }

  //gridviewitems function is used to multiple categries are present in products so different categries are showing the onclick
  //process..

  int griditem = 2;
  String selectedcategory = "All";




  List<Product> gridviewitems(String categories) {
    // print(categories);
    List<Product> gridcategries = [];
    if (categories == 'All') {
      return gridcategries = getuserlistModel!.products;
    }

    for (var element in getuserlistModel!.products) {
      if (element.category == categories) {
        gridcategries.add(element);
      }
    }
    return gridcategries;
  }

//This function is used to calculate the orginal price from the discountprice and discountpercentage...

  String calculateOriginalPrice(int discountedPrice, int discountPercentage) {
    if (discountPercentage <= 0 || discountPercentage >= 100) {
      throw Exception('Invalid discount percentage');
    }

    double originalPrice = (discountedPrice * 100) / (100 - discountPercentage);
    return originalPrice.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get"),
      ),
      body: !isLoaded
          ? getuserlistModel!.products.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        // margin: EdgeInsets.all(10.0),
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width,

                        child: Swiper(
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.all(10.0),
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  // border:
                                  //     Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        gridviewitems(selectedcategory)[index]
                                            .thumbnail,
                                      ),
                                      fit: BoxFit.fill)),
                              // child: Image.network(
                              //     gridviewitems(
                              //             selectedcategory)[index]
                              //         .thumbnail,
                              //     fit: BoxFit.fill),
                            );
                          },
                          itemCount: 5,
                          duration: 1000,
                          pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  activeColor: Colors.white,
                                  color: Colors.black)),
                          // control: SwiperControl(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Getcategaryfun().length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedcategory = Getcategaryfun()[index];
                                  });
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      child: Text(Getcategaryfun()[index][0]),
                                    ),
                                    Text(Getcategaryfun()[index]),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(child: Text('Offer Products')),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                griditem = 1;
                              });
                            },
                            icon: Icon(Icons.view_headline_outlined)),
                        SizedBox(
                          width: 5.0,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                griditem = 2;
                              });
                            },
                            icon: Icon(Icons.view_comfy_alt_outlined)),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: griditem,
                          mainAxisExtent: 300.0, // Number of columns
                          mainAxisSpacing: 10.0, // Spacing between rows
                          crossAxisSpacing: 10.0, // Spacing between columns
                        ),
                        itemCount: gridviewitems(selectedcategory)
                            .length, // Number of items in the grid
                        itemBuilder: (BuildContext context, int index) {
                          final product =
                              gridviewitems(selectedcategory)[index];
                         
                          return InkWell(
                              onTap: () {
                                final totall=getuserlistModel;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailsPage(product: product,total: totall!.total,),
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10.0),
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                gridviewitems(
                                                        selectedcategory)[index]
                                                    .thumbnail,
                                              ),
                                              fit: BoxFit.fill)),
                                    ),
                                    Text(
                                      gridviewitems(selectedcategory)[index]
                                          .title,
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "\u20B9 ${gridviewitems(selectedcategory)[index].price} ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),

                                        Text(
                                          "${calculateOriginalPrice(gridviewitems(selectedcategory)[index].price, gridviewitems(selectedcategory)[index].discountPercentage.toInt())} ",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey),
                                        ),

                                        // Text(
                                        //     "Rating: ${gridviewitems(selectedcategory)[index].rating} ",style: TextStyle(color: Colors.green),),
                                      ],
                                    ),
                                    Text(
                                      "${gridviewitems(selectedcategory)[index].discountPercentage}%Off ",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    // Text(
                                    //   "${filterdata[index].title} ",
                                    //   style: TextStyle(color: Colors.green),
                                    // ),
                                    // Text(),
                                    // Text(getuserlistModel.limit.toString())
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                  ],
                )
              : const Center(child: Text("No Data Found"))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final int total;
  const ProductDetailsPage({super.key, required this.product, required this.total,});

  //  final Product product. rating;

  // StarRatingDisplay({required this.rating});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
//  Widget _buildStarRating(double rating) {

//  List<Widget> stars=[];
//   int totalstar = 5;

//   for (int i = 1; i < totalstar; i++) {
//     IconData staricon;

//   }

//   if (halfStars == 1) {
//    stars=Icons.star_half;
//   }

//   int remainingStars = 5 - fullStars - halfStars;
//   for (int i = 0; i < remainingStars; i++) {
//    stars=Icons.star_border;
//   }

//   return stars;
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // reverse: true,

              child: SizedBox(
                // margin: EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,

                child: Swiper(
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width *
                          0.85, // Example content that exceeds the screen height
                      //  color: Colors.blue,
                      child: Image.network(widget.product.images[index]),
                    );
                  },
                  itemCount: widget.product.images.length,
                  duration: 1000,
                  pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          activeColor: Colors.green, color: Colors.black)),
                  // control: SwiperControl(),
                ),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Description')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Price')),
                  DataCell(Text('${widget.product.price}')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Description')),
                  DataCell(Text(widget.product.description)),
                ]),
                DataRow(cells: [
                  DataCell(Text('rating')),
                  DataCell(Row(
                    children: [
                      RatingStars(
                        value: widget.product.rating,
                        onValueChanged: (v) {
                          //
                          // setState(() {
                          //   value = v;
                          // });
                        },
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                          // fill: 2,
                          // grade: 2,
                          shadows: [
                            Shadow(
                              color: Colors.grey,
                              // offset: Offset(1, 1)
                            )
                          ],
                        ),
                        starCount: 5,
                        starSize: 20,
                        valueLabelColor: const Color(0xff9b9b9b),
                        valueLabelTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        valueLabelRadius: 10,
                        maxValue: 5,
                        starSpacing: 2,
                        maxValueVisibility: true,
                        valueLabelVisibility: true,
                        animationDuration: Duration(milliseconds: 1000),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: Color.fromARGB(255, 50, 54, 58),
                        starColor: Colors.yellow,
                      ),
                    ],
                  )
                      // Text(widget.product.rating as String)
                      ),
                ]),
                DataRow(cells: [
                  DataCell(Text('stock')),
                  DataCell(Text('${widget.product.stock}')),
                ]),
                DataRow(cells: [
                  DataCell(Text('brand')),
                  DataCell(Text(widget.product.brand)),
                ]),
                DataRow(cells: [
                  DataCell(Text('category')),
                  DataCell(Text(widget.product.category)),
                ]),
              ],
            ),
            
        

            // Image.network(widget.product.thumbnail),
            Text('Price: \$${widget.total}'),
            
            // Text('Description: ${widget.product.description}'),
          ],
        ),
      ),
    );
  }
}

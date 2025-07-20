import 'package:ecommerce_app/addProduct.dart';
import 'package:ecommerce_app/productDetail.dart';
import 'package:flutter/material.dart';
import 'search.dart';
class Product extends StatelessWidget {
  Product({super.key});

  final List<Map<String, dynamic>> productlist = [
    {
      "image": "images/book2.jpg",
      "title": "The Last Super",
      "price": 23,
      "category": "mens",
      "rating": 4.0,
    },
    {
      "image": "images/cute.jpg",
      "title": "Cute Hoodie",
      "price": 45,
      "category": "mens",
      "rating": 4.2,
    },
    {
      "image": "images/ear.jpg",
      "title": "Wireless Earbuds",
      "price": 89,
      "category": "electronics",
      "rating": 4.5,
    },
    {
      "image": "images/green.jpg",
      "title": "Green Plant",
      "price": 15,
      "category": "home",
      "rating": 3.8,
    },
    {
      "image": "images/harry.jpg",
      "title": "Harry Potter Book",
      "price": 12,
      "category": "books",
      "rating": 4.7,
    },
    {
      "image": "images/home.jpg",
      "title": "Home Decor",
      "price": 67,
      "category": "home",
      "rating": 4.1,
    },
    {
      "image": "images/gumball.jpg",
      "title": "Gumball Machine",
      "price": 120,
      "category": "toys",
      "rating": 4.3,
    },
    {
      "image": "images/google.png",
      "title": "Google Gadget",
      "price": 199,
      "category": "electronics",
      "rating": 4.6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 1,
        leading: Container(
          margin: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.person, color: Colors.pinkAccent),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Hello", style: TextStyle(fontSize: 17)),
                      const SizedBox(width: 5),
                      Text(
                        'Tsiyon Gashaw',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Last seen 2 hours ago',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.blueGrey),
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none_rounded,
                color: Colors.black54,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Avaialable products",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: IconButton(
                        iconSize: 25,
                        color: Colors.grey,
                        icon: Icon(Icons.search_outlined),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: productlist.length,
                itemBuilder: (context, index) {
                  final product = productlist[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Productdetail(),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: double.infinity,
                                child: Image.asset(
                                  product["image"]!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      product["title"]!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${product["price"]}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 16,
                                            ),
                                            Text(
                                              "${product["rating"]}",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addproduct()),
          );
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}

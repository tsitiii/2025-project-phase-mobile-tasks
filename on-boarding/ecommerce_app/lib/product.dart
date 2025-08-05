import 'package:ecommerce_app/addProduct.dart';
import 'package:flutter/material.dart';

import 'features/product/domain/entities/product.dart';
import 'search.dart';

class ProductUI extends StatefulWidget {
  ProductUI({super.key});

  @override
  State<ProductUI> createState() => _ProductUIState();
}

class _ProductUIState extends State<ProductUI> {
  List<Product> products = [];
  bool isLoading = true;
  String? errorMessage;
 

  final List<Map<String, dynamic>> productlist = [
    {
      "image": "images/book2.jpg",
      "title": "The Last Super",
      "price": 23,
      "category": "mens",
      "rating": 4.0,
      "description":
          "A thrilling adventure novel that combines action, mystery, and unforgettable characters in an epic story.", // ✅ Add this
    },
    {
      "image": "images/cute.jpg",
      "title": "Cute Hoodie",
      "price": 45,
      "category": "mens",
      "rating": 4.2,
      "description":
          "Comfortable and stylish hoodie perfect for casual wear. Made from high-quality cotton blend material.", // ✅ Add this
    },
    {
      "image": "images/ear.jpg",
      "title": "Wireless Earbuds",
      "price": 89,
      "category": "electronics",
      "rating": 4.5,
      "description":
          "Premium wireless earbuds with noise cancellation, long battery life, and crystal clear audio quality.", // ✅ Add this
    },
    {
      "image": "images/green.jpg",
      "title": "Green Plant",
      "price": 15,
      "category": "home",
      "rating": 3.8,
      "description":
          "Beautiful indoor plant that adds freshness to your home. Easy to care for and perfect for beginners.", // ✅ Add this
    },
    {
      "image": "images/harry.jpg",
      "title": "Harry Potter Book",
      "price": 12,
      "category": "books",
      "rating": 4.7,
      "description":
          "The magical world of Harry Potter comes alive in this bestselling fantasy novel series loved by millions.", // ✅ Add this
    },
    {
      "image": "images/home.jpg",
      "title": "Home Decor",
      "price": 67,
      "category": "home",
      "rating": 4.1,
      "description":
          "Elegant home decoration pieces that transform your living space into a stylish and cozy environment.", // ✅ Add this
    },
    {
      "image": "images/gumball.jpg",
      "title": "Gumball Machine",
      "price": 120,
      "category": "toys",
      "rating": 4.3,
      "description":
          "Classic vintage-style gumball machine that brings joy and nostalgia to any room. Perfect for kids and adults.", // ✅ Add this
    },
    {
      "image": "images/google.png",
      "title": "Google Gadget",
      "price": 199,
      "category": "electronics",
      "rating": 4.6,
      "description":
          "Innovative Google device with smart features, voice control, and seamless integration with your digital life.", // ✅ Add this
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 1,
        leading: Container(
          margin: const EdgeInsets.all(8),
          child: const CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Icon(Icons.person, color: Colors.pinkAccent),
          ),
        ),
        title: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Text("Hello", style: TextStyle(fontSize: 17)),
                      SizedBox(width: 5),
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
              icon: const Icon(
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
                    const Text(
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
                        icon: const Icon(Icons.search_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Search(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                        Navigator.pushNamed(
                          context,
                          '/product',
                          arguments: productlist[index],
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder:
                        //         (context) => Productdetail(
                        //           product: index,
                        //           products: productlist,
                        //         ),
                        //   ),
                        // );
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
                                  productlist[index]["image"]!,
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
                                      style: const TextStyle(
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
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 16,
                                            ),
                                            Text(
                                              "${product["rating"]}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
            MaterialPageRoute(builder: (context) => const Addproduct()),
          );
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

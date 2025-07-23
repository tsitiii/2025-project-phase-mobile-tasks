import 'package:ecommerce_app/productDetail.dart';
import 'package:ecommerce_app/search.dart';
import 'package:flutter/material.dart';

import 'product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => Product(),
        '/product': (context) => Productdetail(),
        '/search': (context) => Search(),
      },
    );
  }
}

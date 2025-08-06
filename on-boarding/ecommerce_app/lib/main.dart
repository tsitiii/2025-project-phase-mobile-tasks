import 'package:ecommerce_app/productDetail.dart';
import 'package:ecommerce_app/search.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/signin_screen.dart';
import 'features/auth/presentation/pages/signup_screen.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'features/chat/presentation/pages/chat_screen.dart';
import 'injection_container.dart' as di;
import 'product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
        '/productui': (context) => const ProductUI(),
        '/product': (context) => Productdetail(),
        '/search': (context) => const Search(),
        '/': (context) => const SplashScreen(),
        '/signup': (context) => const SignupScreen(),
        '/signin': (context) => const SigninPage(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}

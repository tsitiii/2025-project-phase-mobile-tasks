import 'package:ecommerce_app/productDetail.dart';
import 'package:ecommerce_app/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'addProduct.dart';
import 'features/auth/presentation/pages/signin_screen.dart';
import 'features/auth/presentation/pages/signup_screen.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'features/chat/domain/usecases/user_usecase.dart'; // ✅ Import this
import 'features/chat/presentation/bloc/user_bloc/user_bloc.dart'; // ✅ Import this
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
        '/product_ui': (context) => const ProductUI(),
        '/product': (context) => Productdetail(),
        '/add_product': (context) => Addproduct(),
        '/search': (context) => const Search(),
        '/': (context) => const SplashScreen(),
        '/signup': (context) => const SignupScreen(),
        '/signin': (context) => const SigninPage(),
        '/chat':
            (context) => BlocProvider<UserBloc>(
              create:
                  (context) =>
                      UserBloc(getCurrentUser: di.sl<GetCurrentUser>()),
              child: const ChatScreen(),
            ),
      },
    );
  }
}

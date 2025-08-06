import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_model.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> signUp(UserModel user);
  Future<UserModel> signIn(String email, String password);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;
  static const String baseUrl =
      'https://g5-flutter-learning-path-be-tvum.onrender.com';

  UserRemoteDatasourceImpl({required this.client});

  @override
  Future<UserModel> signUp(UserModel user) async {
    try {
      print(' Attempting signup to: $baseUrl/auth/register');
      print(' Request body: ${json.encode(user.toJson())}');

      final response = await client.post(
        Uri.parse('$baseUrl/api/v2/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      print(' Response status: ${response.statusCode}');
      print(' Response body: ${response.body}');
      print(' Response headers: ${response.headers}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userData = responseData['data'] ?? responseData;

        return UserModel(
        name: userData['name'],
        email: userData['email'],
        password: '');
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Sign up failed';
        throw Exception('Sign up failed: $errorMessage');
      }
    } on FormatException catch (e) {
      print('SocketException: $e');
      throw Exception('Network error: Unable to connect to server');
    } catch (e) {
      throw Exception('Network error during sign up: $e');
    }
  }




  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final userData = responseData['data'] ?? responseData;

        return UserModel.fromJson(userData);
      } else {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['message'] ?? 'Sign in failed';
        throw Exception('Sign in failed: $errorMessage');
      }
    } catch (e) {
      throw Exception('Network error during sign in: $e');
    }
  }
}

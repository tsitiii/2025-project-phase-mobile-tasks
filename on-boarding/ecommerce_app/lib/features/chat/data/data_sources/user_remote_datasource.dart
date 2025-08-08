import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  static const String baseUrl =
      'https://g5-flutter-learning-path-be-tvum.onrender.com';

  UserRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<UserModel> getCurrentUser() async {
    final accessToken = sharedPreferences.getString('AUTH_TOKEN');

    if (accessToken == null) {
      throw ServerException();
    }

    try {
      final response = await client.get(
        Uri.parse('$baseUrl/api/v2/users/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("user profile: $jsonResponse");
        final userData = jsonResponse['data'];
        print("user data: $userData");
        if (userData != null && userData is Map<String, dynamic>) {
          return UserModel.fromJson(userData);
        }
        return _getUserFromToken(accessToken);
      } else if (response.statusCode == 401) {
        throw ServerException();
      } else {
        return _getUserFromToken(accessToken);
      }
    } catch (e) {
      return _getUserFromToken(accessToken);
    }
  }

  UserModel _getUserFromToken(String token) {
    try {
      final parts = token.split('.');

      if (parts.length != 3) {
        throw const FormatException('Invalid JWT token format');
      }

      String payload = parts[1];

      switch (payload.length % 4) {
        case 1:
          payload += '===';
          break;
        case 2:
          payload += '==';
          break;
        case 3:
          payload += '=';
          break;
      }

      final decodedBytes = base64Url.decode(payload);
      final decodedPayload = utf8.decode(decodedBytes);
      final Map<String, dynamic> tokenData = json.decode(decodedPayload);

      final String userId = tokenData['sub'] ?? tokenData['id'] ?? '';
      final String email = tokenData['email'] ?? '';

      String name = tokenData['name'] ?? tokenData['username'] ?? '';
      if (name.isEmpty && email.isNotEmpty) {
        final emailParts = email.split('@');
        if (emailParts.isNotEmpty) {
          name = emailParts[0]
              .split('.')
              .map((part) {
                return part.isEmpty
                    ? ''
                    : part[0].toUpperCase() + part.substring(1).toLowerCase();
              })
              .join(' ');
        }
      }
      if (name.isEmpty) {
        name = 'User';
      }
      return UserModel(id: userId, name: name, email: email);
    } catch (e) {
      throw ServerException();
    }
  }
}

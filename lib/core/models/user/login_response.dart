import 'package:phonics/core/models/user/user_state.dart';

class LoginResponse {
  final String accessToken;
  final UserResponse userResponse;

  LoginResponse({
    required this.accessToken,
    required this.userResponse,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      userResponse: UserResponse.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'user': userResponse.toJson(),
    };
  }
}

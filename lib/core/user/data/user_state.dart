class UserResponse {
  final String userId;
  final String nickname;

  UserResponse({
    required this.userId,
    required this.nickname,
  });

  // JSON을 Dart 객체로 변환
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userId: json['user_id'],
      nickname: json['nickname'],
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'nickname': nickname,
    };
  }
}

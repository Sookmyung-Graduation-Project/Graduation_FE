class UserResponse {
  final String userId;
  final String nickname;
  final String profileImage;

  UserResponse({
    required this.userId,
    required this.nickname,
    required this.profileImage,
  });

  // JSON을 Dart 객체로 변환
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userId: json['user_id'],
      nickname: json['nickname'],
      profileImage:
          json['profile_image'] ?? '', // profile_image가 없을 경우 빈 문자열로 처리
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'nickname': nickname,
      'profile_image': profileImage,
    };
  }
}

//로그인 후, 필수 사용자 정보 저장하는 모델
class UserResponse {
  final String accessToken;
  final String userId;
  final String nickname;
  final String profileImage;

  UserResponse({
    required this.accessToken,
    required this.userId,
    required this.nickname,
    required this.profileImage,
  });

  // JSON을 Dart 객체로 변환
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      accessToken: json['access_token'] as String,
      userId: json['user_id'] as String,
      nickname: json['nickname'] as String,
      profileImage:
          json['profile_image'] ?? '', // profile_image가 없을 경우 빈 문자열로 처리
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'user_id': userId,
      'nickname': nickname,
      'profile_image': profileImage,
    };
  }
}

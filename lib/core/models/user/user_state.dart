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

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      accessToken: json['access_token'] as String,
      userId: json['user_id'] as String,
      nickname: json['nickname'] as String,
      profileImage: json['profile_image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'user_id': userId,
      'nickname': nickname,
      'profile_image': profileImage,
    };
  }
}

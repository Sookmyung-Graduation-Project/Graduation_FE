// User정보 조회를 위한 모델
class UserInfo {
  String id;
  String provider;
  String providerUserId;
  String nickname;
  String? profileImage;
  String userRole;
  int? childAge;
  String? defaultVoiceId;
  String? email;

  UserInfo({
    required this.id,
    required this.provider,
    required this.providerUserId,
    required this.nickname,
    this.profileImage,
    required this.userRole,
    this.childAge,
    this.defaultVoiceId,
    this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      provider: json['provider'] as String,
      providerUserId: json['provider_user_id'] as String,
      nickname: json['nickname'] as String,
      profileImage: json['profile_image'] as String?,
      userRole: json['user_role'] as String,
      childAge: json['child_age'] as int?,
      defaultVoiceId: json['default_voice_id'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider': provider,
      'provider_user_id': providerUserId,
      'nickname': nickname,
      'profile_image': profileImage,
      'user_role': userRole,
      'child_age': childAge,
      'default_voice_id': defaultVoiceId,
      'email': email,
    };
  }
}

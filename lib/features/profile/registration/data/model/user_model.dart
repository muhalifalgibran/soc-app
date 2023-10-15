import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

class UserModel extends SocUser {
  const UserModel({
    required String username,
    required String? picUrl,
    required String id,
    required String email,
    required List<String> followee,
    required List<String> following,
  }) : super(
          username: username,
          picUrl: picUrl,
          id: id,
          email: email,
          followee: followee,
          following: following,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      picUrl: json['pic_url'] ?? '',
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      followee: json['followee'] ?? [],
      following: json['following'] ?? [],
    );
  }
}

import 'package:soc_app/features/profile/registration/domain/entities/soc_user.dart';

class UserModel extends SocUser {
  final String username;
  final String? picUrl;
  final String id;
  final String email;
  final List<String> followee;
  final List<String> following;

  const UserModel({
    required this.username,
    required this.picUrl,
    required this.id,
    required this.email,
    required this.followee,
    required this.following,
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
      following: json['follower'] ?? [],
    );
  }
}

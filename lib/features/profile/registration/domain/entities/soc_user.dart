import 'package:equatable/equatable.dart';

class SocUser extends Equatable {
  final String username;
  final String? picUrl;
  final String id;
  final String email;
  final List<String> followee;
  final List<String> following;
  final List<String> posts;

  const SocUser({
    required this.username,
    required this.picUrl,
    required this.id,
    required this.email,
    required this.followee,
    required this.following,
    required this.posts,
  });

  @override
  List<Object?> get props => [
        username,
        picUrl,
        id,
        email,
        followee,
        posts,
        following,
      ];
}

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final String? picUrl;
  final List<String>? following;
  final List<String>? followers;

  bool get isLoggedIn => id != null;
  const UserData({
    this.id,
    this.username,
    this.email,
    this.password,
    this.picUrl,
    this.following,
    this.followers,
  });

  UserData clearData() => copyWith(
        id: null,
        username: null,
        email: null,
        password: null,
        picUrl: null,
        following: null,
        followers: null,
      );

  UserData copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? picUrl,
    List<String>? following,
    List<String>? followers,
  }) =>
      UserData(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        picUrl: picUrl ?? this.picUrl,
        following: following ?? this.following,
        followers: followers ?? this.followers,
      );

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        password,
        picUrl,
        following,
        followers,
      ];
}

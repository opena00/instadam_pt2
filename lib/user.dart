import 'package:instadam_pt2/posts.dart';

class User {
  String email;
  String userName;
  String password;
  List<Post> posts;

  User({
    required this.email,
    required this.userName,
    required this.password,
    required this.posts,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userName': userName,
      'password': password,
      'posts': posts.map((post) => post.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        userName: json['userName'],
        password: json['password'],
        posts: List<Post>.from(json['posts'].map((post) => Post.fromJson(post)),
    ));
  }
}

class UserList {
  List<User> users;

  UserList({required this.users});

  Map<String, dynamic> toJson() {
    return {
      'users': users.map((user) => user.toJson()).toList(),
    };
  }

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
        users: List<User>.from(json['users'].map((user) => User.fromJson(user)),
    ));
  }
}
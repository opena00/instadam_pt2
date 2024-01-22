import 'package:flutter/material.dart';
import 'package:instadam_pt2/main.dart';

// post.dart
class Post {
  String username;
  ImageProvider<Object> image;
  String caption;

  Post({required this.username, required this.image, required this.caption});
}

class Comment {
  String text;

  Comment({required this.text});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      text: json['text'],
    );
  }
}

class Post {
  int likes;
  String imageURL;
  List<Comment> comments;

  Post({
    required this.likes,
    required this.imageURL,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'likes': likes,
      'imageURL': imageURL,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      likes: json['likes'],
      imageURL: json['imageURL'],
      comments: List<Comment>.from(json['comments'].map((comment) => Comment.fromJson(comment))),
    );
  }
}
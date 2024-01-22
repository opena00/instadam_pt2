// post_card.dart
import 'package:flutter/material.dart';
import 'package:instadam_pt2/Posting.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Comment {
  String username;
  String text;

  Comment({required this.username, required this.text});
}

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool showComments = false;
  List<Comment> comments = [];

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(widget.post.username),
          ),
          Image(image: widget.post.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.caption),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  setState(() {
                    showComments = !showComments;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  // Acción al tocar el botón de compartir
                },
              ),
            ],
          ),
          if (showComments)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Comentarios:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                for (Comment comment in comments)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListTile(
                      title: Text(comment.username),
                      subtitle: Text(comment.text),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Escribe tu comentario...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          // Agrega el comentario a la lista de comentarios
                          setState(() {
                            comments.add(Comment(
                              username: 'opena00', // Puedes cambiar esto según el usuario actual
                              text: commentController.text, // Usa el texto del TextField
                            ));
                            commentController.clear(); // Limpia el TextField después de enviar el comentario
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

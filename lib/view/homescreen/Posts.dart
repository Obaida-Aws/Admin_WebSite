import 'package:flutter/material.dart';

class PostsContent extends StatefulWidget {
  @override
  _PostsContentState createState() => _PostsContentState();
}

class _PostsContentState extends State<PostsContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Posts Content',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

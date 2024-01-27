import 'package:flutter/material.dart';

class CommentsContent extends StatefulWidget {
  @override
  _CommentsContentState createState() => _CommentsContentState();
}

class _CommentsContentState extends State<CommentsContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Comments Content',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

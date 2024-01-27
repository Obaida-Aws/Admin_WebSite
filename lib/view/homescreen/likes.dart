import 'package:flutter/material.dart';

class LikesContent extends StatefulWidget {
  @override
  _LikesContentState createState() => _LikesContentState();
}

class _LikesContentState extends State<LikesContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Likes Content',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

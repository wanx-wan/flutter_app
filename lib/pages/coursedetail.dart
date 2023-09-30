import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  final dynamic course;

  CourseDetail({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course ${course['title']}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/classroom.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text('Description: ${course['description']}'),
        ),
      ),
    );
  }
}

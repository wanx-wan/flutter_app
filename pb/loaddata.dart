import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:ubuapp/mockup/data.dart';
import 'package:ubuapp/pages/coursedetail.dart';

void main() async {
  final pb = PocketBase('http://127.0.0.1:8090');

  try {
    await pb.admins.authWithPassword('wancharoen.up.63@ubu.ac.th', 'adminubu1234');

    final courseData = List.generate(100, (index) => randomCourse());

    for (final course in courseData) {
      final record = await pb.collection('COURSES').create(body: {
        "course_id": course[0],
        "title": course[1],
        "lecturer": course[2],
      });

      runApp(MaterialApp(
        home: CourseDetail(course: record),
      ));
    }
  } catch (e) {
    print('Error: $e');
  }
}

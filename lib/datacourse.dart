import 'package:flutter/material.dart';
import 'dart:math';
import 'package:pocketbase/pocketbase.dart';

const COURSES = [[1145206, 'Image Analytics'], [1145208, 'Deep Learning']];
const LECTURERS = ['Wayo Puyati', 'Wichit Sombat'];
final random = Random();

class CourseCard extends StatelessWidget {
  final List<dynamic> course;
  CourseCard({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.grey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${course[1]}'),
          Text('${course[0]}\n'),
          Text('${course[2]}'),
        ],
      ),
    );
  }
}

List<dynamic> randomCourse() {
  return [...COURSES[random.nextInt(COURSES.length)], LECTURERS[random.nextInt(LECTURERS.length)]];
}

Future<void> loaddata() async {
  final pb = PocketBase('http://127.0.0.1:8090');
  try {
    await pb.admins.authWithPassword('wancharoen.up.63@ubu.ac.th', 'adminubu1234');
    for (int i = 0; i < 100; i++) {
      final course = randomCourse();
      final body = {"courseid": course[0], "name": course[1], "lecturer": course[2]};
      final record = await pb.collection('COURSES').create(body: body);
      print('Created course: $record');
    }
  } catch (e) {
    print('Error: $e');
  }
}

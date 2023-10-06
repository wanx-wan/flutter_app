import 'package:flutter/material.dart';
import 'dart:math';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://127.0.0.1:8090');

const COURSES = [
  [1145206, 'Image Analytics'],
  [1145208, 'Deep Learning']
];
const LECTURERS = ['Wayo Puyati', 'Wichit Sombat'];

final random = Random();

final emails = "wancharoen.up.63@ubu.ac.th", passwords = "adminubu1234";

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController(),
      passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final email = emailController.text, password = passwordController.text;

    if (email == emails && password == passwords ) {
      try {
        if (await pb.admins.authWithPassword(email, password) != null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(controller: emailController),
              TextFormField(controller: passwordController, obscureText: true),
              ElevatedButton(
                  onPressed: () => _login(context), child: Text('Submit')),
            ],
          ),
        ),
      );
}

class CourseCard extends StatelessWidget {
  final List<dynamic> course;
  CourseCard({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
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

List<dynamic> randomCourse() => [
      ...COURSES[random.nextInt(COURSES.length)],
      LECTURERS[random.nextInt(LECTURERS.length)]
    ];

Future<void> loaddata() async {
  try {
    await pb.admins
        .authWithPassword(emails, passwords);
    for (int i = 0; i < 100; i++) {
      final courseData = randomCourse();
      final record = await pb.collection('COURSES').create(body: {
        "courseid": courseData[0],
        "name": courseData[1],
        "lecturer": courseData[2]
      });
      print(record);
    }
  } catch (e) {
    print(e);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final courses = <dynamic>[];

  void _add() => setState(() => courses.add(randomCourse()));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          actions: [
            IconButton(
              icon: const Icon(Icons.login_outlined),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LoginPage())),
            ),
          ],
        ),
        body: Center(
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (BuildContext context, int index) =>
                CourseCard(course: courses[index]),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(onPressed: _add, child: const Icon(Icons.add)),
            IconButton(icon: Icon(Icons.input), onPressed: loaddata),
          ],
        ),
      );
}

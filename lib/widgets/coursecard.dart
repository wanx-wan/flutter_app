import 'package:flutter/material.dart';

class coursecard extends StatelessWidget {
  final dynamic course;

  const coursecard({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 233, 233, 233),
            offset: Offset(2, 4),
            blurRadius: 30,
          )
        ],
        image: DecorationImage(
            image: AssetImage('assets/image/img_learnlanguage.jpg'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${course[1]}',
              style: TextStyle(
                fontSize: 20,
              )),
          Text('${course[0]}\n', style: TextStyle(fontSize: 12)),
          Text('${course[2]}', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

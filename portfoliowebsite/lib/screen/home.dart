import 'package:flutter/material.dart';
import 'package:portfoliowebsite/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: backgroundColor,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: firstRow(),
            )
          ],
        ),
      ),
    );
  }

  Row firstRow() {
    return Row(
      children: [
        const CircleAvatar(
          minRadius: 50,
          maxRadius: 150,
          backgroundImage: AssetImage('asset/photo.jpeg'),
        ),
        const SizedBox(
          width: 100,
        ),
        Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 350.00),
              child: const Text(
                'Software Engineer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const Text(
              'Kaustubh Vaidya',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Hi! I am a software engineer, I do app development in Flutter framework.\nI have knowledge of Firebase and TensorFlow as well.',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20
              ),
            )
          ],
        )
      ],
    );
  }
}

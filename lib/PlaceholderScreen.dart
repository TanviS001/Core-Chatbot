import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161A30),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb,
              color: Color(0xffabaeb5),
              size: 200,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'What\'s on your mind?',
              style: TextStyle(
                  color: Color(0xffabaeb5),
                fontSize: 25
              ),
            )
          ],
        ),
      )
    );
  }
}

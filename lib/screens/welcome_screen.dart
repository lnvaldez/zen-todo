import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Align(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              'assets/zen_logo.svg',
              height: 120,
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(255, 135, 184, 136), BlendMode.srcIn),
            ),
            const SizedBox(height: 48),
            SizedBox(
                width: 250,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 135, 184, 136))),
                  onPressed: () => Navigator.pushNamed(context, '/tasks'),
                  child: const Text(
                    'View Tasks',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 135, 184, 136))),
                onPressed: () => Navigator.pushNamed(context, '/quotes'),
                child: const Text(
                  'Daily Quotes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ])),
    )));
  }
}

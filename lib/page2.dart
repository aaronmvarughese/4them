// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class getstarted extends StatelessWidget {
  const getstarted({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4Them'),
          centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Lets Train the AI with your voice..',
            style: TextStyle(fontSize: 20),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/voicetrain');
            },
          )
        ],
      )),
    );
  }
}
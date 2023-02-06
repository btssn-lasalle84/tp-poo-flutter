import 'package:flutter/material.dart';

void main() {
  runApp(new HelloWorld());
}

class HelloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HelloWorld',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Accueil'),
        ),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

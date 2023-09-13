import 'package:flutter/material.dart';
import 'package:working_with_api/screen/file_upload_screen.dart';
import 'package:working_with_api/screen/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'API',
      home: FileUpload(),
    );
  }
}

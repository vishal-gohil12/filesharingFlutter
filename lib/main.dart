import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Plus"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Share eclectic University with your friends:',
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: sharePressed,
              icon: const Icon(Icons.share, color: Colors.redAccent),
            ),
            Image.asset(
              "assets/images/images.jpg",
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sharePressed() async {
    try {
      final ByteData bytes =
      await rootBundle.load('assets/images/images.jpg');
      final Uint8List uint8List = bytes.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/image.jpg');
      await tempFile.writeAsBytes(uint8List);
      await Share.shareFiles([tempFile.path]);
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing: $e');
      }
    }
  }
}

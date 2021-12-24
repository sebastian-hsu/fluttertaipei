import 'dart:convert';
import 'dart:io';
import 'package:universal_html/html.dart' as html;

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class PrintCard extends StatefulWidget {
  static String routeName = '/print_card';
  const PrintCard({Key? key}) : super(key: key);

  @override
  _PrintCard createState() => _PrintCard();
}

class _PrintCard extends State<PrintCard> {
  GlobalKey globalKey = GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();
  String userName = 'Your Name';

  late Directory appDocDir;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Taipei Badge Generator'),
      ),
      body: Column(
        children: [
          Center(
            child: Screenshot(
              controller: screenshotController,
              child: SizedBox(
                width: 1000,
                height: 500,
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Image(
                          image: AssetImage('images/flutter-taipei.jpeg')),
                    ),
                    Container(
                      alignment: const Alignment(-0.7, 0.8),
                      child: Text(userName,
                          textScaleFactor: 8,
                          style: const TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: TextField(
                decoration: const InputDecoration(labelText: 'Input Your Name'),
                // controller: amountController,
                onChanged: (String value) async {
                  userName = value;
                  setState(() {});
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                screenshotController.capture().then((image) {
                  // ref: https://stackoverflow.com/a/67016194/4964620
                  final base64data = base64Encode(image!);

                  final a = html.AnchorElement(
                      href: 'data:image/jpeg;base64,$base64data');

                  a.download = 'flutter-taipei-$userName.jpg';

                  a.click();
                  a.remove();
                }).catchError((onError) {
                  // print(onError);
                });
              },
              child: const Text('Download Image'))
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DownloadScreen extends StatefulWidget {
  final String downloadLink;

  DownloadScreen({required this.downloadLink});

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  double _progress = 0.0;

  Future<void> _startDownload() async {
    final response = await http.get(Uri.parse(widget.downloadLink));

    // Check if the response is a redirect
    if (response.statusCode == 302) {
      final redirectUrl = response.headers['location'];

      // Make a GET request to the redirect URL
      final redirectResponse = await http.get(Uri.parse(redirectUrl!),
         );

      // Save the APK file to the device's Downloads directory
      final file = File('/storage/emulated/0/Download/app.apk');
      await file.writeAsBytes(redirectResponse.bodyBytes);

      setState(() {
        _progress = 1.0;
      });

      print('File downloaded successfully!');
    } else {
      print('Error: Failed to download file.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download APK'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: _progress,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startDownload,
              child: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
}

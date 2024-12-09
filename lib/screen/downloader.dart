// import 'dart:isolate';
// import 'dart:ui';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled/screen/splashscreen.dart';
//
// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await FlutterDownloader.initialize(
// //       debug: true,
// //       ignoreSsl: true ,
// //   );
// // }
// class downloader extends StatefulWidget {
//   final String url;
//   const downloader({Key? key,required this.url}) : super(key: key);
//
//   @override
//   State<downloader> createState() => _downloaderState();
// }
//
// class _downloaderState extends State<downloader> {
//   //Future Str
//   Future DownloadApp(String link)async{
//     var status = await Permission.storage.request();
//     final basestorage= await getExternalStorageDirectory();
//     if (status.isGranted) {
//       await FlutterDownloader.enqueue(
//         url: link,
//         savedDir: basestorage!.path,
//         showNotification: true, // show download progress in status bar (for Android)
//         openFileFromNotification: true,
//       );
//
//     }
//     }
//   ReceivePort _port = ReceivePort();
//   @override
//   void initState() {
//     IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
//     _port.listen((dynamic data) {
//       String id = data[0];
//       DownloadTaskStatus status = data[1];
//       int progress = data[2];
//       if(status==DownloadTaskStatus.complete){
//         splashservices().toastmessage('Download Completed');
//       }
//       setState((){ });
//     });
//     FlutterDownloader.registerCallback(downloadCallback);
//     super.initState();
//   }
//   @override
//   void dispose() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//     super.dispose();
//   }
//
//   @pragma('vm:entry-point')
//   static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
//     final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
//     send!.send([id, status, progress]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//           child: ElevatedButton(
//             onPressed:  (){
//               DownloadApp(widget.url);
//             },
//             child: Text('Download'),
//           ),
//         ),
//     );
//   }
// }

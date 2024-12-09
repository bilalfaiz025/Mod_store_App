// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled/screen/description.dart';
// class detailscreen extends StatefulWidget {
//   final String category;
//   const detailscreen({Key? key,required this.category}) : super(key: key);
//
//   @override
//   State<detailscreen> createState() => _detailscreenState();
// }
//
// class _detailscreenState extends State<detailscreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: 780,
//         width: double.infinity,
//         color: Colors.white,
//         child: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('apks/').where('categories',isEqualTo: '$widget.c').snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//               ),
//               itemCount: snapshot.data?.docs.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot document = snapshot.data!.docs[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               ProductDetailScreen(product:  snapshot.data!.docs[index]),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.greenAccent[100],
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 1,
//                           ),
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: NetworkImage(document['image']),
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

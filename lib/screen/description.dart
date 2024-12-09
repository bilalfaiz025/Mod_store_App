import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:untitled/screen/splashscreen.dart';

class ProductDetailScreen extends StatefulWidget {
  final DocumentSnapshot product;
  ProductDetailScreen({required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<void> checkPermission() async {
    final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      // Permission granted.
    } else {
      // Permission not granted.
    }
  }

  int progress = 0;

  void downloadApp() async {
    int? id = await RUpgrade.upgrade(
      widget.product.get('apk'),
      fileName: widget.product.get('Name')+'.apk',
      installType: RUpgradeInstallType.normal,
    ).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage('${widget.product.get('image')}'),
                      fit: BoxFit.cover,
                    ),
                    //color: Colors.greenAccent[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 20.0),
              // Text(
              //   'Discription',
              //   style: TextStyle(fontSize: 18.0),
              // ),
              SizedBox(height: 5.0),
              Container(
                height: 40,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white60.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.product.get('Name')}',
                              style: GoogleFonts.paytoneOne(
                                  fontSize: 20, color: Colors.black45)),
                        ],
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                height: 435,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white60.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.0),
                          Text('Description',style: GoogleFonts.alatsi(),),
                          SizedBox(height: 5.0),
                          Text(
                            '${widget.product.get('Description')}',
                            style: GoogleFonts.spectral(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.0),
                          Text(
                            'Category',
                            style: GoogleFonts.alatsi(),
                          ),
                          Text(
                            '${widget.product.get('categories')}',
                            style: GoogleFonts.spectral(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              StreamBuilder(
                stream: RUpgrade.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<DownloadInfo> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      '${(snapshot.data!.percent!).toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 30),
                    );
                  } else {
                    return SizedBox(
                      width: 60,
                      height: 10,
                      child: Icon(Icons.download),
                    );
                  }
                },
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {
                  downloadApp();
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>downloader(url: widget.product.get('apk'))));
                },
                child: Text(
                  'Download Now',
                  style: GoogleFonts.righteous(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
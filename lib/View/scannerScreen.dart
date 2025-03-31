import 'dart:convert';

import 'package:convo/Model/businessCard_model.dart';
import 'package:convo/View/Widget/BusinessCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class scannerScreen extends StatefulWidget {
  @override
  State<scannerScreen> createState() => _scannerScreenState();
}

class _scannerScreenState extends State<scannerScreen> {
  final GlobalKey _qrKey = GlobalKey();
  String _scannedString = "";
  bool _isPermissionGranted = false;
  late BusinessCardModel _sharedBusinessCard = BusinessCardModel(
    name: "Name",
    position: "Position",
    imagePath: "assets/5.jpg",
    contactInfo: [
      BusinessInfo(info: "LinkedIn Account", icon: FontAwesomeIcons.linkedin),
    ],
  );

  Future<void> _requestPermission() async {
    var status = await Permission.camera.request();
    setState(() {
      if (status.isGranted) {
        _isPermissionGranted = true;
        _scannedString = "";
      } else {
        _isPermissionGranted = false;
        _scannedString =
            "Camera permission denied! Please enable it in settings.";
      }
    });
  }

  @override
  void initState() {
    _requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            (_scannedString.isEmpty) ? Text("Scan Qr") : Text("Scanned Card"),
        centerTitle: true,
      ),
      body:
          (_scannedString.isEmpty && _isPermissionGranted)
              ? QRView(
                key: _qrKey,
                onQRViewCreated: (QRViewController controller) {
                  controller.scannedDataStream.listen((scanData) {
                    setState(() {
                      _scannedString = scanData.code!;
                      Map<String, dynamic> jsonData = jsonDecode(
                        _scannedString,
                      );
                      _sharedBusinessCard = BusinessCardModel.fromJson(
                        jsonData,
                      );
                    });
                  });
                },
              )
              : Center(
                child: businessCard(
                  name: _sharedBusinessCard.name,
                  position: _sharedBusinessCard.position,
                  icons:
                      _sharedBusinessCard.contactInfo
                          .map((element) => element.icon)
                          .toList(),
                  info:
                      _sharedBusinessCard.contactInfo
                          .map((element) => element.info)
                          .toList(),
                  image: _sharedBusinessCard.imagePath,
                ),
              ),
    );
  }
}

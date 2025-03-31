import 'dart:convert';
import 'package:convo/Model/businessCard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class shareScreen extends StatelessWidget {
  const shareScreen({super.key, required this.businessCard});

  final BusinessCardModel businessCard;

  String _generateQr() {
    Map<String, dynamic> jsonData = businessCard.toJson();
    return jsonEncode(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share your BusinessCard"), centerTitle: true),
      body: Center(
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 500),
          tween: Tween(begin: 0.0, end: 1.0),
          builder:
              (context, value, child) => Opacity(
                opacity: value,
                child: QrImageView(
                  data: _generateQr(),
                  version: QrVersions.auto,
                  size: 250.sp,
                ),
              ),
        ),
      ),
    );
  }
}

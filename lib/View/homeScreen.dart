import 'dart:math' as math;
import 'package:convo/Controller/offlineSave.dart';
import 'package:convo/View/scannerScreen.dart';
import 'package:convo/View/sharedScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:convo/Model/businessCard_model.dart';
import 'package:convo/View/Widget/BusinessCard.dart';
import 'package:convo/View/modScreen.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  BusinessCardModel _myBusinessCard = BusinessCardModel(
    name: "Name",
    position: "Position",
    imagePath: "assets/5.jpg",
    contactInfo: [
      BusinessInfo(info: "LinkedIn Account", icon: FontAwesomeIcons.linkedin),
    ],
  );

  @override
  void initState() {
    super.initState();
    _loadstoreBusinessCard();
  }

  Future<void> _loadstoreBusinessCard() async {
    var data = await OfflineStorage().loadJson("My");
    if (data != null) _myBusinessCard = BusinessCardModel.fromJson(data);
    setState(() {});
  }

  Future<void> _navigateToModScreen(BuildContext context) async {
    final userModResult = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => modScreen(businessCardData: _myBusinessCard),
      ),
    );
    if (userModResult != null) {
      setState(() => _myBusinessCard = userModResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'share') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => shareScreen(businessCard: _myBusinessCard),
                  ),
                );
              } else if (value == 'scan') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => scannerScreen()),
                );
              } else if (value == 'modify') {
                _navigateToModScreen(context);
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'share',
                    child: Row(
                      spacing: 10.w,
                      children: [Icon(Icons.share), Text('Share')],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'scan',
                    child: Row(
                      spacing: 10.w,
                      children: [Icon(FontAwesomeIcons.expand), Text('Scan')],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'modify',
                    child: Row(
                      spacing: 10.w,
                      children: [Icon(Icons.mode), Text('modify')],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: TweenAnimationBuilder(
        duration: const Duration(seconds: 1),
        tween: Tween(begin: 2.0, end: 0.0),
        curve: Curves.fastOutSlowIn,
        builder: (BuildContext context, dynamic value, Widget? child) {
          return Align(
            alignment: Alignment(0, value),
            child: Transform.rotate(
              angle: math.pi / 2,
              child: businessCard(
                name: _myBusinessCard.name,
                position: _myBusinessCard.position,
                icons:
                    _myBusinessCard.contactInfo
                        .map((infoElement) => infoElement.icon)
                        .toList(),
                info:
                    _myBusinessCard.contactInfo
                        .map((infoElement) => infoElement.info)
                        .toList(),
                image: _myBusinessCard.imagePath,
              ),
            ),
          );
        },
      ),
    );
  }
}

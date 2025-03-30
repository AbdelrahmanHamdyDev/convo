import 'dart:math' as math;
import 'package:convo/Controller/offlineSave.dart';
import 'package:flutter/material.dart';
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
    final userModResult = await Navigator.of(context).push<BusinessCardModel>(
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
        leading: IconButton(
          onPressed: () => _navigateToModScreen(context),
          icon: const Icon(Icons.mode),
        ),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: Center(
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
      ),
    );
  }
}

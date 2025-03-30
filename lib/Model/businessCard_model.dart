import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Map<String, IconData> iconMap = {
  'FontAwesomeIcons.phone': FontAwesomeIcons.phone,
  'FontAwesomeIcons.github': FontAwesomeIcons.github,
  'FontAwesomeIcons.linkedin': FontAwesomeIcons.linkedin,
  'FontAwesomeIcons.globe': FontAwesomeIcons.globe,
  'FontAwesomeIcons.locationDot': FontAwesomeIcons.locationDot,
};

class BusinessCardModel {
  final String name;
  final String position;
  final String imagePath;
  final List<BusinessInfo> contactInfo;

  BusinessCardModel({
    required this.name,
    required this.position,
    required this.imagePath,
    required this.contactInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'imagePath': imagePath,
      'contactInfo': contactInfo.map((info) => info.toJson()).toList(),
    };
  }

  factory BusinessCardModel.fromJson(Map<String, dynamic> json) {
    return BusinessCardModel(
      name: json['name'],
      position: json['position'],
      imagePath: json['imagePath'],
      contactInfo:
          (json['contactInfo'] as List)
              .map((item) => BusinessInfo.fromJson(item))
              .toList(),
    );
  }
}

class BusinessInfo {
  final String info;
  final IconData icon;

  BusinessInfo({required this.info, required this.icon});

  Map<String, dynamic> toJson() {
    return {
      'info': info,
      'icon': iconMap.keys.firstWhere((key) => iconMap[key] == icon),
    };
  }

  factory BusinessInfo.fromJson(Map<String, dynamic> json) {
    var iconString = json['icon'];
    var icon = iconMap[iconString] ?? FontAwesomeIcons.phone;

    return BusinessInfo(info: json['info'], icon: icon);
  }
}

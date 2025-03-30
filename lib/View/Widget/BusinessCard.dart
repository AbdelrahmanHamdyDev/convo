import 'package:flutter/material.dart';

class businessCard extends StatelessWidget {
  const businessCard({
    super.key,
    required this.name,
    required this.position,
    required this.icons,
    required this.info,
    required this.image,
  });

  final String name;
  final String position;
  final List<IconData> icons;
  final List<String> info;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(20, 20),
              blurRadius: 15,
            ),
          ],
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage(image)),
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name, style: TextStyle(fontSize: 32)),
            Text(position, style: TextStyle(fontSize: 20)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: info.length,
                  itemBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          spacing: 10,
                          children: [Icon(icons[index]), Text(info[index])],
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

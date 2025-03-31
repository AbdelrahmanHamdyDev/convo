import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      aspectRatio: (3 / 2),
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
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name, style: TextStyle(fontSize: 25.sp), maxLines: 1),
            Text(position, style: TextStyle(fontSize: 18.sp)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: info.length,
                  itemBuilder:
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          spacing: 10.w,
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

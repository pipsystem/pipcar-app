// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pipcar/common/themes/themes.dart';

class CustomMarker extends StatelessWidget {
  final String name;
  const CustomMarker({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Align(
            alignment: Alignment.bottomCenter,
            child: Icon(
              Icons.arrow_drop_down,
              color: AppColor.primaryColor,
              size: 35,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: AppColor.primaryColor, width: 2),
                shape: BoxShape.circle),
            child: Center(
              child: Text(
                name,
                style: ThemeText.note.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}

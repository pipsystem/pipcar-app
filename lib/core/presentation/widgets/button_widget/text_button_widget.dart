import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/themes/themes.dart';

enum ButtonState { active, inactive }

class TextButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Color? buttonColor;
  final Color? titleColor;
  final Color? borderColor;
  final String title;
  final double? width;
  final double? height;
  final ButtonState? buttonState;
  final bool? isLoading;
  final ImageAppWidget? image;
  const TextButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    this.buttonState = ButtonState.active,
    this.buttonColor,
    this.titleColor,
    this.borderColor,
    this.height,
    this.width,
    this.isLoading = false,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isLoading != true ? onPressed : null,
        style: TextButton.styleFrom(
          backgroundColor: buttonState == ButtonState.active ? buttonColor ?? AppColor.white : AppColor.iron,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.transparent, //borderColor ?? AppColor.white, // your color here
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.borderButton),
            ),
          ),
          maximumSize: Size(double.infinity, AppDimens.buttonSize),
          minimumSize: Size(width ?? MediaQuery.of(context).size.width, height ?? AppDimens.buttonSize),
          shadowColor: AppColor.grey,
          elevation: 0,
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image.paddingRight(AppDimens.paddingVerySmall) ?? const SizedBox(),
                Align(
                child: Text(
                  title.toUpperCase(),
                  style: ThemeText.button.copyWith(color: titleColor ?? AppColor.primaryColor),
                ),
              ),
              ],),
              isLoading == true
                  ? const Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: AppColor.white,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ));
  }
}

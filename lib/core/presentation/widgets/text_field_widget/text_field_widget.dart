// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/themes/themes.dart';
import '../widgets.dart';
import 'text_field_constants.dart';

class TextFieldWidget extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? initValue;
  final Color? color;
  final double? height;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? Function(String?)? validate;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign? textAlign;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final bool? isSecure;
  final bool? readOnly;
  final bool? enabled;
  final Color? borderColor;
  final Color? fillColor;
  final BorderRadius? radius;
  final bool? autoFocus;
  final TextStyle? hintStyle;
  final int? maxLines;

  const TextFieldWidget({
    Key? key,
    this.enabled,
    this.labelText,
    this.hintText,
    this.initValue,
    this.color,
    this.height,
    this.radius,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.validate,
    this.onSaved,
    this.onEditingComplete,
    this.onTap,
    this.autovalidateMode,
    this.inputFormatter,
    this.textAlign,
    this.textCapitalization,
    this.keyboardType,
    this.isSecure,
    this.readOnly,
    this.fillColor,
    this.autoFocus,
    this.borderColor,
    this.maxLines,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isShowSecure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly ?? false,
      enabled: widget.enabled,
      controller: widget.controller,
      initialValue: widget.initValue,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      textAlign: widget.textAlign ?? TextAlign.start,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      obscureText:
          widget.isSecure == null ? false : isShowSecure != widget.isSecure,
      showCursor: true,
      style: widget.textStyle ??
          ThemeText.caption.copyWith(
              color: AppColor.tuna,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp),
      onSaved: widget.onSaved,
      validator: widget.validate,
      maxLines: widget.maxLines ?? 1,
      autofocus: widget.autoFocus ?? false,
      autovalidateMode:
          widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
      inputFormatters: widget.inputFormatter,
      keyboardType: widget.keyboardType,
      scrollPadding: EdgeInsets.symmetric(vertical: 9.h),
      cursorColor: widget.borderColor ?? Colors.white,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: TextFieldConstants.contentPaddingHorizontal,
          vertical: TextFieldConstants.contentPaddingVertical,
        ),
        labelText: widget.labelText,
        labelStyle: widget.textStyle ??
            ThemeText.caption.copyWith(
                color: AppColor.tuna,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp),
        hintText: widget.hintText,
        errorStyle:
            ThemeText.style12Regular.copyWith(color: AppColor.validateErr),
        hintStyle: widget.hintStyle ??
            widget.textStyle ??
            ThemeText.style12Regular.copyWith(color: AppColor.white),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ??
            Visibility(
                visible: widget.isSecure == true,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Icon(
                    !isShowSecure
                        ? Icons.remove_red_eye_sharp
                        : CupertinoIcons.eye_slash_fill,
                    color: const Color(0xffffffff),
                  ),
                  onPressed: () {
                    setState(() {
                      isShowSecure = !isShowSecure;
                    });
                  },
                )),
        fillColor: widget.fillColor ?? AppColor.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ?? AppColor.borderFieldColor,
              width: 0.5),
          borderRadius: widget.radius ??
              BorderRadius.all(
                Radius.circular(AppDimens.borderTextField),
              ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ?? AppColor.borderFieldColor,
              width: 0.5),
          borderRadius: widget.radius ??
              BorderRadius.all(
                Radius.circular(AppDimens.borderTextField),
              ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.validateErr),
          borderRadius: widget.radius ??
              BorderRadius.all(
                Radius.circular(AppDimens.borderTextField),
              ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ?? AppColor.borderFieldColor,
              width: 0.5),
          borderRadius: widget.radius ??
              BorderRadius.all(
                Radius.circular(AppDimens.borderTextField),
              ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ?? AppColor.borderFieldColor,
              width: 0.5),
          borderRadius: widget.radius ??
              BorderRadius.all(
                Radius.circular(AppDimens.borderTextField),
              ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.borderColor ?? AppColor.borderFieldColor,
              width: 0.5),
          borderRadius: widget.radius ??
              BorderRadius.all(
                Radius.circular(AppDimens.borderTextField),
              ),
        ),
      ),
    );
  }
}

class TextFieldPickUpTime extends StatelessWidget {
  final Function(DateTime)? onConfirm;
  final TextEditingController controller;
  const TextFieldPickUpTime({
    Key? key,
    this.onConfirm,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: "Thời gian đón",
          style: ThemeText.body2,
        ).paddingBottom(6.h),
        TextFieldWidget(
          onTap: () {
            DateTime now = DateTime.now();
            DateTime minTime = now.add(const Duration(minutes: 10));
            DateTime maxTime = now.add(const Duration(days: 30));
            DatePicker.showDateTimePicker(
              context,
              showTitleActions: true,
              minTime: minTime,
              maxTime: maxTime,
              onConfirm: onConfirm,
              currentTime: minTime,
              locale: LocaleType.vi,
            );
          },
          validate: (value) {
            if (value == null || value.isEmpty) {
              return "Không được để trống thời gian";
            }
            return null;
          },
          controller: controller,
          borderColor: AppColor.borderCard,
          hintText: "Chọn thời gian đón",
          hintStyle: ThemeText.note.copyWith(color: AppColor.hintColor),
          textStyle:
              ThemeText.style12Regular.copyWith(fontWeight: FontType.regular),
          readOnly: true,
          prefixIcon: Icon(
            Icons.access_time_rounded,
            size: AppDimens.iconMediumSize,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    ).paddingBottom(10.h);
  }
}

class TextFieldPickUpTime2 extends StatelessWidget {
  final Function(DateTime)? onConfirm;
  final TextEditingController controller;
  const TextFieldPickUpTime2({
    Key? key,
    this.onConfirm,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: "Thời gian đón khách",
          style: ThemeText.body2,
        ).paddingBottom(6.h),
        TextFieldWidget(
          onTap: () {
            DateTime now = DateTime.now();
            DateTime minTime = now.add(const Duration(minutes: 10));
            DateTime maxTime = now.add(const Duration(days: 30));
            DatePicker.showDateTimePicker(
              context,
              showTitleActions: true,
              minTime: minTime,
              maxTime: maxTime,
              onConfirm: onConfirm,
              currentTime: minTime,
              locale: LocaleType.vi,
            );
          },
          validate: (value) {
            if (value == null || value.isEmpty) {
              return "Không được để trống thời gian";
            }
            return null;
          },
          controller: controller,
          borderColor: AppColor.borderCard,
          hintText: "Chọn thời gian đón",
          hintStyle: ThemeText.note.copyWith(color: AppColor.hintColor),
          textStyle:
              ThemeText.style12Regular.copyWith(fontWeight: FontType.regular),
          readOnly: true,
          prefixIcon: Icon(
            Icons.access_time_rounded,
            size: AppDimens.iconMediumSize,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    ).paddingBottom(10.h);
  }
}
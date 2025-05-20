import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/configs/constants/string_constants.dart';
import '../../../../common/themes/themes.dart';
import '../../../../common/utils/utils_src.dart';
import '../text_field_widget/text_field_constants.dart';
import '../widgets.dart';

class DropDownSelectCustome<T> extends StatelessWidget {
  final Function(T?)? onChanged;
  final Function()? onTap;
  final String lable;
  final String hintText;
  final List<T> items;
  final T? value;
  final List<DropdownMenuItem<T>>? childs;

  final String? Function(T?)? validate;
  final bool? isRequired;
  const DropDownSelectCustome({
    Key? key,
    this.onChanged,
    this.onTap,
    required this.lable,
    required this.hintText,
    required this.items,
    this.value,
    this.validate,
    this.isRequired,
    this.childs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderDefault = OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: AppColor.hintColor),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimens.borderTextField),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: lable,
          style: ThemeText.body2,
        ).paddingBottom(AppDimens.paddingSmall),
        DropdownButtonFormField<T>(
          value: value,
          onTap: onTap,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: AppColor.primaryColor),
          elevation: 2,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validate ??
              (value) {
                return isRequired == true
                    ? isNullEmpty(value)
                        ? "${StringConstants.requiredThisField} $lable"
                        : null
                    : null;
              },
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.filter_list_sharp,
              color: AppColor.primaryColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimens.paddingSmall,
              vertical: TextFieldConstants.contentPaddingVertical,
            ),
            filled: true,
            fillColor: AppColor.white,
            enabledBorder: borderDefault,
            focusedBorder: borderDefault,
            errorBorder: borderDefault.copyWith(
                borderSide: BorderSide(color: AppColor.validateErr)),
            errorStyle:
                ThemeText.style12Regular.copyWith(color: AppColor.validateErr),
            focusedErrorBorder: borderDefault,
            disabledBorder: borderDefault,
            border: borderDefault,
          ),
          dropdownColor: AppColor.lightBlue,
          borderRadius: BorderRadius.circular(AppDimens.borderTextField),
          onChanged: onChanged,
          menuMaxHeight: MediaQuery.sizeOf(context).width / 2,
          isExpanded: true,
          hint: StyleLabel(
            title: hintText,
            style:
                ThemeText.note.copyWith(color: AppColor.hintColor, height: 1.5),
          ),
          items: childs ??
              items.map((e) => _buildDropDownMenu(context, e)).toList(),
        ),
      ],
    ).paddingBottom(AppDimens.paddingSmall);
  }

  DropdownMenuItem<T> _buildDropDownMenu(BuildContext context, T value) {
    return DropdownMenuItem<T>(
        value: value,
        child: StyleLabel(
          title: value.toString(),
          style: ThemeText.style12Regular,
        ).paddingRight(AppDimens.paddingMedium));
  }
}

class DropDownSelectCustome2<T> extends StatelessWidget {
  final Function(T?)? onChanged;
  final List<T> items;
  final T? value;
  final List<DropdownMenuItem<T>>? childs;

  final String? Function(T?)? validate;
  final bool? isRequired;
  const DropDownSelectCustome2({
    Key? key,
    this.onChanged,
    required this.items,
    this.value,
    this.validate,
    this.isRequired,
    this.childs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderDefault = InputBorder.none;

    return DropdownButtonFormField<T>(
      value: value,
      padding: EdgeInsets.zero,
      icon: const Visibility(visible: false, child: Icon(Icons.arrow_downward)),
      elevation: 0,
      decoration: const InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.center,
        prefixIcon: Icon(
          Icons.filter_list_sharp,
          color: AppColor.primaryColor,
        ),
        contentPadding: EdgeInsets.zero,
        filled: true,
        prefixIconConstraints: BoxConstraints(
          minWidth: 25,
          minHeight: 25,
        ),
        constraints: BoxConstraints(minWidth: 25),
        fillColor: AppColor.white,
        enabledBorder: borderDefault,
        focusedBorder: borderDefault,
        focusedErrorBorder: borderDefault,
        disabledBorder: borderDefault,
        border: borderDefault,
      ),
      dropdownColor: AppColor.lightBlue,
      borderRadius: BorderRadius.circular(AppDimens.borderTextField),
      onChanged: onChanged,
      style: ThemeText.noteSmall,
      menuMaxHeight: 1.sw * 0.5,
      isDense: true,
      isExpanded: false,
      items:
          childs ?? items.map((e) => _buildDropDownMenu(context, e)).toList(),
    );
  }

  DropdownMenuItem<T> _buildDropDownMenu(BuildContext context, T value) {
    return DropdownMenuItem<T>(
        value: value,
        child: StyleLabel(
          title: value.toString(),
          style: ThemeText.noteSmall,
        ));
  }
}

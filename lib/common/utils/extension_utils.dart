import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';

import '../../core/presentation/widgets/widgets.dart';
import '../themes/themes.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String formatCurrencyPurchase() {
    return "VNĐ ${replaceAll("₫", "").replaceAll(".", ",").trim()}";
  }

  String getDatePickUpTime() {
    return replaceRange(0, 5, "");
  }

  String formatTimeDifference() {
    DateTime now = DateTime.now();
    DateTime parsedDate = DateFormat("HH:mm dd/MM/yyyy").parse(this);

    Duration difference = now.difference(parsedDate);

    if (difference.inSeconds < 60) {
      return "Vài giây trước";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} phút trước";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} giờ trước";
    } else {
      return "${difference.inDays} ngày trước";
    }
  }

  String removeLinks() {
    final regex = RegExp(r"http[s]?:\/\/\S+");
    return replaceAll(regex, '');
  }

  String formatSpeechTimeCurrent() {
    try {
      final dateTime = DateFormat("HH:mm dd/MM/yyyy").parse(this);
      final hour = dateTime.hour.toString().padLeft(2, '');
      final minute = dateTime.minute.toString().padLeft(2, '');
      final day = dateTime.day.toString().padLeft(2, '');
      final month = dateTime.month.toString().padLeft(2, '');

      final formattedString = '$hour giờ $minute phút ngày $day tháng $month';
      return formattedString;
    } catch (e) {
      print('Invalid date format');
      return this;
    }
  }

  String calculateTimeDifference() {
    try {
      DateTime now = DateTime.now();
      DateTime parsedDate = DateFormat("HH:mm dd/MM/yyyy").parse(this);

      Duration difference = parsedDate.difference(now);

      final days = difference.inDays;
      final hours = difference.inHours.remainder(24);
      final minutes = difference.inMinutes.remainder(60);

      var time = "";

      if (days > 0) {
        print(days);
        time += '$days ngày';
      }
      if (hours > 0) {
        print(hours);
        time += '$hours giờ';
      }
      if (minutes > 0) {
        print(minutes);
        time += ' $minutes phút ';
      }
      return time;
    } catch (e) {
      print('Invalid date format');
      return '';
    }
  }

  int calculateTimeDifferenceNumber() {
    try {
      DateTime now = DateTime.now();
      DateTime parsedDate = DateFormat("HH:mm dd/MM/yyyy").parse(this);

      Duration difference = parsedDate.difference(now);

      final hours = difference.inHours;
      return hours;
    } catch (e) {
      print('Invalid date format');
      return -1;
    }
  }
}

extension NumberExtension on int {
  String formatDisplay() {
    return this < 10 && this != 0 ? "0$this" : "$this";
  }

  String formatCurrency() {
    return "VNĐ ${toCurrencyFormat().replaceAll(".", ",")}";
  }
}

extension PercentExtension on double {
  String formatPercentage() {
    String formattedValue = (this * 100).toStringAsFixed(2);
    return '$formattedValue%';
  }
}

extension IntCurrencyFormatting on int {
  String toCurrencyFormat() {
    final formatter = NumberFormat('#,###');
    return formatter.format(this);
  }
}

extension ShowExtensionContext on BuildContext {
  Future<void> showBottomSheet(
      {required Widget child, String? title, double? height}) async {
    await showModalBottomSheet(
      context: this,
      barrierColor: Colors.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderTextField),
      ),
      backgroundColor: Theme.of(this).cardColor,
      builder: (BuildContext context) {
        return SizedBox(
          height: height,
          child: Column(
            children: [
              Visibility(
                visible: title != null,
                child: Column(
                  children: [
                    StyleLabel(
                        title: title!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            )).paddingSymmetric(
                        vertical: AppDimens.paddingSmall),
                    Divider(height: 10.h, color: AppColor.grey)
                  ],
                ),
              ),
              child,
            ],
          ),
        );
      },
    );
    return;
  }
}

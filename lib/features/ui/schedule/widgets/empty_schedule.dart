// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pipcar/common/themes/theme_text.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';

class EmptyListSchedule extends StatelessWidget {
  final String? text;
  const EmptyListSchedule({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) => Center(
              child: StyleLabel(
                title: text ?? "Danh sách lịch trống",
                style: ThemeText.caption.copyWith(fontWeight: FontType.light),
              ),
            ));
  }
}

class EmptyListCar extends StatelessWidget {
  const EmptyListCar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) => Center(
              child: StyleLabel(
                title: "Danh sách xe trống",
                style: ThemeText.caption.copyWith(fontWeight: FontType.light),
              ),
            ));
  }
}

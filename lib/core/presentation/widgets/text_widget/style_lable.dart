import 'package:flutter/material.dart';
import '../../../../common/themes/themes.dart';

class StyleLabel extends StatelessWidget {
  final String title;
  final TextAlign textAlign;
  final int? maxLines;
  final TextStyle? style;
  final bool isSelectable;

  const StyleLabel({
    Key? key,
    this.title = '',
    this.textAlign = TextAlign.left,
    this.isSelectable = false,
    this.maxLines,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSelectable
        ? SelectableText(
            title,
            textAlign: textAlign,
            style: style ?? ThemeText.caption,
          )
        : Text(
            title,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: style ?? ThemeText.caption,
          );
  }
}

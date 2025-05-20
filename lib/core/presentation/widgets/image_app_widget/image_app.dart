import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/themes/themes.dart';

// ignore: must_be_immutable
class ImageAppWidget extends StatelessWidget {
  final String? path;
  bool isRemote = false;
  Widget? placeholder;
  Widget? errorWidget;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  double? loadingSize;

  ImageAppWidget({
    Key? key,
    required this.path,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.radius,
    this.loadingSize,
    this.color,
  }) : super(key: key);

  Widget get _placeholder {
    return Center(
        child: SizedBox(
      width: loadingSize ?? 20.sp,
      height: loadingSize ?? 20.sp,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
        strokeWidth: 2,
      ),
    ));
  }

  Widget get _errorWidget {
    return const Center(child: Icon(Icons.error));
  }

  ImageType get imageType {
    int length = path!.length;
    String firstString = path!.substring(0, 5).toUpperCase();
    String lastString = path!.substring(length - 5).toUpperCase();
    if (lastString.contains('.svg'.toUpperCase())) {
      return ImageType.svg;
    } else if (firstString.contains('asset'.toUpperCase()) || firstString.contains('http'.toUpperCase())) {
      return ImageType.image;
    } else {
      return ImageType.file;
    }
  }

  bool checkRemote() {
    if (path!.contains('http://') || path!.contains('https://')) {
      return true;
    }
    return false;
  }

  Widget _buildLottieImageWidget() {
    return image(FileImage(File(path!)));
  }

  Widget _buildSvgImageWidget() {
    if (isRemote) {
      return SvgPicture.network(
        path!,
        fit: fit,
        width: width,
        height: height,
        colorFilter: ColorFilter.mode(color ?? Colors.transparent, BlendMode.srcIn),
        placeholderBuilder: (context) => placeholder ?? _placeholder,
      );
    }

    return SvgPicture.asset(
      path!,
      fit: fit,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color ?? Colors.transparent, BlendMode.srcIn),
      placeholderBuilder: (context) => placeholder ?? _placeholder,
    );
  }

  Widget _buildNormalImageWidget() {
    if (isRemote) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: CachedNetworkImage(
          imageUrl: path!,
          fit: fit,
          width: width,
          height: height,
          placeholder: (context, _) => placeholder ?? _placeholder,
          errorWidget: (context, url, error) => errorWidget ?? _errorWidget,
        ),
      );
    }
    return image(AssetImage(path!));
  }

  Widget image(ImageProvider<Object> image) => ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image(
          image: image,
          fit: fit,
          width: width,
          height: height,
          color: color,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return placeholder ?? _placeholder;
          },
          errorBuilder: (context, error, stackTrace) => errorWidget ?? _errorWidget,
        ),
      );

  @override
  Widget build(BuildContext context) {
    isRemote = checkRemote();
    if (path == null || path!.isEmpty) {
      return _errorWidget;
    }
    switch (imageType) {
      case ImageType.file:
        return _buildLottieImageWidget();
      case ImageType.svg:
        return _buildSvgImageWidget();
      default:
        return _buildNormalImageWidget();
    }
  }
}

enum ImageType { svg, image, file }

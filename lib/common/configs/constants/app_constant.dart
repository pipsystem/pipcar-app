import 'package:flutter/foundation.dart';

import '../../../features/domain/enterties/car_type_entity.dart';
import '../../assets/assets.gen.dart';

class AppConstant {
  // ignore: constant_identifier_names
  static const BASE_URL = 
  // kDebugMode
      // ? "https://pcapi.adevz.com/api/"
      // ?
       "https://pcapi.adevz.com/api";
      // : "https://api.pipcar.vn/api/";
  static const String appTitle = 'Pipcar';

  static final List<CarTypeEntity> listCarType = [
    CarTypeEntity(image: Assets.images.xe5.keyName, id: 1, name: "xe 5 chỗ"),
    CarTypeEntity(image: Assets.images.xe7.keyName, id: 2, name: "xe 7 chỗ"),
    CarTypeEntity(image: Assets.images.xe16.keyName, id: 3, name: "xe 16 chỗ"),
    CarTypeEntity(image: Assets.images.xe29.keyName, id: 4, name: "xe 29 chỗ"),
    CarTypeEntity(image: Assets.images.xe35.keyName, id: 5, name: "xe 35 chỗ"),
    CarTypeEntity(image: Assets.images.xe45.keyName, id: 6, name: "xe 45 chỗ"),
    CarTypeEntity(
        image: Assets.images.xeLimo.keyName, id: 7, name: "xe Limosine 9"),
  ];

  static const String secretKey = "n4mlundid0ng";
}

import 'package:test_flutter_2/common/constant/common.dart';

class Utils {
  static const baseApiUrl = CommonConst.baseApiUrl;
  String getImageUrl(String path) {
    return '$baseApiUrl/product/images/$path';
  }
}

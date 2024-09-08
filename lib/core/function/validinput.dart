// import 'package:get/get.dart';

vaildator(String val, int min, int max, String type) {
  // if (type == "username") {
  //   if (!GetUtils.isUsername(val)) {
  //     return "not valid name";
  //   }
  // }
  // if (type == "email") {
  //   if (!GetUtils.isEmail(val)) {
  //     return "not valid email";
  //   }
  // }

  // if (type == "phone") {
  //   if (!GetUtils.isPhoneNumber(val)) {
  //     return "not valid phone";
  //   }
  // }

  if (val.isEmpty) {
    return "لا يمكن أن يكون فارغ";
  }

  if (val.length < min) {
    return "لا يمكن أن يكون أقل من $min";
  }

  if (val.length > max) {
    return "لا يمكن أن يكون أكبر من $max";
  }
}

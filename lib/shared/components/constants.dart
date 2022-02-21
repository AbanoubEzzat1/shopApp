import 'package:shop_app/modules/shop_auth/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context) async {
  await CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text) {
  //Copied Method
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';

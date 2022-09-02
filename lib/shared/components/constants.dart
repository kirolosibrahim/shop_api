// List<Map> tasksList  = [] ;

import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

const ShopAppName = 'Salla';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    print('Sign Out');
    navigateAndFinish(context, ShopLoginScreen());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

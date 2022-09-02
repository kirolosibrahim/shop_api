

import 'package:shop_api/models/shop_app/shop_user_model.dart';


abstract class ShopLoginStates {}


class ShopLoginInitialState extends ShopLoginStates {}
class ShopLoginLoadingState extends ShopLoginStates {}


class ShopLoginSuccessState extends ShopLoginStates {
 late final ShopUserModel userModel;

 ShopLoginSuccessState(this.userModel);
}

class ShopLoginErrorState extends ShopLoginStates {
 late final String error ;

 ShopLoginErrorState(this.error);
}


class ShopChangePasswordVisibilityState extends ShopLoginStates {}
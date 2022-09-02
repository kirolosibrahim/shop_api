



import '../../../../models/shop_app/shop_user_model.dart';

abstract class ShopRegisterStates {}


class ShopRegisterInitialState extends ShopRegisterStates {}
class ShopRegisterLoadingState extends ShopRegisterStates {}


class ShopRegisterSuccessState extends ShopRegisterStates {
 late final ShopUserModel userModel;

 ShopRegisterSuccessState(this.userModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
 late final String error ;

 ShopRegisterErrorState(this.error);
}


class ShopChangeRegisterPasswordVisibilityState extends ShopRegisterStates {}
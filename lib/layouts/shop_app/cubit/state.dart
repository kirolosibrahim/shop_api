import 'package:shop_api/models/shop_app/shop_change_favorites_model.dart';
import 'package:shop_api/models/shop_app/shop_user_model.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppChangeBottomNavBarState extends ShopAppStates {}

class ShopAppChangeBottomSheetState extends ShopAppStates {}

class ShopAppLoadingHomeDataState extends ShopAppStates {}

class ShopAppSuccessHomeDataState extends ShopAppStates {}

class ShopAppErrorHomeDataState extends ShopAppStates {}

class ShopAppLoadingCategoriesDataState extends ShopAppStates {}

class ShopAppSuccessCategoriesDataState extends ShopAppStates {}

class ShopAppErrorCategoriesState extends ShopAppStates {}

class ShopAppLoadingUserDataState extends ShopAppStates {}

class ShopAppSuccessUserDataState extends ShopAppStates {
  late final ShopUserModel userModel ;
  ShopAppSuccessUserDataState(this.userModel);
}

class ShopAppErrorUserDataState extends ShopAppStates {
  late final String error;

  ShopAppErrorUserDataState(this.error);
}

class ShopAppSuccessSignOutState extends ShopAppStates {}
class ShopAppLoadingSignOutState extends ShopAppStates {}
class ShopAppErrorSignOutState extends ShopAppStates {}
class ShopAppSuccessTokenState extends ShopAppStates {}
class ShopAppLoadingTokenState extends ShopAppStates {}
class ShopAppErrorTokenState extends ShopAppStates {}




class ShopAppSuccessChangeFavoritesState extends ShopAppStates {
  final ChangeFavoritesModel model ;

  ShopAppSuccessChangeFavoritesState(this.model);

}


class ShopAppChangeFavoritesState extends ShopAppStates {
}

class ShopAppErrorChangeFavoritesState extends ShopAppStates {}



class ShopAppErrorFavoritesDataState extends ShopAppStates {}
class ShopAppLoadingFavoritesDataState extends ShopAppStates {}

class ShopAppSuccessFavoritesDataState extends ShopAppStates {}


class ShopSuccessUpdateUserState extends ShopAppStates{
  late final ShopUserModel userModel;
  ShopSuccessUpdateUserState(this.userModel);


}
class ShopLoadingUpdateUserState extends ShopAppStates
{

  ShopLoadingUpdateUserState();
}

class ShopErrorUpdateUserState extends ShopAppStates {}

class ShopAppThemeState extends ShopAppStates {}





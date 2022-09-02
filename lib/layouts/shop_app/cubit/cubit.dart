import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api/layouts/shop_app/cubit/state.dart';
import 'package:shop_api/models/shop_app/shop_favorites_model.dart';
import 'package:shop_api/models/shop_app/shop_home_model.dart';
import 'package:shop_api/models/shop_app/shop_user_model.dart';
import 'package:shop_api/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_api/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_api/modules/shop_app/products/products_screen.dart';
import 'package:shop_api/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_api/shared/network/remote/dio_helper.dart';

import '../../../models/shop_app/shop_categories_model.dart';
import '../../../models/shop_app/shop_change_favorites_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);
  String? Token;
  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ShopProductsScreen(),
    const ShopCategoriesScreen(),
    const ShopFavoritesScreen(),
    ShopSettingsScreen(),
  ];

  void changeBottom({required int index}) {
    currentIndex = index;
    emit(ShopAppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeShopAppTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopAppThemeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ShopAppThemeState());
      });
    }
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() async {
    Token = CacheHelper.getData(key: 'token');
    emit(ShopAppLoadingHomeDataState());
    await DioHelper.getDate(url: HOME, token: Token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites.toString());

      emit(ShopAppSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorHomeDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int ProductID) async {
    Token = CacheHelper.getData(key: 'token');
    favorites[ProductID] = !favorites[ProductID]!;
    emit(ShopAppChangeFavoritesState());

    await DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': ProductID},
      token: Token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[ProductID] = !favorites[ProductID]!;
      } else {
        getFavoritesData();
      }

      emit(ShopAppSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorTokenState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() async {
    emit(ShopAppLoadingCategoriesDataState());
    await DioHelper.getDate(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopAppSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorCategoriesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() async {
    Token = CacheHelper.getData(key: 'token');

    emit(ShopAppLoadingFavoritesDataState());
    await DioHelper.getDate(
      url: FAVORITES,
      token: Token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopAppSuccessFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorFavoritesDataState());
    });
  }

  ShopUserModel? userModel;

  void getUserData() {
    Token = CacheHelper.getData(key: 'token');
    emit(ShopAppLoadingUserDataState());

    DioHelper.getDate(
      url: PROFILE,
      token: Token,
    ).then((value) {
      userModel = ShopUserModel.fromJson(value.data);
      print(userModel!.data!.name);

      emit(ShopAppSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorUserDataState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    Token = CacheHelper.getData(key: 'token');
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: Token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopUserModel.fromJson(value.data);
      printFullText(userModel!.data!.name);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

  void signOut() async {
    emit(ShopAppLoadingSignOutState());
    await CacheHelper.removeData(key: 'token').then((value) {
      Token = '';
      emit(ShopAppSuccessSignOutState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppErrorSignOutState());
    });
  }
}

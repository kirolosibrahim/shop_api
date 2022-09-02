import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api/modules/shop_app/login/cubit/state.dart';

import '../../../../models/shop_app/shop_user_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopUserModel? userModel;

  userLogin({
    required String Email,
    required String Password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': Email,
        'password': Password,
      },
    ).then((value) {
      userModel = ShopUserModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: userModel!.data!.token);

      emit(ShopLoginSuccessState(userModel!));
      showToast(
          msg: userModel!.message.toString(), toastStates: ToastStates.SUCCESS);
    }).catchError((error) {
      print(error.toString());
      showToast(msg: error.toString(), toastStates: ToastStates.ERROR);
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}

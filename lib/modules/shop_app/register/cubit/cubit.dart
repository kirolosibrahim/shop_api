import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api/models/shop_app/shop_user_model.dart';

import 'package:shop_api/modules/shop_app/login/cubit/state.dart';
import 'package:shop_api/modules/shop_app/register/cubit/state.dart';

import '../../../../shared/components/components.dart';

import '../../../../shared/network/end_points.dart';

import '../../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopUserModel? userModel;


  userRegister({
    required String Name,
    required String Email,
    required String Phone,
    required String Password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': Name,
        'phone': Phone,
        'email': Email,
        'password': Password,
        'image': '',
      },
      lang: 'ar'
    ).then((value) {
      userModel = ShopUserModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(userModel!));
    }).catchError((error) {
      showToast(msg: error.toString(), toastStates: ToastStates.ERROR);
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeRegisterPasswordVisibilityState());
  }
}
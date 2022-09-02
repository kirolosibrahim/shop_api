import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_api/layouts/shop_app/cubit/state.dart';
import 'package:shop_api/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_api/modules/shop_app/login/cubit/state.dart';
import 'package:shop_api/shared/components/constants.dart';

import '../../../layouts/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../register/shop_register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {



    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    emailController.text =  'kirolos.ibrahim65@gmail.com';
    passwordController.text =  '123456';

    var model = ShopLoginCubit.get(context).userModel;

    return  BlocConsumer<ShopLoginCubit, ShopLoginStates>(

        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'Login Now to Browse our hot Offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          isPassword: false,
                          lable: 'Email Address',
                          onValidate: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter your Email Address';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Your Email Should be name@company.com ';
                            }
                          },
                          prefix: Icons.email_outlined),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        lable: 'Password',
                        onValidate: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Password';
                          }
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                Email: emailController.text,
                                Password: passwordController.text);
                          }
                        },
                        onSuffixPressed: () {
                          ShopLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        prefix: Icons.lock_outline,
                        suffix: ShopLoginCubit.get(context).suffix,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    Email: emailController.text,
                                    Password: passwordController.text);
                              }
                            },
                            text: 'login',
                            isUpperCase: true),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                          ),
                          defaultTextButton(
                              onPressed: () {
                                print('register now');
                                navigateTo(context, ShopRegisterScreen());
                              },
                              text: 'register now'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        listener: (context, state) {
         
          if (state is ShopLoginSuccessState) {
            navigateAndFinish(context, const ShopLayout());

          }
        },

    );
  }

  void connectionChecker() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      showToast(msg: 'Back Online', toastStates: ToastStates.SUCCESS);
    } else {
      showToast(msg: 'Offline', toastStates: ToastStates.ERROR);
    }
  }
}

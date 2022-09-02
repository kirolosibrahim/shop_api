import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_api/modules/shop_app/register/cubit/state.dart';

import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopRegisterCubit>(
      create:(context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        builder: (context, state) => Scaffold(
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
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'Register Now to Browse our hot Offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          isPassword: false,
                          lable: 'Name',
                          onValidate: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter your Name';
                            }
                          },
                          prefix: Icons.person),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          isPassword: false,
                          lable: 'Phone Number',
                          onValidate: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter your Phone Number';
                            }
                          },
                          prefix: Icons.phone_android),
                      const SizedBox(
                        height: 15,
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
                        isPassword: ShopRegisterCubit.get(context).isPassword,
                        lable: 'Password',
                        onValidate: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Password';
                          }
                        },
                        onSuffixPressed: () {
                          ShopRegisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                        prefix: Icons.lock_outline,
                        suffix: ShopRegisterCubit.get(context).suffix,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    Name: nameController.text.toString(),
                                    Phone: phoneController.text.toString(),
                                    Email: emailController.text.toString(),
                                    Password: passwordController.text.toString());

                                print(nameController.text.toString());
                                print(phoneController.text.toString());
                                print(emailController.text.toString());
                                print(passwordController.text.toString());
                              }
                            },
                            text: 'register',
                            isUpperCase: true),
                        fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            navigateAndFinish(context, ShopLoginScreen());
            showToast(
                msg: 'Registered Successfully', toastStates: ToastStates.SUCCESS);
          }
        },
      ),


    );
  }
}

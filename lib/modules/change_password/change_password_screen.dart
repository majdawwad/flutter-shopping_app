import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/change_password/cubit/cubit.dart';
import 'package:shop_app/modules/change_password/cubit/states.dart';
import 'package:shop_app/modules/rest_password/rest_password_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var currentPasswordController = TextEditingController();

  var newPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitChangePassword, ShopCubitChangePasswordStates>(
      listener: (context, state) {
        if (state is ShopCubitChangePasswordSuccessState) {
          if (state.changePasswordModel.status!) {
            defaultToast(
              message: state.changePasswordModel.message,
              context: context,
              typeMeswsage: DialogType.SUCCES,
            );
          } else {
            defaultToast(
              message: state.changePasswordModel.message,
              context: context,
              typeMeswsage: DialogType.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Change Password',
            ),
          ),
          body: Center(
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 14.0,
              margin: const EdgeInsetsDirectional.only(
                top: 60.0,
                end: 40.0,
                start: 40.0,
                bottom: 90.0,
              ),
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                              15.0,
                            ),
                            width: 120.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.blueAccent,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset.infinite,
                                ),
                              ],
                            ),
                            child: Text(
                              'Change',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Please enter your information ..',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          defaultTextFormField(
                            controller: currentPasswordController,
                            type: TextInputType.visiblePassword,
                            functionValidation: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your current password';
                              }
                              return null;
                            },
                            isPassword: ShopCubitChangePassword.get(context)
                                .isCurrentPassword,
                            suffix: ShopCubitChangePassword.get(context)
                                .suffixIconCurrent,
                            suffixFunction: () {
                              ShopCubitChangePassword.get(context)
                                  .changeCurrentPasswordVisibility();
                            },
                            labelText: 'Current Password',
                            labelStyle: const TextStyle(
                              color: defualtColor,
                            ),
                            prifixIcon: Icons.lock_outline_rounded,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defaultTextFormField(
                            controller: newPasswordController,
                            type: TextInputType.visiblePassword,
                            functionValidation: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your new password';
                              }
                              return null;
                            },
                            isPassword: ShopCubitChangePassword.get(context)
                                .isNewPassword,
                            suffix: ShopCubitChangePassword.get(context)
                                .suffixIconNew,
                            suffixFunction: () {
                              ShopCubitChangePassword.get(context)
                                  .changeNewPasswordVisibility();
                            },
                            labelText: 'New Password',
                            labelStyle: const TextStyle(
                              color: defualtColor,
                            ),
                            prifixIcon: Icons.lock_outline_rounded,
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          ConditionalBuilder(
                            condition:
                                state is! ShopCubitChangePasswordIsLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopCubitChangePassword.get(context)
                                      .changePassword(
                                    currentPass: currentPasswordController.text,
                                    newPass: newPasswordController.text,
                                  );
                                  currentPasswordController.clear();
                                  newPasswordController.clear();
                                }
                              },
                              text: 'Change now',
                              isUpperCase: true,
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 14.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'If you want to rest password?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(
                                    context,
                                    const RestPasswordScreen(),
                                  );
                                },
                                child: const Text(
                                  'Rest password.',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout_shop.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopRegisterScreen extends StatefulWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubitRegister(),
      child: BlocConsumer<ShopCubitRegister, ShopCubitRegisterStates>(
        listener: (context, state) {
          if (state is ShopCubitRegisterSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(
                  context,
                  const HomeLayoutShop(),
                );
              });
            } else {
              defaultToast(
                message: state.loginModel.message,
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
                'Register',
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
                              width: 110.0,
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
                                'RIGISTER',
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
                              'Please register by enter your information ..',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            defaultTextFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              functionValidation: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your user name';
                                }
                                return null;
                              },
                              labelText: 'User Name',
                              labelStyle: const TextStyle(
                                color: defualtColor,
                              ),
                              prifixIcon: Icons.person,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            defaultTextFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              functionValidation: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              labelText: 'Email Address',
                              labelStyle: const TextStyle(
                                color: defualtColor,
                              ),
                              prifixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            defaultTextFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              functionValidation: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                              labelText: 'Phone Number',
                              labelStyle: const TextStyle(
                                color: defualtColor,
                              ),
                              prifixIcon: Icons.phone,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            defaultTextFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              functionValidation: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              isPassword:
                                  ShopCubitRegister.get(context).isPassword,
                              suffix: ShopCubitRegister.get(context).suffixIcon,
                              suffixFunction: () {
                                ShopCubitRegister.get(context)
                                    .changePasswordVisibility();
                              },
                              labelText: 'Password',
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
                                  state is! ShopCubitRegisterIsLoadingState,
                              builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopCubitRegister.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'register now',
                                isUpperCase: true,
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
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
      ),
    );
  }
}

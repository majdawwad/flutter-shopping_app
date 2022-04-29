import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_layout_shop.dart';
import 'package:shop_app/modules/register/shop_register_screen.dart';
import 'package:shop_app/modules/shop_login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_login/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubitLogin(),
      child: BlocConsumer<ShopCubitLogin, ShopCubitLoginStates>(
        listener: (context, state) {
          if (state is ShopCubitLoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token!;
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
                'Login',
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
                              padding: const EdgeInsets.all(15.0),
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
                                'LOGIN',
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
                              'Please login by enter your information ..',
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
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  ShopCubitLogin.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              functionValidation: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              isPassword:
                                  ShopCubitLogin.get(context).isPassword,
                              suffix: ShopCubitLogin.get(context).suffixIcon,
                              suffixFunction: () {
                                ShopCubitLogin.get(context)
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
                              condition: state is! ShopCubitLoginIsLoadingState,
                              builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopCubitLogin.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'login now',
                                isUpperCase: true,
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'If you no login please create an account?',
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
                                      const ShopRegisterScreen(),
                                    );
                                  },
                                  child: const Text(
                                    'Register.',
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
      ),
    );
  }
}

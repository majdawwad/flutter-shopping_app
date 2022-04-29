// ignore_for_file: unnecessary_null_comparison

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/shop_profile_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String imageData = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateProfileDataState) {
          defaultToast(
            context: context,
            typeMeswsage: DialogType.SUCCES,
            message: state.updateShopProfileModel.status.toString() + ",The profile updated successfully.",
          );
        }else if(state is ShopErrorUpdateProfileDataState){
          defaultToast(
            context: context,
            typeMeswsage: DialogType.ERROR,
            message: state.error + ",The profile did not update successfully.",
          );
        }
      },
      builder: (context, state) {
        ShopProfileModel? updateProfileModel =
            ShopCubit.get(context).profileModel != null
                ? ShopCubit.get(context).profileModel!
                : null;

        if (updateProfileModel!.data != null) {
          nameController.text = updateProfileModel.data!.name!;
          emailController.text = updateProfileModel.data!.email!;
          phoneController.text = updateProfileModel.data!.phone!;
        }

        return ConditionalBuilder(
          condition: updateProfileModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text(
                'Update profile information.',
              ),
            ),
            body: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 14.0,
              margin: const EdgeInsetsDirectional.only(
                top: 60.0,
                end: 30.0,
                start: 30.0,
                bottom: 60.0,
              ),
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 15,
                  right: 15,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Transform.translate(
                                offset: const Offset(0, -10),
                                child: Container(
                                  height: 160,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        defualtColor,
                                      ],
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: updateProfileModel.data!.image!
                                        .toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 70,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 106,
                                bottom: 8,
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.blue[300],
                                    heroTag: "photo",
                                    splashColor: Colors.amber[50],
                                    elevation: 12,
                                    onPressed: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          elevation: 10.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                          ),
                                          title: Text(
                                            'Choose from : ',
                                            style: TextStyle(
                                              fontSize: 26.0,
                                              fontWeight: FontWeight.w900,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    ShopCubit.get(context)
                                                        .getImage(
                                                            imageSource:
                                                                ImageSource
                                                                    .gallery);
                                                    Navigator.pop(context);
                                                  },
                                                  splashColor:
                                                      Colors.blueAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.image_outlined,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      const SizedBox(
                                                        width: 16.0,
                                                      ),
                                                      Text(
                                                        'Gallery .',
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 14.0,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    ShopCubit.get(context)
                                                        .getImage(
                                                            imageSource:
                                                                ImageSource
                                                                    .camera);

                                                    Navigator.pop(context);
                                                  },
                                                  splashColor:
                                                      Colors.blueAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      const SizedBox(
                                                        width: 16.0,
                                                      ),
                                                      Text(
                                                        'Camera .',
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 14.0,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  splashColor:
                                                      Colors.blueAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .highlight_remove_outlined,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                      const SizedBox(
                                                        width: 16.0,
                                                      ),
                                                      Text(
                                                        'Remove .',
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.person_add_alt_1,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          defaultTextFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            functionValidation: (value) {
                              if (value!.isEmpty) {
                                return "Name must to be not empty";
                              }
                              return null;
                            },
                            labelText: "User Name",
                            labelStyle: const TextStyle(
                              color: defualtColor,
                            ),
                            prifixIcon: Icons.person_add_alt_1,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            functionValidation: (value) {
                              if (value!.isEmpty) {
                                return "Email must to be not empty";
                              }
                              return null;
                            },
                            labelText: "Email Address",
                            labelStyle: const TextStyle(
                              color: defualtColor,
                            ),
                            prifixIcon: Icons.email_rounded,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultTextFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            functionValidation: (value) {
                              if (value!.isEmpty) {
                                return "Phone must to be not empty";
                              }
                              return null;
                            },
                            labelText: "Phone Number",
                            labelStyle: const TextStyle(
                              color: defualtColor,
                            ),
                            prifixIcon: Icons.phone_iphone_rounded,
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          SizedBox(
                            width: 300,
                            height: 60,
                            child: FloatingActionButton(
                              heroTag: "update",
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              splashColor: Colors.amber[50],
                              elevation: 12,
                              onPressed: () {
                                if (ShopCubit.get(context).baseImage != null) {
                                  imageData = ShopCubit.get(context).baseImage!;
                                }
                                if (formKey.currentState!.validate()) {
                                  ShopCubit.get(context).putProfileData(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    image: imageData,
                                  );
                                }
                              },
                              child: const Text(
                                'UPDATE',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

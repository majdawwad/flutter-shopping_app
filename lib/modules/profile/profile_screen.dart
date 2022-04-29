import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/shop_profile_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopProfileModel? profileModel =
            ShopCubit.get(context).profileModel != null
                ? ShopCubit.get(context).profileModel!
                : null;
        return ConditionalBuilder(
          condition: profileModel != null,
          builder: (context) => buildProfileUser(profileModel!.data!, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildProfileUser(ProfileData model, context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile information.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Transform.translate(
            offset: const Offset(
              0,
              20,
            ),
            child: Container(
              height: 150,
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
                imageUrl: model.image!.toString(),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 66,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 14.0,
              margin: const EdgeInsetsDirectional.only(
                top: 50.0,
                end: 30.0,
                start: 30.0,
                bottom: 80.0,
              ),
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(
                      30.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'User Name         : ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: defualtColor,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              model.name!.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).iconTheme.color),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Email Address   : ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: defualtColor,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: Text(
                                model.email!.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number : ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: defualtColor,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              model.phone!.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).iconTheme.color,
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
        ],
      ),
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/shop_getfavorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.favoritesModel.status!) {
            defaultToast(
              message: 'Not Authorization, you must to from information',
              context: context,
              typeMeswsage: DialogType.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        ShopGetFavoritesModel? getFavoritesModel =
            ShopCubit.get(context).shopGetFavoritesModel != null
                ? ShopCubit.get(context).shopGetFavoritesModel!
                : null;

        return ConditionalBuilder(
          condition: getFavoritesModel != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildFavItem(getFavoritesModel!.data!.data[index], context),
            separatorBuilder: (context, index) => defaultDivider(),
            itemCount: getFavoritesModel!.data!.data.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Container(
        padding: const EdgeInsets.all(
          20.0,
        ),
        height: 200.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: "assets/images/loading.gif",
                  image: model.product!.image!,
                  width: 200,
                  height: 200.0,
                ),
                if (model.product!.discount! != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defualtColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.product!.discount! != 0)
                        Text(
                          '${model.product!.oldPrice!}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            ShopCubit.get(context).favories[model.product!.id!]!
                                ? defualtColor
                                : Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id!);
                          },
                          icon: const Icon(
                            Icons.favorite,
                            size: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

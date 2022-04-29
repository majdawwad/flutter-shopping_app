import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/shop_categories_model.dart';
import 'package:shop_app/models/shop_home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

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
        ShopHomeModel? homeModel = ShopCubit.get(context).homeModel != null
            ? ShopCubit.get(context).homeModel!
            : null;

        ShopCategoriesModel? categoryModel =
            ShopCubit.get(context).categoyModel != null
                ? ShopCubit.get(context).categoyModel!
                : null;

        return ConditionalBuilder(
          condition: homeModel != null && categoryModel != null,
          builder: (context) =>
              productsBuilder(homeModel!, categoryModel!, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
      ShopHomeModel model, ShopCategoriesModel modelcat, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => FadeInImage.assetNetwork(
                    placeholder: "assets/images/loading.gif",
                    image: e.image!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 300.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories : ',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).iconTheme.color,
                    shadows: [
                      Shadow(
                        color: Colors.grey.shade800,
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                SizedBox(
                  height: 190.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCategories(modelcat.data!.data![index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 12.0,
                    ),
                    itemCount: modelcat.data!.data!.length,
                  ),
                ),
                const SizedBox(
                  height: 34.0,
                ),
                Text(
                  'New Products : ',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).iconTheme.color,
                    shadows: [
                      Shadow(
                        color: Colors.grey.shade800,
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                model.data!.products.length,
                (index) {
                  return buildGridVeiwProdact(
                      model.data!.products[index], context);
                },
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.28,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategories(CategoriesData model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        FadeInImage.assetNetwork(
          placeholder: "assets/images/loading.gif",
          image: model.image!,
          width: 190.0,
          height: 190.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 190.0,
          color: Colors.black.withOpacity(.7),
          child: Text(
            model.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGridVeiwProdact(ProdactsData model, context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              FadeInImage.assetNetwork(
                placeholder: "assets/images/loading.gif",
                image: model.image!,
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defualtColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor:
                          ShopCubit.get(context).favories[model.id]!
                              ? defualtColor
                              : Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
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
}

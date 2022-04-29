import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/shop_categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCategoriesModel? categoriesModel =
            ShopCubit.get(context).categoyModel != null
                ? ShopCubit.get(context).categoyModel!
                : null;
        return ConditionalBuilder(
          condition: categoriesModel != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildCatItem(categoriesModel!.data!.data![index], context),
            separatorBuilder: (context, index) => defaultDivider(),
            itemCount: ShopCubit.get(context).categoyModel!.data!.data!.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCatItem(CategoriesData model, context) => Container(
        height: 180.0,
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Row(
          children: [
            FadeInImage.assetNetwork(
              placeholder:"assets/images/loading.gif",
              image: model.image!,
              width: 180.0,
              height: 180.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              model.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 30.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
}

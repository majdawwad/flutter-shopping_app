import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopSearchModel? searchModel =
              ShopSearchCubit.get(context).searchModel != null
                  ? ShopSearchCubit.get(context).searchModel!
                  : null;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Search',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      onSubmit: (text) {
                        ShopSearchCubit.get(context).search(text);
                      },
                      functionValidation: (value) {
                        if (value!.isEmpty) {
                          return "Please, Enter any text";
                        }
                        return null;
                      },
                      labelText: "Search",
                      labelStyle: const TextStyle(
                        color: defualtColor,
                      ),
                      prifixIcon: Icons.search,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    if (state is ShopSearchIsLoadingStates)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 12.0,
                    ),
                    if (state is ShopSearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildFavItem(
                              searchModel!.data!.data[index], context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) =>
                              defaultDivider(),
                          itemCount: searchModel!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFavItem(ProductData model, context, {isOldPrice = true}) {
    return Container(
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
                image: model.image!,
                width: 200,
                height: 200.0,
              ),
              if (isOldPrice)
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
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defualtColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (isOldPrice)
                      Text(
                        '${model.oldPrice!}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
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

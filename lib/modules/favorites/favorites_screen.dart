import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            if (ShopCubit.get(context).favoritesModell!.data!.data!.isEmpty)
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 150),
                child: Column(
                  children: const [
                    Center(
                        child: Icon(
                      Icons.favorite_border_outlined,
                      size: 200,
                      color: Colors.grey,
                    )),
                    Text("Your favorite is empty",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            Expanded(
              child: BuildCondition(
                condition: state is! ShopLoadingGetFavoritesState,
                builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => bulidProductsItem(
                      ShopCubit.get(context)
                          .favoritesModell!
                          .data!
                          .data![index]
                          .product!,
                      context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: ShopCubit.get(context)
                      .favoritesModell!
                      .data!
                      .data!
                      .length,
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'dart:ui';

import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.changeFavoritsModel!.status!) {
            showToast(
                text: state.changeFavoritsModel!.message!,
                state: ToastState.ERORR);
          }
        }
      },
      builder: (context, state) {
        return BuildCondition(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,
              context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    //lock to comment
                    (e) => CachedNetworkImage(
                      imageUrl: e.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              /**
                   * //changed becose loading erorr cose of connection close
                   * .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
                   */
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => bulidCategorieItem(
                          categoriesModel.data.data[index], context),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemCount: categoriesModel.data.data.length,
                    ),
                  ),
                  const Text(
                    "New Products",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.55,
                children: List.generate(
                  model.data!.products.length,
                  (int index) =>
                      buildGridProduct(model.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                productImage(
                  imageUrl: model.image,
                  height: 200,
                  width: double.infinity,
                ),
                /* Image(
                  image: NetworkImage(
                    model.image,
                  ),
                  width: double.infinity,
                  height: 200,
                ),*/
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: Colors.red,
                    child: const Text(
                      "Discount",
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${model.price.round()}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          height: 1.3,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (model.discount != 0)
                        Text(
                          "${model.oldPrice.round()}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            height: 1.3,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeCartData(productId: model.id!);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                ShopCubit.get(context).cartProducts[model.id]!
                                    ? Colors.red
                                    : Colors.grey,
                            child: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                          )),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavoritesData(model.id!);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                ShopCubit.get(context).favorits[model.id]!
                                    ? Colors.blue
                                    : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  Widget bulidCategorieItem(DataModel model, context) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          productImage(
            imageUrl: "${model.image}",
            height: 100,
            width: 100,
          ),
          /*Image(
            image: NetworkImage("${model.image}"),
            height: 100,
            width: 100,
            // fit: BoxFit.cover,
          ),*/
          Container(
            color: Colors.blue.withOpacity(0.8),
            width: 100,
            child: Text(
              "${model.name}",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}

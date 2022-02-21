import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/cart_models.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: ShopCubit.get(context).cartModel!.data!.total > 0,
          builder: (context) => Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Total Price",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      " ${ShopCubit.get(context).cartModel!.data!.total} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      "LE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              BuildCondition(
                condition: state is! ShopLoadingGetFavoritesState,
                builder: (context) => Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => bulidProductsItem(
                        ShopCubit.get(context)
                            .cartModel!
                            .data!
                            .cartItems![index]
                            .product!,
                        context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: ShopCubit.get(context)
                        .cartModel!
                        .data!
                        .cartItems!
                        .length,
                  ),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
          fallback: (context) => Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                    child: Icon(
                  Icons.shopping_cart,
                  size: 200,
                  color: Colors.grey,
                )),
                Text("Your cart is empty",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget bulidProductsItem(Product model, context, {bool isOldPrice = true}) =>
  //     Container(
  //       margin: const EdgeInsets.all(20),
  //       height: 120,
  //       child: Row(
  //         children: [
  //           Stack(
  //             alignment: AlignmentDirectional.bottomStart,
  //             children: [
  //               productImage(
  //                 imageUrl: "${model.image}",
  //               ),
  //               if (model.discount != 0 && isOldPrice)
  //                 Container(
  //                   padding: const EdgeInsets.all(5),
  //                   color: Colors.red,
  //                   child: const Text(
  //                     "Discount",
  //                     style: TextStyle(
  //                         fontSize: 8,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white),
  //                   ),
  //                 ),
  //             ],
  //           ),
  //           SizedBox(width: 20),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "${model.name}",
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 14,
  //                     height: 1.3,
  //                   ),
  //                 ),
  //                 const Spacer(),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       "${model.price}",
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 14,
  //                         height: 1.3,
  //                         color: Colors.blue,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 10),
  //                     if (model.discount != 0 && isOldPrice)
  //                       Text(
  //                         "${model.oldPrice}",
  //                         maxLines: 2,
  //                         overflow: TextOverflow.ellipsis,
  //                         style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 12,
  //                           height: 1.3,
  //                           decoration: TextDecoration.lineThrough,
  //                           color: Colors.grey,
  //                         ),
  //                       ),
  //                     const Spacer(),
  //                     IconButton(
  //                         onPressed: () {
  //                           ShopCubit.get(context)
  //                               .changeFavoritesData(model.id!);
  //                           print(model.id);
  //                         },
  //                         icon: CircleAvatar(
  //                           radius: 15,
  //                           backgroundColor:
  //                               ShopCubit.get(context).favorits[model.id]!
  //                                   ? Colors.blue
  //                                   : Colors.grey,
  //                           child: const Icon(
  //                             Icons.favorite_border,
  //                             color: Colors.white,
  //                           ),
  //                         )),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}

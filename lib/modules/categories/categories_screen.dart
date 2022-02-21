import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(
              ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            child: productImage(
              imageUrl: "${model.image}",
            ),
            /*Image(
              image: NetworkImage("${model.image}"),
              fit: BoxFit.cover,
            ),*/
          ),
          const SizedBox(width: 15),
          Text(
            " ${model.name}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ));
}

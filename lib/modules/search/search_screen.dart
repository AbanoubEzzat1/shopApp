import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/search_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/search_cubit.dart';
import 'package:shop_app/shared/cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    deffaultFormField(
                      controller: searchController,
                      labelText: "Search",
                      prefix: Icons.search,
                      validate: (value) {
                        if (value != null || value!.isEmpty) {
                          return "Enter text to search";
                        }
                      },
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).getSearchData(text);
                      },
                    ),
                    const SizedBox(height: 15),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 15),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => bulidProductsItem(
                            SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data![index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data!
                              .length,
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
}

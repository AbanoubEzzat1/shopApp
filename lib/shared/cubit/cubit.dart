import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/shop_app/cart_models.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_cart_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/models/shop_app/user_model.dart';
import 'package:shop_app/modules/Cart/cart_screen.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitaialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeBottomNavigationBarItems(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavigationBarItemsState());
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: "Categories",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart,
      ),
      label: "Cart",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
    SittingsScreen(),
  ];
  HomeModel? homeModel;
  Map<int, bool> favorits = {};
  Map<int, bool> cartProducts = {};
  void getHomeData() async {
    emit(ShopLoadingState());
    await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorits.addAll({
          element.id!: element.inFavorites!,
        });
      });
      homeModel!.data!.products.forEach((element) {
        cartProducts.addAll({
          element.id!: element.inCart!,
        });
      });
      // print("=================================");
      // print(favorits.toString());
      emit(ShopSuccessState());
    }).catchError((erorr) {
      print(erorr);
      emit(ShopErorrState(erorr));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() async {
    await DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((erorr) {
      print(erorr);
      emit(ShopErorrCategoriesState(erorr));
    });
  }

  ChangeFavoritsModel? favoritsModel;
  void changeFavoritesData(int productId) async {
    favorits[productId] = !favorits[productId]!;
    emit(ShopChangeFavoritesState());
    await DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoritsModel = ChangeFavoritsModel.fromJson(value.data);
      if (!favoritsModel!.status!) {
        //law fe 8alat yrga3ha blue tane mn nafso w el 3aks
        favorits[productId] = !favorits[productId]!;
      } else {
        getFavoritesData();
      }
      //print(value.data);
      emit(ShopSuccessChangeFavoritesState(favoritsModel));
    }).catchError((erorr) {
      favorits[productId] = !favorits[productId]!;
      emit(ShopErorrChangeFavoritesState(erorr));
      print(erorr);
    });
  }

  FavoritesModel? favoritesModell;
  void getFavoritesData() async {
    emit(ShopLoadingGetFavoritesState());
    await DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModell = FavoritesModel.fromJson(value.data);
      // printFullText("==================***==================");
      // printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((erorr) {
      emit(ShopErorrGetFavoritesState(erorr));
      print(erorr);
    });
  }

  UserModel? userModel;
  void getUserData() async {
    emit(ShopLoadingUserState());
    await DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      print("===============++++++++==================");
      printFullText(userModel!.data!.name!);
      printFullText(userModel!.data!.email!);
      emit(ShopSuccessUserState());
    }).catchError((erorr) {
      print(erorr);
      emit(ShopErorrUserState(erorr));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(UpdateLoadingState());
    await DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      // print("===============++++++++==================");
      // printFullText(userModel!.data!.name!);
      // printFullText(userModel!.data!.email!);
      emit(UpdateSuccessState(userModel!));
    }).catchError((erorr) {
      print(erorr);
      emit(UpdateErorrState(erorr));
    });
  }

  CartModel? cartModel;
  void getCartsData() {
    emit(ShopLoadingCartState());
    DioHelper.getData(
      url: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      //print("++++++++++++++++++++++++++++++++++++++++++++++");
      printFullText(cartModel!.data!.total.toString());

      emit(ShopSuccessCartState());
    }).catchError((erorr) {
      print(erorr);
      emit(ShopErorrCartState(erorr));
    });
  }

  ChangeCartModel? changeCartModel;
  void changeCartData({
    required int productId,
  }) {
    cartProducts[productId] = !cartProducts[productId]!;
    emit(ShopChangeCartState());
    DioHelper.postData(
      url: CARTS,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      if (!changeCartModel!.status!) {
        cartProducts[productId] = !cartProducts[productId]!;
      } else {
        getCartsData();
      }
      print("++++++++++++++++++++++++++++++++++++++++++++++");
      print(changeCartModel!.status.toString());
      emit(ShopSuccessChangeCartState(changeCartModel));
    }).catchError((erorr) {
      cartProducts[productId] = !cartProducts[productId]!;
      print(erorr);
      emit(ShopErorrCartState(erorr));
    });
  }

  void updateCart({
    required int quantity,
  }) {
    emit(UpdateLoadingCartState());
    DioHelper.putData(
      url: UPDATE_CARTS,
      token: token,
      data: {
        'quantity': quantity,
      },
    ).then((value) {
      emit(UpdateSuccessCartState());
    }).catchError((erorr) {
      print(erorr);
      emit(UpdateErorrCartState(erorr));
    });
  }
}

/**
 * ChangeFavoritsModel? favoritsModel;
  void changeFavoritesData(int productId) async {
    favorits[productId] = !favorits[productId]!;
    emit(ShopChangeFavoritesState());
    await DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoritsModel = ChangeFavoritsModel.fromJson(value.data);
      if (!favoritsModel!.status!) {
        //law fe 8alat yrga3ha blue tane mn nafso w el 3aks
        favorits[productId] = !favorits[productId]!;
      } else {
        getFavoritesData();
      }
      //print(value.data);
      emit(ShopSuccessChangeFavoritesState(favoritsModel));
    }).catchError((erorr) {
      favorits[productId] = !favorits[productId]!;
      emit(ShopErorrChangeFavoritesState(erorr));
      print(erorr);
    });
  }
 */












// print("============================================");
      // printFullText(homeModel!.data.banners[0].image);
      // print(homeModel!.data.products[0].image);
      // print(homeModel!.status);
      // print("============================================");
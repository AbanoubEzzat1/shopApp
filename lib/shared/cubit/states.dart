import 'package:shop_app/models/shop_app/change_cart_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/models/shop_app/user_model.dart';

abstract class ShopStates {}

class ShopInitaialState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErorrState extends ShopStates {
  final String erorr;

  ShopErorrState(this.erorr);
}

class ShopChangeBottomNavigationBarItemsState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErorrCategoriesState extends ShopStates {
  final String erorr;

  ShopErorrCategoriesState(this.erorr);
}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritsModel? changeFavoritsModel;

  ShopSuccessChangeFavoritesState(this.changeFavoritsModel);
}

class ShopErorrChangeFavoritesState extends ShopStates {
  final String erorr;

  ShopErorrChangeFavoritesState(this.erorr);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErorrGetFavoritesState extends ShopStates {
  final String erorr;

  ShopErorrGetFavoritesState(this.erorr);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopLoadingUserState extends ShopStates {}

class ShopSuccessUserState extends ShopStates {}

class ShopErorrUserState extends ShopStates {
  final String erorr;

  ShopErorrUserState(this.erorr);
}

class UpdateLoadingState extends ShopStates {}

class UpdateSuccessState extends ShopStates {
  final UserModel userModel;
  UpdateSuccessState(this.userModel);
}

class UpdateErorrState extends ShopStates {
  final String erorr;
  UpdateErorrState(this.erorr);
}

class ShopLoadingCartState extends ShopStates {}

class ShopSuccessCartState extends ShopStates {}

class ShopErorrCartState extends ShopStates {
  final String erorr;

  ShopErorrCartState(this.erorr);
}

class ShopSuccessChangeCartState extends ShopStates {
  final ChangeCartModel? changeCartModel;

  ShopSuccessChangeCartState(this.changeCartModel);
}

class ShopErorrChangeCartState extends ShopStates {
  final String erorr;

  ShopErorrChangeCartState(this.erorr);
}

class ShopChangeCartState extends ShopStates {}

class UpdateLoadingCartState extends ShopStates {}

class UpdateSuccessCartState extends ShopStates {
  // final UserModel userModel;
  // UpdateSuccessCartState(this.userModel);
}

class UpdateErorrCartState extends ShopStates {
  final String erorr;
  UpdateErorrCartState(this.erorr);
}

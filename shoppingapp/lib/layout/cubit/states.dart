import 'package:shoppingapp/models/change_favorite_model.dart';
import 'package:shoppingapp/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSucessChangeFavoriteDataState extends ShopStates {
  final ChangeFavoriteModel model;
  ShopSucessChangeFavoriteDataState(this.model);
}

class ShopLoadingGetFavoriteDataState extends ShopStates {}

class ShopSuccessGetFavoriteDataState extends ShopStates {}

class ShopErrorGetFavoriteDataState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel userModel;

  ShopSuccessUserDataState(this.userModel);
}

class ShopErrorUserDataState extends ShopStates {}

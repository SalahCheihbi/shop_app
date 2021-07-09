import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/layout/cubit/states.dart';
import 'package:shoppingapp/models/categories_model.dart';
import 'package:shoppingapp/models/change_favorite_model.dart';
import 'package:shoppingapp/models/favorite_model.dart';

import 'package:shoppingapp/models/home_model.dart';
import 'package:shoppingapp/models/login_model.dart';
import 'package:shoppingapp/modules/categories/categories_screen.dart';
import 'package:shoppingapp/modules/favorites/favorites_screen.dart';
import 'package:shoppingapp/modules/products/products_screen.dart';
import 'package:shoppingapp/modules/settings/settings_screen.dart';
import 'package:shoppingapp/shared/compontens/constants.dart';
import 'package:shoppingapp/shared/network/end-point.dart';
import 'package:shoppingapp/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      // print(favorites.toString());
      // print(homeModel!.data!.banners[1].image);
      // print(homeModel!.data!.products[1].image);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  late ChangeFavoriteModel changeFavoriteModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'productId': productId},
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.formJson(value.data);
      if (!changeFavoriteModel.status!)
        favorites[productId] = !favorites[productId]!;
      else {
        getFavorites();
      }
      emit(ShopSucessChangeFavoriteDataState(changeFavoriteModel));
    }).catchError((error) {
      print(error.toString());
    });
  }

  late FavoritesModel favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoriteDataState());
    DioHelper.getData(
      url: FAVORITES,
      token: token ?? '',
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoriteDataState());
    }).catchError((error) {
      emit(ShopErrorGetFavoriteDataState());
      print(error.toString());
    });
  }

  late ShopLoginModel shopLoginModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUserDataState(shopLoginModel));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
      print(error.toString());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateDataState());

    DioHelper.putData(
            url: UPDATE,
            data: {'name': name, 'email': email, 'phone': phone},
            token: token)
        .then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopErrorUpdateDataState());
    }).catchError((error) {
      emit(ShopErrorUpdateDataState());
      print(error.toString());
    });
  }
}

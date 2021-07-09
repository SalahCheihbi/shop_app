import 'package:shoppingapp/models/login_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitial extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  final ShopLoginModel shopLoginModel;

  ShopRegisterSuccessState(this.shopLoginModel);
}

class ShopRegisterErrorState extends ShopRegisterState {}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterState {}

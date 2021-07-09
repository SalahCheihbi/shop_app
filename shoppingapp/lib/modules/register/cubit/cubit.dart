import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/models/login_model.dart';
import 'package:shoppingapp/modules/register/cubit/state.dart';
import 'package:shoppingapp/shared/network/end-point.dart';
import 'package:shoppingapp/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitial());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel shopLoginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(shopLoginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState());
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibilty() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}

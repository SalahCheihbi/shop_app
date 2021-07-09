import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/layout/home_layout.dart';
import 'package:shoppingapp/modules/register/cubit/cubit.dart';
import 'package:shoppingapp/modules/register/cubit/state.dart';
import 'package:shoppingapp/shared/compontens/components.dart';
import 'package:shoppingapp/shared/compontens/constants.dart';
import 'package:shoppingapp/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.shopLoginModel.status!) {
              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.shopLoginModel.data!.token)
                  .then((value) {
                token = state.shopLoginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.shopLoginModel.message);
              Fluttertoast.showToast(
                msg: state.shopLoginModel.message!,
                backgroundColor: Colors.red,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                toastLength: Toast.LENGTH_LONG,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFromField(
                            controller: nameController,
                            Label: 'Name',
                            Type: TextInputType.name,
                            prefix: Icons.person,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Name is Empty';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                            controller: emailController,
                            Label: 'Email',
                            Type: TextInputType.emailAddress,
                            prefix: Icons.email,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email is Empty';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                            controller: passwordController,
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            Label: 'Password',
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibilty();
                            },
                            Type: TextInputType.visiblePassword,
                            prefix: Icons.lock_outlined,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password is Empty';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                            controller: phoneController,
                            Label: 'Phone',
                            Type: TextInputType.phone,
                            prefix: Icons.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Phone is Emppty';
                              }
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: 'Register'.toUpperCase()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

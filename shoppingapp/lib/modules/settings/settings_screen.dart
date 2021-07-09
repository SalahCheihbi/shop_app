import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shoppingapp/layout/cubit/cubit.dart';
import 'package:shoppingapp/layout/cubit/states.dart';
import 'package:shoppingapp/shared/compontens/components.dart';
import 'package:shoppingapp/shared/compontens/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var nameController = TextEditingController();

    var emailController = TextEditingController();

    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).shopLoginModel;
          emailController.text = model.data!.email;

          nameController.text = model.data!.name;

          phoneController.text = model.data!.phone;
          return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  ShopCubit.get(context).shopLoginModel != Null,
              widgetBuilder: (context) => Center(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              defaultFromField(
                                  controller: nameController,
                                  Label: 'Name',
                                  Type: TextInputType.name,
                                  prefix: Icons.add,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'name is Empty';
                                    }
                                  }),
                              SizedBox(
                                height: 10.0,
                              ),
                              defaultFromField(
                                  controller: emailController,
                                  Label: 'Email',
                                  Type: TextInputType.emailAddress,
                                  prefix: Icons.email_outlined,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'name is Empty';
                                    }
                                  }),
                              SizedBox(
                                height: 10.0,
                              ),
                              defaultFromField(
                                  controller: phoneController,
                                  Label: 'Phone',
                                  Type: TextInputType.phone,
                                  prefix: Icons.phone,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'name is Empty';
                                    }
                                  }),
                              SizedBox(
                                height: 20.0,
                              ),
                              defaultButton(
                                function: () {
                                  ShopCubit.get(context).updateUserData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text);
                                },
                                text: 'UPDATE',
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    signOut(context);
                                  }
                                },
                                text: 'LOGOUT',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }
}

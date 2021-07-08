import 'package:flutter/material.dart';
import 'package:shoppingapp/shared/compontens/components.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                    Label: 'name',
                    Type: TextInputType.name,
                    prefix: Icons.person,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Name is Empty';
                      }
                    }),
                SizedBox(
                  height: 20.0,
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
                  height: 20.0,
                ),
                defaultFromField(
                    controller: passwordController,
                    Label: 'Password',
                    Type: TextInputType.visiblePassword,
                    prefix: Icons.lock_outlined,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password is Empty';
                      }
                    }),
                SizedBox(
                  height: 20.0,
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
                      if (formKey.currentState!.validate()) {}
                    },
                    text: 'Sign In'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

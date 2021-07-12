import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/layout/cubit/cubit.dart';
import 'package:shoppingapp/layout/cubit/states.dart';
import 'package:shoppingapp/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCartItem(
                  ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => Divider(thickness: .8),
              itemCount:
                  ShopCubit.get(context).categoriesModel!.data!.data.length);
        });
  }

  Widget buildCartItem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model!.image!),
              fit: BoxFit.cover,
              width: 80.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      );
}

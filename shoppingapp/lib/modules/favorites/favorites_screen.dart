import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shoppingapp/layout/cubit/cubit.dart';
import 'package:shoppingapp/layout/cubit/states.dart';
import 'package:shoppingapp/models/favorite_model.dart';

import 'package:shoppingapp/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) => true,
            // state is! ShopLoadingGetFavoriteDataState,
            widgetBuilder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => defaultItem(
                    ShopCubit.get(context).favoritesModel.data!.data![index],
                    context),
                separatorBuilder: (contxt, index) => Divider(
                      height: 20.0,
                      thickness: 15.0,
                    ),
                itemCount:
                    ShopCubit.get(context).favoritesModel.data!.data!.length),
            fallbackBuilder: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget defaultItem(FavoritesData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                    width: 120,
                    height: 120,
                    image: NetworkImage(model.product!.image)),
                Container(
                  color: Colors.black.withOpacity(.8),
                  width: 100,
                  child: Text(
                    'TEST',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.product!.name),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'SSS',
                        style: TextStyle(
                            color: defaultColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'data',
                        style: TextStyle(
                            color: defaultColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: CircleAvatar(
                            child: Icon(
                              Icons.favorite_border_outlined,
                              size: 18.0,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

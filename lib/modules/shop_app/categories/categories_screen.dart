import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api/layouts/shop_app/cubit/state.dart';
import 'package:shop_api/models/shop_app/shop_categories_model.dart';
import 'package:shop_api/shared/components/components.dart';

import '../../../layouts/shop_app/cubit/cubit.dart';

class ShopCategoriesScreen extends StatelessWidget {
  const ShopCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      builder: (context , state){
     var categoriesModel=    ShopAppCubit.get(context).categoriesModel!.data.data;
        return ListView.separated(
            itemBuilder: (context , index )=>
                ConditionalBuilder(condition: State is! ShopAppLoadingCategoriesDataState,
                builder:(context )=>buildCatItem(categoriesModel[index]) ,
                fallback:(context)=> const Center(child: CircularProgressIndicator()) ,),
            separatorBuilder: (context , index )=>myDivider(),
            itemCount: categoriesModel.length);
      },
      listener:(context , state){} ,
    );
  }
  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:  [
        Image(
          image:
          NetworkImage(
              model.image
          ),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 20,),
        Text(
          model.name,
          style: const TextStyle(
              fontSize: 20,

              fontWeight: FontWeight.bold
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}

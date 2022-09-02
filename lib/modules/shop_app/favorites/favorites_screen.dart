import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_api/layouts/shop_app/cubit/state.dart';

import 'package:shop_api/shared/components/components.dart';
import 'package:shop_api/shared/components/constants.dart';

import '../../../models/shop_app/shop_favorites_model.dart';
import '../../../styles/colors.dart';
import '../login/cubit/state.dart';

class ShopFavoritesScreen extends StatelessWidget {
  const ShopFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopAppCubit>(
      create:(context)=> ShopAppCubit()..getFavoritesData(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(

      builder: (context,state){
     ShopAppCubit cubit =  ShopAppCubit.get(context);

       return ConditionalBuilder(
         condition: state is! ShopAppLoadingFavoritesDataState,
         builder: (context)=>  ListView.separated(
         itemBuilder:(context,index)=>
             buildFavoriteItem(
               cubit.favoritesModel!.data.data[index].product,
               context,
             ),
         separatorBuilder: (context,index)=> myDivider(),
         itemCount:  cubit.favoritesModel!.data.data.length),
         fallback: (context)=>const Center(child: CircularProgressIndicator()),

       );
      },
      listener: (context,state)=>{


      },
      ),
    );
  }
  Widget buildFavoriteItem(Product model,context,)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120,
      child: Row(
        children: [
          Stack(

            alignment: AlignmentDirectional.bottomStart,
            children: [
               Image(
                image: NetworkImage(
                   model.image
                ),
                width: 120,
                height: 120,

              ),
               if (model.discount!=0)
                Container(
                  color: Colors.red,
                  padding:const EdgeInsets.symmetric(horizontal: 5,) ,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 8,
                        color: Colors.white
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                 Text(
                   model.name,


                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                     Text(
                       '${model.price.round()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          color:  defaultColor
                      ),
                    ),
                    const SizedBox(width: 5,),
                     if (model.discount!=0)
                       Text(
                         '${model.oldPrice.round()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10,
                            color:  Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    const Spacer(),
                    IconButton(onPressed: (){
                        ShopAppCubit.get(context).changeFavorites(model.id);
                    }, icon:  const CircleAvatar(
                      radius: 15,



                      backgroundColor:   defaultColor,
                      child:Icon(
                        Icons.favorite_border ,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

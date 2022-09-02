import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_api/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_api/layouts/shop_app/cubit/state.dart';
import 'package:shop_api/modules/shop_app/login/cubit/state.dart';

import 'package:shop_api/modules/shop_app/search/search_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      builder:(context , state ){
        var cubit  = ShopAppCubit.get(context);
        return Scaffold(


          appBar: AppBar(
            title: const Text(ShopAppName),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, const ShopSearchScreen());
        }, icon: const Icon(Icons.search),),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index: index);
            },
            currentIndex: cubit.currentIndex,
            items:
            const [

              BottomNavigationBarItem(icon: Icon(Icons.home),
                  label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),
                  label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),
                  label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                  label: 'Settings'),

            ],
          ),
        );
      } ,
   listener:(context , state ){
        if(state is ShopLoginSuccessState){
          ShopAppCubit.get(context).currentIndex = 0;
        }

   } ,
    );
  }
}

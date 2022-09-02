import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_api/layouts/shop_app/cubit/cubit.dart';
import 'package:shop_api/layouts/shop_app/cubit/state.dart';
import 'package:shop_api/models/shop_app/shop_categories_model.dart';
import 'package:shop_api/models/shop_app/shop_home_model.dart';
import 'package:shop_api/shared/components/components.dart';
import 'package:shop_api/styles/colors.dart';


class ShopProductsScreen extends StatelessWidget {
  const ShopProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(

      listener: (context, state) {
        if (state is ShopAppSuccessChangeFavoritesState) {
          if (!state.model.status) {
            showToast(msg: state.model.message, toastStates: ToastStates.ERROR);
          }
          
        }
      },
      builder: (context, state) {


        var homeModel = ShopAppCubit.get(context).homeModel;
        var categoriesModel = ShopAppCubit.get(context).categoriesModel;

        return ConditionalBuilder(
          condition: homeModel != null&& categoriesModel != null,
          builder: (context) => productsBuilder(homeModel!,categoriesModel!,context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
      HomeModel model,
      CategoriesModel categoriesModel,
      context,
      ) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
           const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800
                  ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                   height: 100,
                   child: ListView.separated(
                     physics: const BouncingScrollPhysics(),
                     scrollDirection: Axis.horizontal,
                       shrinkWrap: true,
                       itemBuilder: (context , index)=>buildCategoryItem(
                           categoriesModel.data.data[index]
                       ),
                       separatorBuilder:  (context , index)=>const SizedBox(width: 10,),
                       itemCount: categoriesModel.data.data.length ),
                        ),
                  const SizedBox(height: 20,),
                  const Text('New Products',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
              childAspectRatio: 1 / 1.65,
              mainAxisSpacing: 5,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:List.generate(
                      model.data.products.length,
                 (index) =>
                buildGridProduct(model.data.products[index],context),
              ),
              ),
            ),
           ],
        ),
  );
}

Widget  buildCategoryItem (DataModel model)=> SizedBox(
  width: 100,
  height: 100,
  child: Stack(
    alignment: AlignmentDirectional.bottomStart,
    children:  [
      Image(image:
      NetworkImage(
          model.image
      ),
        width: 100,
        height: 100,
        fit: BoxFit.cover,),
      Container(
        color: Colors.black.withOpacity(.8,),
        width: double.infinity,
        child:  Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],
  ),
);

Widget buildGridProduct (ProductModel model,context) =>

    Container(

  color: Colors.white,
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(
                model.image
            ),
            width: double.infinity,
            height: 200,

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
      Padding(
        padding: const EdgeInsets.all(12.0),
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
                }, icon:  CircleAvatar(
                    radius: 15,


                         backgroundColor: ShopAppCubit.get(context).favorites[model.id]! ?  defaultColor : Colors.grey,
                         child:const Icon(
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
);
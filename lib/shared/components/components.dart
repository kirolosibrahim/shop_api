import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: () {
          return function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required bool isPassword,
  required String lable,
  IconData? prefix,
  IconData? suffix,
  required Function onValidate,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isClickable = true,
  Function? onSuffixPressed,
}) =>
    TextFormField(
      keyboardType: type,
      obscureText: isPassword,
      validator: (String? value) {
        return onValidate(value);
      },
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          return;
        }
      },
      enabled: isClickable,
      controller: controller,
      onFieldSubmitted: (String? value) {
        if (onSubmit != null) {
          onSubmit(value);
        } else {
          return;
        }
      },
      onChanged: (String? value) {
        if (onChange != null) {
          onChange(value);
        } else {
          return;
        }
      },
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: () {
                  return onSuffixPressed!();
                },
              )
            : null,
        prefixIcon: prefix != null ? Icon(prefix) : null,
        labelText: lable,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultTextButton({required Function onPressed, required String text}) =>
    TextButton(
      onPressed: () {
        return onPressed();
      },
      child: Text(text.toUpperCase()),
    );
//Tasks Component
// Widget buildTaskItem(Map model, context) => Dismissible(
//       key: Key(model['id'].toString()),
//       onDismissed: ((direction) {
//         TodoAppCubit.get(context).deleteData(
//           id: model['id'],
//         );
//       }),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 40,
//               child: Text('${model['time']}'),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${model['title']}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '${model['date']}',
//                     style: const TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             IconButton(
//                 onPressed: () {
//                   TodoAppCubit.get(context)
//                       .updateData(status: 'done', id: model['id']);
//                 },
//                 icon: const Icon(
//                   Icons.check_box,
//                   color: Colors.green,
//                 )),
//             IconButton(
//                 onPressed: () {
//                   TodoAppCubit.get(context)
//                       .updateData(status: 'archive', id: model['id']);
//                 },
//                 icon: const Icon(
//                   Icons.archive,
//                   color: Colors.black45,
//                 )),
//           ],
//         ),
//       ),
//     );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

// Widget tasksBuilder({required List<Map> tasksList}) => ConditionalBuilder(
//   condition: tasksList.isNotEmpty  ,
//   builder :(context) => BlocConsumer<TodoAppCubit , TodoAppStates>(
//       listener: (context  , state ){
//       },
//       builder:  (context  , state ){
//         return ListView.separated(
//             itemBuilder: (context , index) => buildTaskItem(tasksList[index],context),
//             separatorBuilder:(context , index)=>myDivider() ,
//             itemCount: tasksList.length);
//       }
//   ),
//   fallback:(context) => Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//
//       children:
//       const [
//         Icon(
//           Icons.menu,
//           size: 100,
//           color: Colors.grey,
//         ),
//         Text(
//           'No Tasks yet ,  Please Add Some Tasks',
//           style: TextStyle(
//             fontWeight: FontWeight.bold ,
//             color: Colors.grey,
//           ),),
//       ],
//     ),
//   ) ,
// );

// Widget buildArticleItem (dynamic article,context) =>InkWell(
//   onTap: ((){
//     navigateTo(context, WebViewScreen(article['url'],));
//   }),
//   child:   Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//         Container(
//           width: 120,
//           height: 120,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10,),
//             image: DecorationImage(
//                 image: NetworkImage(
//                   '${article['urlToImage']}',
//                 ),
//                 fit: BoxFit.cover
//             ),
//
//           ),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           child: Container(
//             height: 120,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 //Title
//                 Expanded(
//                   child: Text(
//                     '${article['title']}',
//                     style:  Theme.of(context).textTheme.bodyText1,
//                     maxLines:2 ,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 //Date
//                 Text(
//                   '${article['publishedAt']}',
//                   style: const TextStyle(
//                     color: Colors.grey,
//
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );

// Widget articleBuilder (list,isSearch) =>ConditionalBuilder(
//     condition: list.length>0 ,
//     builder: (context) =>   ListView.separated(
//       physics: const BouncingScrollPhysics(),
//       itemBuilder: (context, index)=> buildArticleItem(list[index],context),
//       separatorBuilder:  (context, index)=>myDivider(),
//       itemCount: list.length,) ,
//     fallback: (context) =>isSearch ? Container() :  const Center(child: CircularProgressIndicator())
// );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

enum ToastStates { SUCCESS, ERROR, WORNING, NORMAL }

Color chooseToastColor({required ToastStates toastStates}) {
  Color color;
  switch (toastStates) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WORNING:
      color = Colors.amber;
      break;
    case ToastStates.NORMAL:
      color = Colors.white;
      break;
  }
  return color;
}

void showToast({required String msg, required ToastStates toastStates}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(toastStates: toastStates),
      textColor: Colors.white,
      fontSize: 16.0,
    );

//enum ToastStates

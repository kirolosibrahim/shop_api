import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../styles/colors.dart';
import '../login/shop_login_screen.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

var boardController = PageController();

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/onboard_1.jpg',
    title: 'On Board 1 Title',
    body: 'On Board 1 Body',
  ),
  BoardingModel(
    image: 'assets/images/onboard_1.jpg',
    title: 'On Board 2 Title',
    body: 'On Board 2 Body',
  ),
  BoardingModel(
    image: 'assets/images/onboard_1.jpg',
    title: 'On Board 3 Title',
    body: 'On Board 3 Body',
  ),
];

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(onPressed: (){
            submit();
          }, text: 'skip')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: ((index) {
                  if (index == boarding.length - 1) {
                    setState(() {

                        isLast = true;

                    });

                  } else {
                    setState(() {

                      isLast = false;

                    });
                  }
                }),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        activeDotColor: defaultColor,
                        dotWidth: 10,
                        spacing: 5),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: (() {
                      if (isLast) {
                     submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    }),
                    child: const Icon(Icons.arrow_forward),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void submit(){
    CacheHelper.saveData
      (
        key:'onBoarding',
        value: true
    ).then((value) {
      if (value){
        print(value);
        print(value.runtimeType);
        navigateAndFinish(context, ShopLoginScreen());
      }
    }).catchError((error){
      print(error.toString());
    });

  }
}



Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              model.image,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );

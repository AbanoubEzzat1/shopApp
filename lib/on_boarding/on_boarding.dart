import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_auth/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  String image;
  String title;
  String body;
  OnBoardingModel({
    required this.body,
    required this.image,
    required this.title,
  });
}

class OnBoarding extends StatefulWidget {
  OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      body: "Sign up for free",
      image: 'assets/images/onBoarding_1.png',
      title: "Welcome",
    ),
    OnBoardingModel(
      body: "Smart Store",
      image: 'assets/images/onBoarding_2.png',
      title: "browse our hot offers",
    ),
    OnBoardingModel(
      body: "Smart Store",
      image: 'assets/images/onBoarding_3.png',
      title: "buy and get a lot of cashback",
    ),
  ];
  PageController boardcontroller = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                "SKIP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                      ;
                    }
                  },
                  controller: boardcontroller,
                  itemCount: boarding.length,
                  itemBuilder: (context, index) =>
                      buildOnBoardingItem(boarding[index]),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardcontroller,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: deffaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardcontroller.nextPage(
                          duration: const Duration(
                            microseconds: 705,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    );
    navigateAndFinish(
      context,
      LoginScreen(),
    );
  }

  Widget buildOnBoardingItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            model.body,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
}

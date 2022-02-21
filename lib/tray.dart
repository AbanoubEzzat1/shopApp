import 'package:flutter/material.dart';

class OnBoarding {
  String image;
  String title;
  String body;
  OnBoarding({
    required this.body,
    required this.title,
    required this.image,
  });
}

class Trayscreen extends StatefulWidget {
  Trayscreen({Key? key}) : super(key: key);

  @override
  _TrayscreenState createState() => _TrayscreenState();
}

class _TrayscreenState extends State<Trayscreen> {
  List<OnBoarding> boarding = [
    OnBoarding(
      body: 'Screen Body 1',
      title: 'Screen Title 1',
      image: 'assets/images/onboarding_1.jpg',
    ),
    OnBoarding(
      body: 'Screen Body 2',
      title: 'Screen Title 2',
      image: 'assets/images/onboarding_1.jpg',
    ),
    OnBoarding(
      body: 'Screen Body 3',
      title: 'Screen Title 3',
      image: 'assets/images/onboarding_1.jpg',
    ),
  ];
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) =>
                    bulidOnBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  const Text(
                    "Indecator",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ));
  }

  Widget bulidOnBoardItem(OnBoarding model) => Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
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
            const SizedBox(height: 30),
            Text(
              model.body,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
}

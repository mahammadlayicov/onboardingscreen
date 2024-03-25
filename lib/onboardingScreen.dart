import 'package:flutter/material.dart';
import 'package:onboarding_screen_video/home.dart';
import 'package:onboarding_screen_video/onboardingModel.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController _pageController = PageController();
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 150, right: 20, left: 20),
                  child: Column(
                    children: [
                      Image.asset(contents[index].image.toString()),
                      Text(
                        contents[index].title.toString(),
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contents[index].description.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                      contents.length,
                      (index) => Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 10,
                            width: currentIndex == index ? 20 : 10,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10)),
                          ))
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(40),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 205, 11),
                borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              child: Text(
                currentIndex == contents.length - 1 ? "Finish" : "Next",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                } else {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

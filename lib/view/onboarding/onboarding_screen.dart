import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../layout/layout_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Discover Our New Collection',
      'description':
          'Easy shopping for all your needs just in hand',
      'imagePath': 'assets/images/onboarding_images/Onboarding1.png',
    },
    {
      'title': 'Order your style',
      'description':
          'More than a thousand of our bags are available for your luxury',
      'imagePath': 'assets/images/onboarding_images/Onboarding2.png'
    },
    {
      'title': '',
      'description': '', //Favourite brands and hottest trends
      'imagePath': 'assets/images/onboarding_images/Onboarding3.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Image.asset(
                      _pages[index]['imagePath']!,
                      width: double.infinity,
                      height: ScreenUtil().screenHeight,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _pages[index]['title']!,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            _pages[index]['description']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 40.h),
                          //Elevated Button (Next,Get Started)
                          Center(
                            child: SizedBox(
                              width: ScreenUtil().screenWidth/1.8,
                              height: 120.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_currentPage == _pages.length - 1) {
                                    // TODO: Navigate to main app screen
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LayoutScreen(),));
                                  } else {
                                    _controller.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                                child: _currentPage == _pages.length - 1
                                    ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Get Started',
                                            style: TextStyle(fontSize: 60.sp),
                                          ),
                                          Container(
                                            padding:EdgeInsetsDirectional.all(12.r),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text('Next',
                                        style: TextStyle(fontSize: 60.sp),
                                      ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                    //Dot Indicators
                    PositionedDirectional(
                      top: 100.h,
                      start: 40.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: _currentPage == index ? 60.w : 24.w,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

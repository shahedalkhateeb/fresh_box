import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int activePage = 0;

  final List<Map<String, String>> slides = [
    {
      'image': 'images/Onboarding_1.png',
      'title': 'Order Food Around You',
      'desc':
      'When you order, we\'ll hook you up with\n exclusive coupon, specials and rewards',
    },
    {
      'image': 'images/Onboarding_2.png',
      'title': 'Receive the Great Food',
      'desc':
      'You\'ll receive the great food within a hour\n And \n get free delivery credits for every order.',
    },
    {
      'image': 'images/Onboarding_3.png',
      'title': 'Hot Delivery to Home',
      'desc':
      'We make food ordering fast, simple and \n free-no matter if you order online or cash',
    },
  ];

  void goNext() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = activePage == slides.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/text_FreshBox.png',
                    width: 180,
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() {
                    activePage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  return Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      Image.asset(
                        slide['image']!,
                        width: 291,
                        height: 377,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 45),
                      Text(
                        slide['title']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: const Color(0XFF040C22),
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          height: 40 / 25 ,
                          wordSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        slide['desc']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Color(0XFF5C616F),
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          height: 22 / 15,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: activePage == index ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: activePage == index
                        ? Colors.black
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              child: isLastPage
                  ? SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(
                        slides.length - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Skip',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          height: 25 / 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 137,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: goNext,
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          height: 31 / 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_strings.dart';

const Color brandColor = Color(0xFFEF6A57);
const Color greenColor = Color(0xFF5BC439);
const Color greyBg = Color(0xFFF1F1F1);
const Color softShadow = Color(0x14000000);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController bannerController =
  PageController(viewportFraction: 0.83, initialPage: 1);

  int selectedTab = 0;
  int selectedNav = 0;

  final List<String> tabKeys = ['featured', 'nearbyYou', 'trending', 'newest'];

  final List<Map<String, String>> categories = [
    {'key': 'breakfast', 'image': 'images/breakfast.png'},
    {'key': 'lunch', 'image': 'images/lunch.png'},
    {'key': 'dinner', 'image': 'images/dinner.png'},
    {'key': 'snacks', 'image': 'images/snacks.png'},
  ];

  final List<Map<String, String>> banners = [
    {
      'image': 'images/banner1.png',
      'title': 'Fresh Sweet Truth',
      'sub': 'Bakery, Desserts',
      'price': '\$8.99',
    },
    {
      'image': 'images/banner2.png',
      'title': 'Fresh Sweet Truth',
      'sub': 'Bakery, Desserts',
      'price': '\$8.99',
    },
    {
      'image': 'images/banner3.png',
      'title': 'Fresh Sweet Truth',
      'sub': 'Bakery, Desserts',
      'price': '\$8.99',
    },
  ];

  final List<Map<String, String>> popularFoods = [
    {'image': 'images/salad.jpg', 'name': 'Coco berry Salad'},
    {'image': 'images/burger.jpg', 'name': 'Marinated Grilled Burger'},
  ];

  final List<Map<String, String>> restaurants = [
    {'image': 'images/restaurant1.jpg', 'distance': '1.2 Km'},
    {'image': 'images/restaurant2.jpg', 'distance': '3.2 Km'},
    {'image': 'images/restaurant3.jpg', 'distance': '2 Km'},
  ];

  @override
  void dispose() {
    bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    buildHeader(),
                    SizedBox(height: 20.h),
                    buildSearch(),
                    SizedBox(height: 24.h),
                    buildTabs(),
                    SizedBox(height: 24.h),
                    buildCategories(),
                    SizedBox(height: 24.h),
                    buildBanner(),
                    SizedBox(height: 28.h),
                    buildSectionTitle('popularFood'),
                    SizedBox(height: 16.h),
                    buildPopularList(),
                    SizedBox(height: 24.h),
                    buildSectionTitle('nearbyRestaurant'),
                    SizedBox(height: 20.h),
                    for (final r in restaurants)
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          bottom: 20.h,
                        ),
                        child: RestaurantCard(
                          image: r['image']!,
                          distance: r['distance']!,
                        ),
                      ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.tr(context, 'yourLocation'),
                  style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '9224 Jailyn Terrace, block 2',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.keyboard_arrow_down, size: 20.sp),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: toggleLanguage,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: greyBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                isEnglish ? 'AR' : 'EN',
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              'images/avatar.png',
              width: 48.r,
              height: 48.r,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: greyBg,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.search, size: 22.sp, color: Colors.black87),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                AppStrings.tr(context, 'searchHint'),
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.mic, size: 22.sp, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: List.generate(tabKeys.length, (i) {
          final active = selectedTab == i;
          return Padding(
            padding: EdgeInsetsDirectional.only(end: 20.w),
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = i),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppStrings.tr(context, tabKeys[i]),
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                        color: active ? Colors.black : Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 2.h,
                      color: active ? Colors.black : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildCategories() {
    return SizedBox(
      height: 112.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 20.w),
        itemBuilder: (context, i) {
          return SizedBox(
            width: 80.r,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.asset(
                    categories[i]['image']!,
                    width: 80.r,
                    height: 80.r,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.tr(context, categories[i]['key']!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBanner() {
    return SizedBox(
      height: 211.h,
      child: PageView.builder(
        controller: bannerController,
        itemCount: banners.length,
        itemBuilder: (context, i) {
          final b = banners[i];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(b['image']!, fit: BoxFit.cover),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), Color(0x99000000)],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    start: 16.w,
                    bottom: 14.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          b['title']!,
                          style: GoogleFonts.montserrat(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          b['sub']!,
                          style: GoogleFonts.montserrat(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    end: 16.w,
                    bottom: 14.h,
                    child: Text(
                      b['price']!,
                      style: GoogleFonts.montserrat(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSectionTitle(String key) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.tr(context, key),
            style: GoogleFonts.montserrat(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              AppStrings.tr(context, 'seeAll'),
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPopularList() {
    return SizedBox(
      height: 280.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
        itemCount: popularFoods.length,
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemBuilder: (context, i) {
          return PopularFoodCard(
            image: popularFoods[i]['image']!,
            name: popularFoods[i]['name']!,
          );
        },
      ),
    );
  }

  Widget buildBottomNav() {
    final icons = [
      Icons.home_filled,
      Icons.description,
      Icons.favorite,
      Icons.notifications,
    ];

    Widget navItem(int i) {
      final active = selectedNav == i;
      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => selectedNav = i),
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 2.h,
                color: active ? Colors.black : Colors.transparent,
              ),
              Expanded(
                child: Center(
                  child: Icon(
                    icons[i],
                    size: 26.sp,
                    color: active ? Colors.black : const Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 64.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFEAEAEA))),
          ),
          child: Row(
            children: [
              navItem(0),
              navItem(1),
              const Expanded(child: SizedBox()),
              navItem(2),
              navItem(3),
            ],
          ),
        ),
        Positioned(
          top: -24.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 48.r,
              height: 48.r,
              decoration: const BoxDecoration(
                color: brandColor,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: softShadow, blurRadius: 10)],
              ),
              child: Icon(Icons.shopping_bag, color: Colors.white, size: 24.sp),
            ),
          ),
        ),
      ],
    );
  }
}

class PopularFoodCard extends StatelessWidget {
  final String image;
  final String name;

  const PopularFoodCard({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(color: softShadow, blurRadius: 16, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 120.h,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                start: 8.w,
                top: 8.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: brandColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.discount, size: 12.sp, color: Colors.white),
                      SizedBox(width: 3.w),
                      Text(
                        '-50',
                        style: GoogleFonts.montserrat(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.watch_later, size: 18.sp, color: Colors.grey.shade500),
              SizedBox(width: 6.w),
              Text(
                '30 ${AppStrings.tr(context, 'min')}',
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star, size: 18.sp, color: greenColor),
                  SizedBox(width: 4.w),
                  Text(
                    '4.5',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: greenColor,
                    ),
                  ),
                ],
              ),
              Icon(Icons.favorite, size: 24.sp, color: brandColor),
            ],
          ),
        ],
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String image;
  final String distance;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(color: softShadow, blurRadius: 16, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 132.h,
                  fit: BoxFit.cover,
                ),
              ),
              PositionedDirectional(
                start: 10.w,
                bottom: 10.h,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xD9FFFFFF),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    distance,
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Salad Factory',
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 18.sp, color: greenColor),
                  SizedBox(width: 4.w),
                  Text(
                    '4.5',
                    style: GoogleFonts.montserrat(
                      fontSize: 15.sp,
                      color: greenColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '2464 Royal Ln. Mesa',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${AppStrings.tr(context, 'openAt')} 10:00 AM',
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: brandColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
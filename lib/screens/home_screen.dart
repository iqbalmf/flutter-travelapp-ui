
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertravelapp/models/beach_model.dart';
import 'package:fluttertravelapp/models/popular_model.dart';
import 'package:fluttertravelapp/models/recommended_model.dart';
import 'package:fluttertravelapp/screens/detail_screen.dart';
import 'package:fluttertravelapp/widgets/bottom_nav.dart';
import 'package:fluttertravelapp/widgets/custom_tab_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Page Controller
  final _pageController = PageController(viewportFraction: 0.877);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarTravel(),
      body: SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              // Custom Navigation Drawer
              Container(
                height: 57.6,
                margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 57.6,
                      width: 57.6,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        color: Color(0x080a0928),
                      ),
                      child: SvgPicture.asset('assets/svg/icon_drawer.svg'),
                    ),
                    Container(
                      height: 57.6,
                      width: 57.6,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        color: Color(0x080a0928),
                      ),
                      child: SvgPicture.asset('assets/svg/icon_search.svg'),
                    )
                  ],
                ),
              ),

              // Text Widget fot Title
              Padding(
                padding: EdgeInsets.only(top: 35, left: 28.8),
                child: Text(
                  'Explore the Nature',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 45.6, fontWeight: FontWeight.w700),
                ),
              ),

              //Custom Tab bar with custom indicator
              Container(
                height: 30,
                margin: EdgeInsets.only(left: 14, top: 28),
                child: DefaultTabController(
                  length: 4,
                  child: TabBar(
                    labelPadding: EdgeInsets.only(left: 14, right: 14),
                    indicatorPadding: EdgeInsets.only(left: 14, right: 14),
                    isScrollable: true,
                    labelColor: Color(0xFF000000),
                    unselectedLabelColor: Color(0xFF8a8a8a),
                    indicator: RoundedRectangleTabIndicator(
                        color: Colors.black, weight: 2, width: 14),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Text('Recommended'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Popular'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('New Destination'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Hidden Gems'),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //ListView widget
              Container(
                height: 218,
                margin: EdgeInsets.only(top: 16),
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      recommendations.length,
                      (int index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                      recommendedModel:
                                          recommendations[index])));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 28),
                              width: 333,
                              height: 218,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                      recommendations[index].image),
                                ),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                      bottom: 20,
                                      left: 20,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(4.8),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaY: 20,
                                            sigmaX: 20,
                                          ),
                                          child: Container(
                                            height: 30,
                                            padding: EdgeInsets.only(
                                                left: 16.72, right: 14.4),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/svg/icon_location.svg'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  recommendations[index].name,
                                                  style: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          )),
                ),
              ),

              //Dots indicator
              //using smothpageindicator library
              Padding(
                padding: EdgeInsets.only(left: 28, top: 28),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: recommendations.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Color(0xFF8a8a8a),
                      dotColor: Color(0xFFababab),
                      dotHeight: 4,
                      dotWidth: 6,
                      spacing: 4),
                ),
              ),

              //Text widget for popular Categories
              Padding(
                padding: const EdgeInsets.only(top: 48, left: 28, right: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Popular Categories',
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Text(
                      'Show All',
                      style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),

              //ListView for popular Categories section
              Container(
                margin: EdgeInsets.only(top: 30),
                height: 45,
                child: ListView.builder(
                  itemCount: populars.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 28, right: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 19),
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Color(populars[index].color),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 19),
                          Image.asset(
                            populars[index].image,
                            height: 16,
                          ),
                          SizedBox(width: 19)
                        ],
                      ),
                    );
                  },
                ),
              ),

              //ListView for beach section
              Container(
                margin: EdgeInsets.only(top: 28, bottom: 17),
                height: 125,
                child: ListView.builder(
                    itemCount: beaches.length,
                    padding: EdgeInsets.only(left: 28.8, right: 12),
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 125,
                        width: 188,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    beaches[index].image))),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertravelapp/models/recommended_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailScreen extends StatelessWidget {
  final _pageController = PageController();

  final RecommendedModel recommendedModel;

  DetailScreen({Key key, @required this.recommendedModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            //Pageview for image
            PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                  recommendedModel.images.length,
                  (int index) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                recommendedModel.images[index]),
                          ),
                        ),
                      )),
            ),

            //Custom Button
            SafeArea(
              child: Container(
                height: 57.6,
                margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 57.6,
                        width: 57.6,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.6),
                          color: Color(0x080a0928),
                        ),
                        child: SvgPicture.asset('assets/svg/icon_left_arrow.svg'),
                      ),
                    ),
                    Container(
                      height: 57.6,
                      width: 57.6,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.6),
                        color: Color(0x080a0928),
                      ),
                      child: SvgPicture.asset('assets/svg/icon_heart_fill.svg'),
                    )
                  ],
                ),
              ),
            ),

            //Content
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 345,
                margin: EdgeInsets.only(left: 28, bottom: 48, right: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: recommendedModel.images.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: Colors.white,
                          dotColor: Color(0xFFababab),
                          dotHeight: 4,
                          dotWidth: 6,
                          spacing: 4),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 19),
                      child: Text(
                        recommendedModel.tagLine,
                        maxLines: 2,
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 45.6, fontWeight: FontWeight.w700,
                        color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 19),
                      child: Text(
                        recommendedModel.description,
                        maxLines: 3,
                        style: GoogleFonts.lato(
                            fontSize: 19.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start from',
                              style: GoogleFonts.lato(
                                  fontSize: 16.8,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              '\$ ${recommendedModel.price.toString()}',
                              style: GoogleFonts.lato(
                                  fontSize: 21.6,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          height: 62,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 28.8, right: 28.8),
                              child: Text(
                                'Explore Now >>>',
                                style: GoogleFonts.lato(
                                    fontSize: 19.2,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

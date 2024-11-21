import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';



class MoneyReqCarousel extends StatefulWidget {
  List<Schedule>? ScheduleList;

  MoneyReqCarousel({required this.ScheduleList});

  @override
  State<MoneyReqCarousel> createState() => _MoneyReqCarouselState();
}

class _MoneyReqCarouselState extends State<MoneyReqCarousel> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.ScheduleList!.length,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 0.4,
        height: 30,
        reverse: false,
        padEnds: widget.ScheduleList!.isEmpty,
        autoPlay: false,
        scrollPhysics: const BouncingScrollPhysics(),
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final bool isSelected = index == selectedIndex;
        return InkWell(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedIndex = -1; // Reset to default state
              } else {
                selectedIndex = index;
              }
            });
          },
          child: Container(
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected
                  ? colors(context).greyColor300
                  : colors(context).whiteColor,
            ),
            child: Center(
              child: Text(
                widget.ScheduleList![index].name!,
                style: TextStyle(
                  color: isSelected
                      ? colors(context).whiteColor
                      : colors(context).blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Schedule {
  final String? name;

  Schedule({this.name});
}


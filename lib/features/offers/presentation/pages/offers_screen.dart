import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manican/core/components/custom_carousel_slider.dart';
import 'package:manican/core/components/custom_textfiled.dart';
import 'package:manican/features/offers/presentation/bloc/add_offer_bloc/add_offer_bloc.dart';
import 'package:manican/features/offers/presentation/bloc/add_offer_bloc/add_offer_state.dart';
import 'package:manican/features/offers/presentation/bloc/carousel_slider_bloc/carousel_slider_bloc.dart';
import 'package:manican/features/offers/presentation/bloc/carousel_slider_bloc/carousel_slider_state.dart';
import 'package:manican/features/offers/presentation/widgets/add_image_widget.dart';
import 'package:sizer/sizer.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
          height: 100.h,
          width: 20.w,
          color: Colors.grey,
        ),
        Container(
          height: 100.h,
          width: 80.w,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Offers",
                  // style: GoogleFonts.glegoo(
                  //   fontSize: 32,
                  //   fontWeight: FontWeight.w700,
                  // ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                BlocBuilder<CarouselSliderBloc, CustomCarouselSliderState>(
                  builder: (context, state) {
                    var bloc = BlocProvider.of<CarouselSliderBloc>(context);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomCarouselSlider(
                          images: bloc.image,
                          initpage: bloc.initpage,
                          carouselController: bloc.carouselController,
                          onPressedNext: () {
                            bloc.nextCarousel();
                          },
                          onPressedPrevious: () {
                            bloc.previousCarousel();
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  height: 0.7.h,
                  width: 100.w,
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocBuilder<AddOfferBloc, AddOfferState>(
                  builder: (context, state) {
                    var bloc = BlocProvider.of<AddOfferBloc>(context);
                    return AddOfferWidget(bloc: bloc);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class AddOfferWidget extends StatelessWidget {
  const AddOfferWidget({
    super.key,
    required this.bloc,
  });

  final AddOfferBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                CustomTextFiled(hintText: 'Title', controller: bloc.title),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextFiled(
                    hintText: 'Description', controller: bloc.description),
              ],
            ),
          ),
          Expanded(
              child: SizedBox(
            child: Row(
              children: [
                const Expanded(flex: 2, child: SizedBox()),
                AddImageWidget(bloc: bloc),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

// // import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:manicann/features/offers/presentation/bloc/carousel_slider_bloc/carousel_slider_state.dart';

// class CarouselSliderBloc extends Cubit<CustomCarouselSliderState> {
//   // CarouselController carouselController = CarouselController();
//   int initpage = 0;

//   List<String> image = [
//     'https://media-cdn.tripadvisor.com/media/photo-s/01/53/c2/e9/damascus.jpg',
//     'https://i.pinimg.com/originals/bf/2a/87/bf2a8783b8ea261850c2c38c769d17d9.jpg',
//     'https://i.pinimg.com/originals/b6/98/c3/b698c3c5f7055a6f6572479a80fcce20.jpg'
//   ];

//   CarouselSliderBloc() : super(CarouselSliderStateInitial()) {
//     initpage = image.length ~/ 2;
//   }

//   nextCarousel() {
//     carouselController.nextPage();
//     initpage++;
//     print('I============$initpage');
//     emit(DecrementCarouselSliderState());
//   }

//   previousCarousel() {
//     carouselController.previousPage();
//     initpage--;
//     print('P============$initpage');
//     emit(DecrementCarouselSliderState());
//   }
// }

import 'package:manicann/core/error/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'حدث خطأ ما إثناء جلب المعلومات';
    case EmptyCacheFailure:
      return 'EMPTY_CACHE_FAILURE_MESSAGE';
    case OfflineFailure:
      return 'خطأ في الاتصال بالانترنت ';
    default:
      return "خطأ غير متوقع أعد المحاولة لا حقاً";
  }
}

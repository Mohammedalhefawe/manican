import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10.h),
          const Icon(
            Icons.description_outlined,
            size: 100.0,
            color: Colors.grey,
          ),
          SizedBox(height: 5.h),
          const Text(
            'لا يوجد بيانات',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 5.h),
          const Text(
            'لا يوجد بيانات متاحة لإظهارها , يمكنك إضافة البيانات الآن ',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}

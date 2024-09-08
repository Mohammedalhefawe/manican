import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WaitUpdateScreen extends StatelessWidget {
  const WaitUpdateScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
        height: 100.h,
        width: 100.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.hourglass_empty,
                size: 50,
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'We are working hard on the next version. Stay tuned!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Glegoo",
                  fontSize: 20,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// <!DOCTYPE html>
// <html>
// <head>
//   <!--
//     If you are serving your web app in a path other than the root, change the
//     href value below to reflect the base path you are serving from.

//     The path provided below has to start and end with a slash "/" in order for
//     it to work correctly.

//     For more details:
//     * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base

//     This is a placeholder for base href that will be replaced by the value of
//     the `--base-href` argument provided to `flutter build`.
//   -->
//   <base href="$FLUTTER_BASE_HREF">

//   <meta charset="UTF-8">
//   <meta content="IE=Edge" http-equiv="X-UA-Compatible">
//   <meta name="description" content="A new Flutter project.">

//   <!-- iOS meta tags & icons -->
//   <meta name="apple-mobile-web-app-capable" content="yes">
//   <meta name="apple-mobile-web-app-status-bar-style" content="black">
//   <meta name="apple-mobile-web-app-title" content="manicannn">
//   <link rel="apple-touch-icon" href="icons/Icon-192.png">

//   <!-- Favicon -->
//   <link rel="icon" type="image/png" href="favicon.png"/>

//   <title>manicannn</title>
//   <link rel="manifest" href="manifest.json">
//   <script>
//     // The value below is injected by flutter build, do not touch.
//     const flutter_service_worker_version = null;
// </script>
// </head>
// <body>
//   <!-- <script src="flutter_bootstrap.js" async></script> -->
//   <script>
//     window.addEventListener('load', function(ev) {
//       // Download main.dart.js
//       _flutter.loader.load({
//         serviceWorker: {
//           serviceWorkerVersion: serviceWorkerVersion,
//         },
//         onEntrypointLoaded: function(engineInitializer) {
//           engineInitializer.initializeEngine().then(function(appRunner) {
//             appRunner.runApp();
//           });
//         }
//       });
//     });
//   </script>
// </body>
// </html>

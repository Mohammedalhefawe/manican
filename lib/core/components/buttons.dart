import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';

Widget myButton({
  required Color backgroundColor,
  required String text,
  required void Function()? onPressed,
  String fontFamily = "Cairo",
  FontWeight fontWeight = FontWeight.bold,
  double fontSize = 11.0,
  Color textColor = Colors.black,
  Color borderColor = mainYellowColor,
  double borderRadius = 10.0,
  double height = 40.0,
  double width = 125.0,
  double horizontalPadding = 8.0,
  double verticalPadding = 4.0,
  double elevation = 5,
  bool hasBorder = true,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: Material(
        color: Colors.transparent,
        // elevation: elevation,
        // borderRadius: BorderRadiusDirectional.circular(borderRadius),
        child: MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: hasBorder
                ? BorderSide(color: borderColor, width: 1.5)
                : BorderSide.none,
            borderRadius: BorderRadiusDirectional.circular(borderRadius),
          ),
          onPressed: onPressed,
          color: backgroundColor,
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          focusColor: backgroundColor.withOpacity(0.8),
          splashColor: backgroundColor.withOpacity(0.8),
          textColor: textColor,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: "Cairo",
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );

// Widget myDropDownMenuButton({
//   required Color borderColor,
//   required void Function(Text? text)? onChanged,
//   required Text? value,
//   String fontFamily = "Cairo",
//   FontWeight fontWeight = FontWeight.w600,
//   double fontSize = 11.0,
//   Color textColor = blackColor,
//   double borderRadius = 10.0,
//   double height = 40.0,
//   double width = 125.0,
//   double horizontalPadding = 8.0,
//   double verticalPadding = 4.0,
//   double elevation = 5,
// }) {
//   return Material(
//     borderRadius: BorderRadiusDirectional.circular(borderRadius + 1),
//     elevation: elevation,
//     child: Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadiusDirectional.circular(borderRadius + 1),
//         color: mainYellowColor,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(1.0),
//         child: Container(
//           width: width - 2,
//           height: height - 2,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadiusDirectional.circular(borderRadius),
//             color: whiteColor,
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton(
//               padding: const EdgeInsets.only(left: 18, right: 10),
//               items: testList,
//               onChanged: onChanged,
//               borderRadius: BorderRadius.circular(borderRadius),
//               style: TextStyle(
//                 color: blackColor,
//                 fontFamily: fontFamily,
//                 fontSize: fontSize,
//                 fontWeight: fontWeight,
//               ),
//               alignment: Alignment.centerLeft,
//               icon: const Row(
//                 children: [
//                   SizedBox(
//                     width: 2,
//                   ),
//                   Icon(Icons.arrow_drop_down, size: 26, color: mainYellowColor),
//                 ],
//               ),
//               value: value,
//               dropdownColor: lightGrey,
//               hint: Text(
//                 testList[0].value!.data!,
//                 style: TextStyle(
//                   color: blackColor,
//                   fontFamily: fontFamily,
//                   fontSize: fontSize,
//                   fontWeight: fontWeight,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

List<DropdownMenuItem<Text>> testList = [
  const DropdownMenuItem<Text>(
    value: Text("Newest"),
    child: Text("Newest"),
  ),
  const DropdownMenuItem<Text>(
    value: Text("Oldest"),
    child: Text("Oldest"),
  ),
  const DropdownMenuItem<Text>(
    value: Text("Alphabet"),
    child: Text("Alphabet"),
  ),
];

class MyIconButton extends StatefulWidget {
  final IconData icon;
  final Color mainColor;
  final Color hoverColor;
  final double iconSize;
  final Function()? onPressed;

  const MyIconButton({
    super.key,
    required this.icon,
    required this.mainColor,
    required this.hoverColor,
    required this.iconSize,
    required this.onPressed,
  });
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _MyIconButtonState createState() => _MyIconButtonState(
        icon: icon,
        mainColor: mainColor,
        hoverColor: hoverColor,
        iconSize: iconSize,
        onPressed: onPressed,
      );
}

class _MyIconButtonState extends State<MyIconButton> {
  bool _isHovering = false;
  final IconData icon;
  final Color mainColor;
  final Color hoverColor;
  final double iconSize;
  final Function()? onPressed;

  _MyIconButtonState({
    required this.icon,
    required this.mainColor,
    required this.hoverColor,
    required this.iconSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          icon,
          size: iconSize,
          color: _isHovering ? hoverColor : mainColor,
        ),
      ),
    );
  }
}

class MyTextButton extends StatefulWidget {
  final Text text;
  final Color mainColor;
  final Color hoverColor;
  final Function()? onPressed;

  const MyTextButton({
    super.key,
    required this.text,
    required this.mainColor,
    required this.hoverColor,
    required this.onPressed,
  });
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _MyTextButtonState createState() => _MyTextButtonState(
        text: text,
        mainColor: mainColor,
        hoverColor: hoverColor,
        onPressed: onPressed,
      );
}

class _MyTextButtonState extends State<MyTextButton> {
  bool _isHovering = false;
  final Text text;
  final Color mainColor;
  final Color hoverColor;
  final Function()? onPressed;

  _MyTextButtonState({
    required this.text,
    required this.mainColor,
    required this.hoverColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          text.data!,
          style: TextStyle(
            color: _isHovering ? hoverColor : mainColor,
            fontSize: text.style?.fontSize,
            fontFamily: text.style?.fontFamily,
            fontWeight: text.style?.fontWeight,
            decoration: text.style?.decoration,
            decorationColor: text.style?.decorationColor,
          ),
        ),
      ),
    );
  }
}

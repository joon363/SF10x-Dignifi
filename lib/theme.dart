import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF807ED5);
const Color primaryColorLight = Color(0xFFB3B2DF);
const Color primaryColorDark = Color(0xFF5C58C7);

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      fontFamily: "OpenSans",
      colorSchemeSeed: Colors.white,
      canvasColor: Colors.white,
      dividerColor: Colors.white,
      indicatorColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      unselectedWidgetColor: Colors.white,
      dialogTheme: DialogThemeData(backgroundColor: Colors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(Colors.white),
        checkColor: WidgetStateProperty.all(Colors.white),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(WidgetState.pressed)) {
              return primaryColorLight; // 누르고 있을 때 색
            }
            return null;
          },
        ),
      ),
    );
  }
}

const Color textBlackColor = Color(0xFF1B1B1B);
const Color textGrayColor = Color(0xFF707070);
const Color textWhiteColor = Color(0xFFF5F5F7);
const Color boxGrayColor = Color(0xFFF5F5F7);
const Color boxBlueColor = Color(0xFFE4EBF5);
const Color buttonGrayColor = Color(0xFFF5F5F7);
const Color dividerNormal = Color(0xFFC7C7C7);
const Color dividerStrong = Color(0xFF8D8D8D);
const Color warningColor = Color(0xFFFA8219);
const Color errorColor = Color(0xFFE60000);

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);
const double defaultElevation = 6.0;


final BoxDecoration primaryBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  color: primaryColor,
);

final BoxDecoration grayBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(defaultBorderRadius),
  color: Colors.white,
  border: Border.all(color: dividerNormal, width: 1),
);


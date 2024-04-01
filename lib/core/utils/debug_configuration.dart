import 'package:flutter/foundation.dart';

/// Dev purpose only
class DebugConfiguration {
  ///Always use kDebugMode for isDebug, and use && operator to turn off
  static bool isDebugDummyData = isDebug;
  static bool isDebug = kDebugMode && true;
  static bool useLocalForString = true;
  static bool isInClientRelease = kDebugMode;
  static bool showMissingDesign = false;
  static bool showUpcomingFeature = true;

  static String difficultPassword = "M1cB@@kA^r";

  static String testToken = lmsToken;
  static String dummyPassword = "Test@@123";

  ///Get new token by joy@mailinator.com
  static String lmsToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjgzMjg0NzMyLCJleHAiOjE2ODMzNzExMzJ9.ChCGfhjvwDvye_TYyp3T_uqx3iWHi85Cq0py4lfXYxo";
  static String qaToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzgsImlhdCI6MTY3OTkxNjI0MCwiZXhwIjoxNjgwMDAyNjQwfQ.LlKD1DNzduvF86GZ6GxfIIdpJ4y_uwxiDnydaVuan7g";

  static String loginDevEmail = "mayank31@dev.com";
  static String loginDevMobile = "8800773001";
}

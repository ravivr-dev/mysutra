class AppConfiguration {
  static const String appName = "LinkOMed";
  static const String stripeMerchantIdentifier = "acct_1IL78lHdO2c7e2jg";
  static const String stripeScheme = "flutterstripe";
  static const List<String> languageSupport = ['en'];
  static const String devAppUrl =
      "https://4jeizb3r91.execute-api.eu-west-2.amazonaws.com/dev";
  static const int mobileNumberMaxLength = 10;
  static const int passwordLength = 5;
  static const int otpLength = 4;
  static final DateTime initialDate = DateTime(1950);
  static final DateTime firstDate = DateTime(1950);
  static const int splashSeconds = 4;
  static DateTime currentTime = DateTime.now();

  /// Google Detect language Url
  static const String detectLanguageGCPUrl =
      "https://translation.googleapis.com/language/translate/v2/detect";

  /// Google Translate Language Url
  static const String translateLanguageGCPUrl =
      "https://translation.googleapis.com/language/translate/v2";
  static const String initStripeWithPublishKey =
      "pk_test_51IL78lHdO2c7e2jgzA5kJE03RS3cXiyeMH9ToKnK6eIVrkridBONFx2F5b1P7sCKoFnhEmpqnojBPuukSZQdjA7S00GE5Ljhtq";

  static const int maxCharLength = 2000;
  static const String cloudServeryKey =
      "AAAACQMROX8:APA91bEqswlFBEdwWuFsA-7csUKPkHFapSvgUtJiXe7PT_KZEJmyx2u2lyRBuxGFwY3lb5cUJ4tBV2Uyjff_T60JP99xKuUIB58mR7lZk4Mhk8khhXtxdpfsW5gmxXL7jKmkAVWl7MEN";
}

class CacheConfiguration {
  static const bool cachePost = true;
}

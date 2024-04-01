import 'package:ailoitte_components/ailoitte_components.dart';

class ComponentLocalDataSource extends AiloitteLocalDataSource{
  final AiloitteSharedPref sharedPref;
  //final DBProvider dbProvider;

  ComponentLocalDataSource({required this.sharedPref,
    //required this.dbProvider,
  }) : super(sharedPref: sharedPref,
      //dbProvider: dbProvider
  );

  ///Example:
  // @override
  // void fcmTokenPassedToServer() {
  //   sharedPref.fcmTokenPassedToServer();
  // }
}
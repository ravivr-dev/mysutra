import "dart:developer" as devtool show log;

extension Log on Object {
  void log({String? name}) => devtool.log(toString(), name: name ?? 'Log');
}

class AppHelper {}

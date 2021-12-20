enum Routes {
  initial,
  // home,
  splash,
  ops,
  uploadcsv,
}

extension RoutesExt on Routes {
  String get caminho {
    switch (this) {
      case Routes.initial:
        return "/";
      // case Routes.home:
      //   return "/home";
      case Routes.ops:
        return "/ops";
      case Routes.splash:
        return "/splash";
      case Routes.uploadcsv:
        return "/uploadcsv";
    }
  }
}

enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'TMDB client DEV';
      case Flavor.prod:
        return 'TMDB client';
      default:
        return 'title';
    }
  }
}

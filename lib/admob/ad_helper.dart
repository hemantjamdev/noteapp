/*
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  // static String testId = 'ca-app-pub-3940256099942544/6300978111';
  static String noteListBannerId = "ca-app-pub-8064702179639632~6351395550";
  static String noteAddBannerId = 'ca-app-pub-8064702179639632/9420960767';
  static String recycleBinBannerId = 'ca-app-pub-8064702179639632/7257831857';
  static String finalDeleteBannerId = 'ca-app-pub-8064702179639632/3318586840';

  static late BannerAd noteListBanner;
  static late BannerAd noteAddBanner;
  static late BannerAd binBanner;
  static late BannerAd finalDeleteBanner;

  static void initializeAd() {
    noteListBannerAd();
    noteAddBannerAd();
    binBannerAd();
    finalDeleteAd();
  }

  static void noteListBannerAd() async {
    noteListBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: noteListBannerId,
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdClosed: (ad) {},
            onAdFailedToLoad: (ad, err) {}),
        request: const AdRequest());
    await noteListBanner.load();
  }

  static void noteAddBannerAd() async {
    noteAddBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: noteAddBannerId,
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdClosed: (ad) {},
            onAdFailedToLoad: (ad, err) {}),
        request: const AdRequest());
    await noteAddBanner.load();
  }

  static void binBannerAd() async {
    binBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: recycleBinBannerId,
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdClosed: (ad) {},
            onAdFailedToLoad: (ad, err) {}),
        request: const AdRequest());
    await binBanner.load();
  }

  static void finalDeleteAd() async {
    finalDeleteBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: finalDeleteBannerId,
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdClosed: (ad) {},
            onAdFailedToLoad: (ad, err) {}),
        request: const AdRequest());
    await finalDeleteBanner.load();
  }
}
*/

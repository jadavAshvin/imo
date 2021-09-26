import 'package:flt_imo/Service/projectService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DashboardController extends GetxController {
  var isLoading = true.obs;
  BannerAd? bannerAd;

  var piedata = [
    new Task('Location', 0, locationColor),
    new Task('Inventory', 0, inventoryColor),
    new Task('Boxes', 0, boxesColor),
    new Task('Items', 0, itemColor),
  ];
  @override
  void onInit() {
    super.onInit();
    projectStats();
    bannerAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        onAdImpression: (Ad ad) => print('$BannerAd onApplicationExit.'),
      ),
    );

    bannerAd!.load();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    bannerAd = null;

    super.dispose();
  }

  Future<void> getRefreshData() async {
    projectStats();
  }

  projectStats() async {
    isLoading(true);
    await ProjectService.projectStatsApi(AppConstants.PROJECT.id.toString()).then((response) {
      if (response != null) {
        var res = response.body;
        piedata[0].taskvalue = res["locationsCount"];
        piedata[1].taskvalue = res["inventoriesCount"];
        piedata[2].taskvalue = res["boxesCount"];
        piedata[3].taskvalue = res["itemsCount"];
      }
    });
    isLoading(false);
  }
}

class Task {
  String task;
  int? taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

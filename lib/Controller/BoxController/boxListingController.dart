import 'dart:convert';

import 'package:flt_imo/Models/BoxModel.dart';
import 'package:flt_imo/Service/boxService.dart';
import 'package:flt_imo/Service/inventoryService.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BoxesListController extends GetxController {
  var isLoading = true.obs;
  List<Box> boxList = List<Box>.empty(growable: true).obs;
  List<Box> boxListForDisplay = List<Box>.empty(growable: true).obs;
  BannerAd? bannerAd;
  @override
  void onInit() {
    super.onInit();
    getboxesList();
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

  getboxes(id) async {
    isLoading(true);
    await InventoryService.getInventories(id).then((response) {
      if (response != null) {
        var b = boxFromJson(jsonEncode(response.body["boxes"]));
        boxList = b;
        boxListForDisplay = boxList;
      } else {
        boxList = [];
        boxListForDisplay = boxList;
      }
    });
    isLoading(false);
  }

  getboxesList() async {
    isLoading(true);
    await BoxService.boxesListApi().then((response) {
      if (response != null) {
        var b = boxFromJson(jsonEncode(response.body));
        boxList = b;
        boxListForDisplay = boxList;
      } else {
        boxList = [];
        boxListForDisplay = boxList;
      }
    });
    isLoading(false);
  }

  Future<void> boxFuture() async {
    getboxesList();
  }
}

import 'dart:convert';

import 'package:flt_imo/Models/projectModel.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flt_imo/Service/projectService.dart';
import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyProjectController extends GetxController {
  var isLoading = true.obs;
  BannerAd? bannerAd;
  List<Project> project = List<Project>.empty(growable: true).obs;
  List<Project> projectForDisplay = List<Project>.empty(growable: true).obs;
  @override
  void onInit() {
    super.onInit();
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
    super.dispose();
    bannerAd?.dispose();
    bannerAd = null;
  }

  getProject() async {
    isLoading(true);
    await ProjectService.projectListApi().then((response) {
      if (response != null) {
        project = projectFromJson(jsonEncode(response.body));
        projectForDisplay = project;
      } else {
        project = [];
        projectForDisplay = project;
      }
    });
    isLoading(false);
  }

  Future<void> getRefreshData() async {
    getProject();
  }

  deleteProject(deleteid) {
    Get.back();
    Get.defaultDialog(title: "Deleting", content: Center(child: CircularProgressIndicator()), barrierDismissible: false);
    ProjectService.deleteProjectApi(deleteid).then((response) {
      if (response != null) {
        snackBarBack(title: txtSuccess, description: "Project deleted Successfully").then((r) {
          Get.back();
          getProject();
        });
      }
    });
  }
}

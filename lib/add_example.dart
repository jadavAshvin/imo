import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// ca-app-pub-7629926756130020~2941095519
// ca-app-pub-7629926756130020/5828921223

class Mapp extends StatefulWidget {
  @override
  _MappState createState() => _MappState();
}

class _MappState extends State<Mapp> {
  BannerAd? _bannerAd;
  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
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

    _bannerAd!.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: _bannerAd!);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Ads"),
      ),
      bottomSheet: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Container(
            alignment: Alignment.center,
            child: adWidget,
            width: MediaQuery.of(context).size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}

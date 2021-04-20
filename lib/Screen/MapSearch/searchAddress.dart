import 'package:flt_imo/Utils/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SearchAddress extends StatefulWidget {
  @override
  _SearchAddressState createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  static final kInitialPosition = LatLng(23.001145, 72.548124);
  PickResult selectedPlace;

  static double latitude = 23.001145;
  static double longitude = 72.548124;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          setMapPicker(),
          // selectedPlace == null ? Container() : Text(selectedPlace.formattedAddress ?? ""),
          //   setButton(context)
        ],
      ),
    );
  }

  Widget setGooglemapView(BuildContext context) {
    return Container(
      //  padding:EdgeInsets.only(  top: 180.0),
      child: GoogleMap(
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: cameraPosition,
        onCameraMove: ((_position) => _updatePosition(_position)),
      ),
    );
  }

  void _updatePosition(CameraPosition _position) async {
    geolocator.Position newMarkerPosition = geolocator.Position(latitude: _position.target.latitude, longitude: _position.target.longitude);
    setSingleLog("Latitude : $latitude");
    setSingleLog("Latitude : ${newMarkerPosition.latitude}");
    // addLatitude=newMarkerPosition.latitude;
    //   addLongtitude=newMarkerPosition.longitude;

    setState(() {});
  }

  Widget setMapPicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: PlacePicker(
        apiKey: "AIzaSyBfDVVDXdye28xKpRZ7P4LFkmQi9f0xnrM",
        initialPosition: kInitialPosition,
        useCurrentLocation: true,
        selectInitialPosition: true,

        //usePlaceDetailSearch: true,
        onPlacePicked: (result) {
          selectedPlace = result;
          Get.back();
          setState(() {});
        },
        //forceSearchOnZoomChanged: true,
        //automaticallyImplyAppBarLeading: false,
        //autocompleteLanguage: "ko",
        //region: 'au',
        //selectInitialPosition: true,
        selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
          print("state: $state, isSearchBarFocused: $isSearchBarFocused");
          return isSearchBarFocused
              ? Container()
              : FloatingCard(
                  bottomPosition: 0.0,
                  // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                  leftPosition: 0.0,
                  rightPosition: 0.0,
                  width: 500,
                  borderRadius: BorderRadius.circular(5.0),
                  child: state == SearchingState.Searching
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          child: InkWell(
                            onTap: () {
                              print("Selected lat   : ${selectedPlace.geometry.location.lat}");
                              print("Selected  long  : ${selectedPlace.geometry.location.lng}");
                              print("Selected address  : ${selectedPlace.formattedAddress}");
                              AppConstants.LAT = selectedPlace.geometry.location.lat.toString();
                              AppConstants.LONG = selectedPlace.geometry.location.lng.toString();
                              AppConstants.ADDRESS = selectedPlace.formattedAddress;
                              Get.back(result: true);
                            },
                            child: Container(
                              height: 55.0,
                              child: Center(
                                child: Text(txtOk.tr,
                                    style: Theme.of(context).textTheme.headline1.copyWith(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        )),
                              ),
                              decoration: new BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                          ),
                        ), /*RaisedButton(
                          child: Text("Pick Here"),
                          onPressed: () {
                            print("do something with [selectedPlace] data  : ${selectedPlace.formattedAddress }");
                           // Navigator.of(context).pop();
                          },
                        )*/
                );
        },
      ),
    );
  }

  Widget setButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(20.0),
            alignment: Alignment.bottomCenter,
            height: 50.0,
            child: Center(
              child: Text(txtOk,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      )),
            ),
            decoration: new BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget setBackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Icon(
          Icons.arrow_back,
          size: 25.0,
          color: Colors.black,
        ),
      ),
    );
  }
}

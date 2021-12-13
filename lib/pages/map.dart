import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/models/regionaldata.model.dart';
import 'package:toursy_flutter_revamp/services/regionaldataservice.dart';
import 'package:toursy_flutter_revamp/services/topattractionsservice.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController? mapController;
  LatLng _center = LatLng(18.8724059,-69.913995);
  Set<Marker> _markers = Set<Marker>();
  double attractionPillPosition = -200;
  AttractionModel? currentAttraction;
  List<AttractionModel>? attractionList;
  BitmapDescriptor? defaultMarker;
  BitmapDescriptor? selectedMarker;
  

  @override
  void initState() {
    super.initState();

    RegionalDataService regionalDataService = Provider.of<RegionalDataService>(context, listen: false);
    attractionList = regionalDataService.getAllAttractions();
    currentAttraction = attractionList!.first;

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, './assets/imgs/toursy_pin.png').then((value) {
      defaultMarker = value;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, './assets/imgs/toursy_pin_selected.png').then((value) {
      selectedMarker = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        GoogleMap(
            markers: _markers,
            mapType: MapType.normal,
            onCameraMove: _onCameraMove,
            initialCameraPosition: 
            CameraPosition(
              target: _center,
              bearing: 0,
              zoom: 7.0),
            onMapCreated: onMapCreated,
            onTap: (LatLng location) {
              setState(() {
                attractionPillPosition = -200;
                // _markers.forEach((m) {
                //   //m.icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/imgs/toursy_pin.png');
                // });
              });
            }),
        AnimatedPositioned(
            bottom: attractionPillPosition,
            right: 0,
            left: 0,
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AttractionDetails(currentAttraction: currentAttraction))
                  // );
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(blurRadius: 20, offset: Offset.zero, color: Colors.grey.withOpacity(0.5))
                      ]
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                      ),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FadeInImage.assetNetwork(
                              placeholder: './assets/imgs/toursybg.png',
                              image: currentAttraction!.img!,
                              width: 100,
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 500),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(currentAttraction!.name!, style: TextStyle(color: Colors.green)),
                                    Text(currentAttraction!.province!, style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              padding: const EdgeInsets.all(2.5),
                              width: 40,
                              height: 40,
                              child: Image.asset('./assets/imgs/main_logo.png', width: 40, height: 40),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
            )
          )
      ],
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    for(var attraction in attractionList!) {
      setState(() {
        _markers.add(
        Marker(
          markerId: MarkerId(attraction.id!),
          position: LatLng(attraction.location!.lat!, attraction.location!.lng!),
          onTap: () {
            setState(() {
              currentAttraction = attraction;
              attractionPillPosition = 0;
              
              _markers.forEach((m) {
                //m..
                // m.icon = 
                // m.markerId.value == currentAttraction!.id ? 
                // await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/toursy_pin_selected.png') : 
                // await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/toursy_pin.png');
              });
            });
          },
          icon: defaultMarker!
          )
        );
      });
    }
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
  }
}
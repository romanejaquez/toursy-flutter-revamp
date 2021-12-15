import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';
import 'package:toursy_flutter_revamp/services/regionaldataservice.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';
import 'package:toursy_flutter_revamp/widgets/toursymaplocatorbutton.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController? mapController;
  LatLng _center = const LatLng(18.8724059,-69.913995);
  Set<Marker>? _markers = <Marker>{};
  double attractionPillPosition = -200;
  AttractionModel? currentAttraction;
  List<AttractionModel>? attractionList;
  BitmapDescriptor? defaultMarker;
  BitmapDescriptor? selectedMarker;
  AttractionModel? defaultAttraction;
  AttractionModel? viewOnMap;
  bool loadingComplete = false;
  double loadingPositionOn = 0.0;
  double loadingPositionOff = 0.0;
  AttractionSelectionService? attractionSelectionService;

  @override
  void initState() {
    super.initState();

    attractionSelectionService = Provider.of<AttractionSelectionService>(context, listen: false);
    viewOnMap = attractionSelectionService!.viewAttractionOnMap;

    if (viewOnMap != null) {
      currentAttraction = viewOnMap;
    }
    else {
      RegionalDataService regionalDataService = Provider.of<RegionalDataService>(context, listen: false);
      attractionList = regionalDataService.getAllAttractions();

      defaultAttraction = attractionList!.first;
      currentAttraction = AttractionModel(
        img: defaultAttraction!.img!,
        id: '',
        name: defaultAttraction!.name!,
        description: defaultAttraction!.description!,
        province: defaultAttraction!.province!,
      );
    }

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, './assets/imgs/toursy_pin.png').then((value) {
      defaultMarker = value;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, './assets/imgs/toursy_pin_selected.png').then((value) {
      selectedMarker = value;
    });
  }

  void generateMarkers() {
    var localMarkers = <Marker>{};

    if (viewOnMap != null) {
      attractionPillPosition = 100;

      _center = LatLng(viewOnMap!.location!.lat!, viewOnMap!.location!.lng!);
      localMarkers.add(
        Marker(
          markerId: MarkerId(viewOnMap!.id!),
          position: LatLng(viewOnMap!.location!.lat!, viewOnMap!.location!.lng!),
          icon: selectedMarker!
          )
      );
    }
    else {
      for(var attraction in attractionList!) {
        localMarkers.add(
          Marker(
            markerId: MarkerId(attraction.id!),
            position: LatLng(attraction.location!.lat!, attraction.location!.lng!),
            onTap: () {
              if (mounted && viewOnMap == null) {
                setState(() {
                  currentAttraction = attraction;
                  attractionPillPosition = 100;
                  _markers!.clear();

                  generateMarkers();
                });
              }
            },
            icon: currentAttraction != null && currentAttraction!.id == attraction.id ? selectedMarker! : defaultMarker!
            )
          );
      }
    }

    if (mounted) {
        setState(() {
          _markers = localMarkers;
        });
      }
  }
  
  @override
  Widget build(BuildContext context) {
    loadingPositionOn = MediaQuery.of(context).size.height / 2;
    loadingPositionOff = MediaQuery.of(context).size.height + 200;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ToursyAppBar(themeColor: ToursyColors.secondaryGreen),
      body: Stack(
        children:[
          GoogleMap(
            markers: _markers!,
            mapType: MapType.normal,
            onCameraMove: _onCameraMove,
            initialCameraPosition: 
            CameraPosition(
              target: _center,
              bearing: 0,
              zoom: 7.0),
            onMapCreated: onMapCreated,
            onTap: (LatLng location) {
              if (mounted) {
                setState(() {
                  attractionPillPosition = -200;
                  currentAttraction = AttractionModel(
                    img: currentAttraction!.img!,
                    id: '',
                    name: currentAttraction!.name!,
                    description: currentAttraction!.description!,
                    province: currentAttraction!.province!
                  );
                  generateMarkers();
                });
              }
            }
          ),
          AnimatedPositioned(
            bottom: attractionPillPosition,
            right: 0,
            left: 0,
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () {
                if (viewOnMap == null) {
                  attractionSelectionService!.onSelectAttraction(currentAttraction!);
                  Utils.mainAppNav.currentState!.pushNamed('/attraction');
                }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
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
                            Hero(
                              tag: currentAttraction!.id!,
                              child: Container(
                                width: 100,
                                child: Image.network(currentAttraction!.img!, width: 100, fit: BoxFit.cover),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('./assets/imgs/toursybg.png'),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            left: 0, right: 0,
              top: !loadingComplete ? loadingPositionOn : loadingPositionOff,
            child: AnimatedOpacity(
              opacity: !loadingComplete ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Center(
                child: ToursyMapLocatorButton(
                  icon: ToursyFontIcons.toursyLogo,
                  onTap: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    Future.delayed(const Duration(seconds: 2), () {
      loadingComplete = true;
      generateMarkers();
    });
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
  }
}
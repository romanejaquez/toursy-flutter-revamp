import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';

class ToursyMapPill extends StatelessWidget {
  final AttractionModel? currentAttraction;
  final AttractionModel? viewOnMap;

  const ToursyMapPill({Key? key, this.currentAttraction, this.viewOnMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AttractionSelectionService attractionSelectionService = Provider.of<AttractionSelectionService>(context, listen: false);
    
    return GestureDetector(
      onTap: () {
        if (viewOnMap == null) {
          attractionSelectionService.onSelectAttraction(currentAttraction!);
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
            height: 250,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20, 
                  offset: Offset.zero, 
                  color: Colors.grey.withOpacity(0.5)
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: currentAttraction!.id!,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40)),
                        child: Container(
                          height: 170,
                          child: Image.network(currentAttraction!.img!, height: 150, fit: BoxFit.cover),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('./assets/imgs/toursybg.png'),
                              fit: BoxFit.cover
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(currentAttraction!.name!, style: const TextStyle(color: Colors.green)),
                                  Text(currentAttraction!.province!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(2.5),
                            width: 40,
                            height: 40,
                            child: Image.asset('./assets/imgs/main_logo.png', width: 40, height: 40),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
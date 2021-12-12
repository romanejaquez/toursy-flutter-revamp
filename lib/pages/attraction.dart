import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';

class AttractionPage extends StatelessWidget {
  const AttractionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AttractionSelectionService attractionSelectionService = Provider.of<AttractionSelectionService>(context, listen: false);
    AttractionModel selectedAttraction = attractionSelectionService.selectedAttraction!;
    
    return Scaffold(
      appBar: const ToursyAppBar(themeColor: Colors.white),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Hero(
            tag: selectedAttraction.id!,
            child: Container(
              height: 350,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)
                  ),
                  color: Colors.grey.withOpacity(0.5),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(1)
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter
                  )
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(60)
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    selectedAttraction.img!,
                  ),
                  fit: BoxFit.cover
                )
              ),
            ),
          )
        ],
      )
    );
  }
}
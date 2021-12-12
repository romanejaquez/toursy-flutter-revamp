import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';
import 'package:toursy_flutter_revamp/widgets/attractioncard.dart';

class AttractionsAnimatedList extends StatefulWidget {

  List<AttractionCardModel>? attractions;
  AttractionsAnimatedList({Key? key, this.attractions}) : super(key: key);

  @override
  _AttractionsAnimatedListState createState() => _AttractionsAnimatedListState();
}

class _AttractionsAnimatedListState extends State<AttractionsAnimatedList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20),
      itemCount: widget.attractions!.length,
      itemBuilder: (context, index) {
        AttractionCardModel attractionCard = widget.attractions![index];
        // AttractionCardModel attractionCard = AttractionCardModel(
        //   img: attraction.img!,
        //   title: attraction.name!,
        //   subTitle: attraction.province!
        // );
        return AttractionCard(cardInfo: attractionCard);
      }
    );
  }
}
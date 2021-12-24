import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';
import 'package:toursy_flutter_revamp/widgets/animatedlistrow.dart';
import 'package:toursy_flutter_revamp/widgets/attractioncard.dart';

class AttractionsAnimatedList extends StatefulWidget {

  Function? onSelectedCard;
  List<AttractionCardModel>? attractions;
  AttractionsAnimatedList({Key? key, this.attractions, required this.onSelectedCard}) : super(key: key);

  @override
  _AttractionsAnimatedListState createState() => _AttractionsAnimatedListState();
}

class _AttractionsAnimatedListState extends State<AttractionsAnimatedList> {
  List<AttractionCardModel> actualList = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (widget.attractions != null) {
      Utils.insertListItemsInFuture(widget.attractions!, actualList, _key);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      padding: const EdgeInsets.only(left: 20, right: 20),
      initialItemCount: actualList.length,
      itemBuilder: (context, index, animation) {
        AttractionCardModel attractionCard = widget.attractions![index];
        return AnimatedListRow(
          animation: animation,
          child: AttractionCard(
            cardInfo: attractionCard,
            onTap: () { widget.onSelectedCard!(attractionCard); },  
          ),
        );
      }
    );
  }
}
import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';

class AttractionCard extends StatefulWidget {
  
  final AttractionCardModel? cardInfo;
  const AttractionCard({Key? key, this.cardInfo}) : super(key: key);

  @override
  _AttractionCardState createState() => _AttractionCardState();
}

class _AttractionCardState extends State<AttractionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)
            ),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.cardInfo!.img!),
                  fit: BoxFit.cover
                )
              ),
              child: Container(
                decoration: BoxDecoration(
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
              )
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.cardInfo!.title!,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
                  ),
                  Visibility(
                    visible: widget.cardInfo!.subTitle!.isNotEmpty,
                    child: Text(widget.cardInfo!.subTitle!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15)
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
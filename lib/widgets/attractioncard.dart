import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';

class AttractionCard extends StatelessWidget {
  
  final Function? onTap;
  final AttractionCardModel? cardInfo;
  const AttractionCard({Key? key, this.cardInfo, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { onTap!(); },
      child: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60)
              ),
              child: Hero(
                tag: cardInfo!.id!,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)
                    ),
                    image: DecorationImage(
                      image: NetworkImage(cardInfo!.img!),
                      fit: BoxFit.cover
                    )
                  ),
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
                  )
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(cardInfo!.title!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                    Visibility(
                      visible: cardInfo!.subTitle!.isNotEmpty,
                      child: Text(cardInfo!.subTitle!,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 15)
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
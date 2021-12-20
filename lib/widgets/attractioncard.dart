import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';

class AttractionCard extends StatefulWidget {
  
  final Function? onTap;
  final AttractionCardModel? cardInfo;
  const AttractionCard({Key? key, this.cardInfo, required this.onTap}) : super(key: key);

  @override
  State<AttractionCard> createState() => _AttractionCardState();
}

class _AttractionCardState extends State<AttractionCard> with SingleTickerProviderStateMixin {
  
  AnimationController? cardTextController;

  @override
  void initState() {
    super.initState();

    cardTextController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this
    )..forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { widget.onTap!(); },
      child: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 15),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60)
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60)
                        ),
                        image: DecorationImage(
                          image: AssetImage('./assets/imgs/toursybg.png'),
                          fit: BoxFit.cover
                        )
                      )
                    )
                  ),
                  Hero(
                    tag: widget.cardInfo!.id!,
                    child: SizedBox(
                      height: 250,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            left: 0,
                            right: 0,
                            child: FadeInImage.assetNetwork(
                              placeholder: './assets/imgs/toursybg.png', 
                              image: widget.cardInfo!.img!,
                              fit: BoxFit.cover
                            )
                          ),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60)
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.5)
                                ],
                                begin: Alignment.center,
                                end: Alignment.bottomCenter
                              )
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ]
              ),
            ),
            Positioned.fill(
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(-0.125, 0.0), end: Offset.zero)
                .animate(CurvedAnimation(parent: cardTextController!, curve: Curves.easeInOut)),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0)
                  .animate(CurvedAnimation(parent: cardTextController!, curve: Curves.easeInOut)),
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cardTextController!.dispose();
    super.dispose();
  }
}
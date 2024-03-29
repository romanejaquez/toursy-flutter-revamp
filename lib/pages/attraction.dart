import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';
import 'package:toursy_flutter_revamp/services/favorites.service.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';
import 'package:toursy_flutter_revamp/widgets/toursyfavoriteselection.dart';
import 'package:toursy_flutter_revamp/widgets/toursyherobubbles.dart';
import 'package:toursy_flutter_revamp/widgets/toursymaplocatorbutton.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AttractionPage extends StatefulWidget {
  const AttractionPage({Key? key}) : super(key: key);

  @override
  State<AttractionPage> createState() => _AttractionPageState();
}

class _AttractionPageState extends State<AttractionPage> with TickerProviderStateMixin {
  
  AnimationController? textContentController;
  AnimationController? videoContentController;
  YoutubePlayerController? _controller;
  AnimationController? toursyLocatorAnim;

  @override
  void initState() {
    super.initState();

    textContentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750)
    )..forward();

    videoContentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850)
    )..forward();

    toursyLocatorAnim = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this
    );
  }

  @override 
  void dispose() {
    _controller!.dispose();
    textContentController!.dispose();
    videoContentController!.dispose();
    toursyLocatorAnim!.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    AttractionSelectionService attractionSelectionService = Provider.of<AttractionSelectionService>(context, listen: false);
    AttractionModel selectedAttraction = attractionSelectionService.selectedAttraction!;

    Future.delayed(const Duration(milliseconds: 750), () {
      toursyLocatorAnim!.forward();
    });

    _controller = YoutubePlayerController(
        initialVideoId: selectedAttraction.video!,
        flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: false
        ),
    );
    
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: const ToursyAppBar(themeColor: Colors.white),
          extendBodyBehindAppBar: true,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Hero(
                      tag: selectedAttraction.id!,
                      child: Container(
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
                    ),
                    const ToursyHeroBubbles(),
                    SlideTransition(
                      position: Tween<Offset>(begin: const Offset(-0.25, 0.0), end: Offset.zero)
                      .animate(CurvedAnimation(parent: textContentController!, curve: Curves.easeInOut)),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1)
                        .animate(CurvedAnimation(parent: textContentController!, curve: Curves.easeInOut)),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 40, bottom: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ToursyFavoriteSelection(attraction: selectedAttraction),
                                  Text(selectedAttraction.name!,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35)
                                  ),
                                  Text(selectedAttraction.province!,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20)
                                  ),
                                ],
                              ),
                            ),
                        )
                        ),
                    ),
                    FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(CurvedAnimation(parent: toursyLocatorAnim!, curve: Curves.easeInOut)),
                      child: SlideTransition(
                        position: Tween<Offset>(begin: const Offset(0.25, 0.0), end: Offset.zero)
                        .animate(CurvedAnimation(parent: toursyLocatorAnim!, curve: Curves.elasticInOut)),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 15, bottom: 15),
                            child: Transform.scale(scale: 0.8,
                              child: ToursyMapLocatorButton(
                                onTap: () {
                                  attractionSelectionService.onViewAttractionOnMap(selectedAttraction);
                                  Utils.mainAppNav.currentState!.pushNamed('/map');
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0.25, 0.0), end: Offset.zero)
                          .animate(CurvedAnimation(parent: textContentController!, curve: Curves.easeInOut)),
                          child: FadeTransition(
                            opacity: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(parent: textContentController!, curve: Curves.easeInOut)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: ToursyColors.secondaryGreen)),
                                const SizedBox(height: 10),
                                Text(selectedAttraction.description!, style: const TextStyle(fontSize: 15)),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0.25, 0.0), end: Offset.zero)
                          .animate(CurvedAnimation(parent: videoContentController!, curve: Curves.easeInOut)),
                          child: FadeTransition(
                            opacity: Tween<double>(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(parent: videoContentController!, curve: Curves.easeInOut)),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40)
                              ),
                              child: player
                            )
                          )
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        );
      },
    );
  }
}
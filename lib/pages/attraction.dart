import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';

class AttractionPage extends StatefulWidget {
  const AttractionPage({Key? key}) : super(key: key);

  @override
  State<AttractionPage> createState() => _AttractionPageState();
}

class _AttractionPageState extends State<AttractionPage> with TickerProviderStateMixin {
  
  AnimationController? textContentController;

  @override
  void initState() {
    super.initState();

    textContentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750)
    )..forward();
  }

  @override 
  void dispose() {
    textContentController!.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    AttractionSelectionService attractionSelectionService = Provider.of<AttractionSelectionService>(context, listen: false);
    AttractionModel selectedAttraction = attractionSelectionService.selectedAttraction!;
    
    return Scaffold(
      appBar: const ToursyAppBar(themeColor: Colors.white),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          SizedBox(
            height: 350,
            child: Stack(
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
                ),
                SlideTransition(
                  position: Tween<Offset>(begin: const Offset(-0.25, 0.0), end: Offset.zero)
                  .animate(CurvedAnimation(parent: textContentController!, curve: Curves.easeInOut)),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1)
                    .animate(CurvedAnimation(parent: textContentController!, curve: Curves.easeInOut)),
                    child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(selectedAttraction.name!,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)
                            ),
                            Text(selectedAttraction.province!,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20)
                            ),
                          ],
                        ),
                      )
                    ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
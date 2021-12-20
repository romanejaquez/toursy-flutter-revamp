import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/widgets/toursymaplocatorbutton.dart';

class ToursyAlert extends StatefulWidget {
  final Function? onYes;
  final Function? onNo;
  final String? title;
  final String? message;

  const ToursyAlert({
    Key? key,
    this.onYes,
    this.onNo,
    this.title, 
    this.message  
  }) : super(key: key);

  @override
  State<ToursyAlert> createState() => _ToursyAlertState();
}

class _ToursyAlertState extends State<ToursyAlert> with TickerProviderStateMixin {

  AnimationController? dialogAnimController;

  @override 
  void initState() {
    super.initState();

    dialogAnimController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0)
      .animate(CurvedAnimation(parent: dialogAnimController!, curve: Curves.linearToEaseOut)),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: dialogAnimController!, curve: Curves.easeInOut)),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.title!,
                            textAlign: TextAlign.center, style: const TextStyle(color: ToursyColors.primaryGreen, fontWeight: FontWeight.bold, fontSize: 20)
                          ),
                          const SizedBox(height: 10),
                          Text(widget.message!,
                            textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: TextButton(onPressed: (){
                          widget.onYes!();
                        }, style: TextButton.styleFrom(primary: ToursyColors.primaryGreen), child: Text('Yes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
                        Expanded(
                          child: TextButton(
                            onPressed: (){ 
                              widget.onNo!();
                            }, 
                            style: TextButton.styleFrom(primary: ToursyColors.primaryGreen), child: Text('No', style: TextStyle(fontSize: 20)))),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height / 4
              ),
              Positioned(
                top: -50,
                left: 0,
                right: 0,
                child: Center(
                  child: ToursyMapLocatorButton(
                    onTap: () {},
                    icon: ToursyFontIcons.toursyLogo,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
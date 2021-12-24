import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/services/toursymainservice.dart';

class ToursySplashStatus extends StatefulWidget {

  final Function? onDataRetrieved;
  const ToursySplashStatus({Key? key, this.onDataRetrieved}) : super(key: key);

  @override
  State<ToursySplashStatus> createState() => _ToursySplashStatusState();
}

class _ToursySplashStatusState extends State<ToursySplashStatus> with SingleTickerProviderStateMixin {

  bool? errorOnData = false;
  AnimationController? textController;

  @override
  void initState() {
    super.initState();

    textController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    textController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ToursyMainService toursyMainService = Provider.of<ToursyMainService>(context, listen: false);
    
    toursyMainService.fetchAllData(context).then((value) {
      widget.onDataRetrieved!();
    }).catchError((error) {
      textController!.stop();
      setState(() {
        errorOnData = true;
      });
    }).onError((error, stackTrace) {
      textController!.stop();
      setState(() {
        errorOnData = true;
      });
    });
    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 0.0)
      .animate(CurvedAnimation(parent: textController!, curve: Curves.easeInOut)),
      child: errorOnData! ? 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.warning_amber, color: Colors.white, size: 50),
          SizedBox(height: 20),
          Text('There was an issue fetching the data.\nCheck your connection and retry.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white)
          )
        ]
      )
      :
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Text('Fetching amazing\ntouristic data. Hang on!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white)
          )
        ],
      ),
    );
  }
}
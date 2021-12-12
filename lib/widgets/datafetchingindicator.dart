import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';

class DataFetchingIndicator extends StatelessWidget {

  final String? msg;
  const DataFetchingIndicator({Key? key, this.msg = 'Fetching Data...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Icon(
                      ToursyFontIcons.toursyLogo,
                      color: Colors.grey.withOpacity(0.5),
                      size: 50
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.withOpacity(0.5)),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(msg!, style: const TextStyle(fontSize: 15, color: Colors.grey))
        ],
      ),
    );
  }
}
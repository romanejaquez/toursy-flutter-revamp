import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';

class ToursyPageHeader extends StatelessWidget {

  final String? header;
  String? subHeader;

  ToursyPageHeader({Key? key, this.header, this.subHeader }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 20, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header!, style: const TextStyle(color: ToursyColors.primaryGreen, fontSize: 30)),
          Text(subHeader!, style: const TextStyle(color: Colors.grey, fontSize: 15 ))
        ],
      ),
    );
  }
}
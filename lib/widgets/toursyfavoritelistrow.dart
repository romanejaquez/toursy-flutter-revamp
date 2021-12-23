import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';

class ToursyFavoriteListRow extends StatelessWidget {
  final AttractionModel? attraction;
  final Function? onRemove;
  final Function? onSelectRow;

  const ToursyFavoriteListRow({Key? key, this.attraction, this.onRemove, this.onSelectRow }) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    return GestureDetector(
      onTap: () { onSelectRow!(); },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ClipOval(
              child: Stack(
                children: [
                  Image.asset('./assets/imgs/toursybg.png', width: 80, height: 80, fit: BoxFit.cover),
                  FadeInImage.assetNetwork(
                    placeholder: './assets/imgs/toursybg.png', 
                    image: attraction!.img!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover
                  )
                ],
              )
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(attraction!.name!, 
                    style: const TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold, 
                      color: ToursyColors.secondaryGreen
                    )
                  ),
                  Text(attraction!.province!, 
                    style: const TextStyle(
                      fontSize: 15, 
                      color: ToursyColors.primaryGreen
                    )
                  )
                ]
              ),
            ),
            IconButton(
              icon: const Icon(Icons.highlight_off, color: ToursyColors.primaryGreen),
              onPressed: () {
                onRemove!();
              }
            )
          ],
        ),
      ),
    );
  }
}
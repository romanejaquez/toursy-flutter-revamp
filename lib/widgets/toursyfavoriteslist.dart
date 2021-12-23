import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/widgets/animatedlistrow.dart';

class ToursyFavoritesList extends StatefulWidget {

  final List<AttractionModel>? attractions;

  const ToursyFavoritesList({Key? key, this.attractions }) : super(key: key);

  @override
  State<ToursyFavoritesList> createState() => _ToursyFavoritesListState();
}

class _ToursyFavoritesListState extends State<ToursyFavoritesList> {

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<AttractionModel> insertedItems = [];

  @override
  void initState() {
    super.initState();

    var future = Future(() {});
    for (var i = 0; i < widget.attractions!.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 125), () {
          insertedItems.add(widget.attractions![i]);
          _key.currentState!.insertItem(i);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      padding: const EdgeInsets.only(bottom: 100),
      key: _key,
      initialItemCount: insertedItems.length,
      itemBuilder: (context, index, animation) {
        var rowItem = widget.attractions![index];
        return AnimatedListRow(
          animation: animation,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(rowItem.img!, width: 80, height: 80, fit: BoxFit.cover)
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rowItem.name!, 
                        style: const TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          color: ToursyColors.secondaryGreen
                        )
                      ),
                      Text(rowItem.province!, 
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
                  onPressed: () {}
                )
              ],
            ),
          )
        );
      }
    );
  }
}
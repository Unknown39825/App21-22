import 'package:flutter/material.dart';
import 'package:techapp/models/event_by_categories.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/pages/event_detail.dart';
// ignore: import_of_legacy_library_into_null_safe

class ListItem extends StatelessWidget {
  final Event item;

  const ListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color eventcolor = white;

    return Container(
      child: Card(
          color: Colors.transparent,
          margin: const EdgeInsets.only(top: 10),
          borderOnForeground: true,
          elevation: 5,
          shadowColor: glowColor,
          child: GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailWidget(
                    item: item,
                  ),
                ),
              )
            },
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: glowColor.withOpacity(0.9),
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: item.eventName,
                      child: Container(
                          width: 100,
                          height: 100,
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/altius.png',
                              image: item.poster,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/images/altius.png'))),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item.eventName, style: h2),
                            Text(
                              item.description.length > 100
                                  ? item.description.substring(0, 100) + '...'
                                  : item.description,
                              style: h6,
                            ),
                            //  read more button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Know more',
                                  style: h4.copyWith(
                                      color: Colors.grey.withOpacity(0.6),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}

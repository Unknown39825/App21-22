import 'package:flutter/material.dart';
import 'package:techapp/models/EventByCategories.dart';
import 'package:techapp/providers/event_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

DateFormat dateFormat = DateFormat("MMMM dd,yyyy HH:mm");

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 11.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 16.0,
      fontWeight: FontWeight.w400);
  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w600);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w400);
}

class EventDetailWidget extends StatelessWidget {
  final String eventName;
  final String eventCategory;

  const EventDetailWidget(
      {Key? key, required this.eventName, required this.eventCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Event item = FetchDataProvider.eventsMap[eventCategory]![eventName]!;
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: gradientEndColor,
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(item),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return new Container(
      child: new Image.asset(
        'assets/images/categories/' + eventCategory.toLowerCase() + '.png',
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[gradientStartColor, gradientEndColor],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent(Event item) {
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
              child: new Stack(
                children: <Widget>[
                  Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40.0),
                      constraints: new BoxConstraints.expand(),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                          ),
                          new Container(height: 4.0),
                          new Text(item.eventName, style: Style.titleTextStyle),
                          new Container(height: 10.0),
                          new Text(item.eventCategory,
                              style: Style.commonTextStyle),
                          Container(
                              margin: new EdgeInsets.symmetric(vertical: 8.0),
                              width: 18.0,
                              color: new Color(0xff00c6ff)),
                          Text(
                              "Start Time: " +
                                  dateFormat.format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          item.startTime * 1000)),
                              style: Style.commonTextStyle),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                              "End Time: " +
                                  dateFormat.format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          item.endTime * 1000)),
                              style: Style.commonTextStyle),
                        ],
                      ),
                    ),
                    height: 220,
                    margin: new EdgeInsets.only(top: 72.0),
                    decoration: new BoxDecoration(
                      color: new Color(0xFF333366),
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[
                        new BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: new Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // margin: new EdgeInsets.symmetric(vertical: 16.0),
                    alignment: FractionalOffset.center,
                    child: new Hero(
                        tag: item.eventName,
                        child: Container(
                            width: 250.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/technologo.png',
                                image: item.file,
                                fit: BoxFit.contain,
                                imageErrorBuilder:
                                    (context, error, stackTrace) => Image.asset(
                                        'assets/images/technologo.png')))),
                  ),
                ],
              )),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Description", style: Style.headerTextStyle),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: 18.0,
                    color: new Color(0xff00c6ff)),
                new Text(item.description, style: Style.commonTextStyle),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          if (item.rules.length > 0)
            new Container(
              padding: new EdgeInsets.symmetric(horizontal: 32.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Rules", style: Style.headerTextStyle),
                  Container(
                      margin: new EdgeInsets.symmetric(vertical: 8.0),
                      height: 2.0,
                      width: 18.0,
                      color: new Color(0xff00c6ff)),
                  Column(
                      children:
                          item.rules.map((rule) => ruleItem(rule)).toList())
                ],
              ),
            ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Venue", style: Style.headerTextStyle),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: 18.0,
                    color: new Color(0xff00c6ff)),
                Container(child: Text(item.venue, style: Style.commonTextStyle))
              ],
            ),
          ),
          Container(height: 5),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Event Coordinators", style: Style.headerTextStyle),
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: 18.0,
                    color: new Color(0xff00c6ff)),
              ],
            ),
          ),
          if (item.cordinators.length > 0)
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                  // crossAxisCount: 2,
                  // childAspectRatio: 1.0,
                  children: item.cordinators
                      .map((cordinator) => cordinatorItem(cordinator))
                      .toList()),
            ),
        ],
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }
}

Container ruleItem(String rule) {
  return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("• ", style: Style.commonTextStyle),
          Expanded(
            child: Text(rule, style: Style.commonTextStyle),
          ),
        ],
      ));
}

Widget cordinatorItem(Cordinators cordinator) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          var number = cordinator.coordinator_number;
          if (!await launch('tel:$number')) {
            print(number);
            print(cordinator.coordinator_name);
          }
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Icon(Icons.call),
          FittedBox(
            fit: BoxFit.cover,
            child: Text(cordinator.coordinator_name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    ),
  );
}
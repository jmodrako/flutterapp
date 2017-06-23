import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/data/DataSource.dart';
import 'package:flutterapp/data/model/beermodel.dart';

typedef void BeerTapCallback(BeerModel photo);

List<Widget> _buildGridTileList(List<BeerModel> models, BuildContext context) {
  return new List<Widget>.generate(
      models.length, (int index) =>
  new GestureDetector(
      onTap: () {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text(models[index].title)));
      },
      child: new BeerCard(models[index])));
}

Widget buildGrid(BuildContext context) {
  return new GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(4.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: _buildGridTileList(new DataSource().getBeers(), context));
}

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Polski Kraft',
        theme: new ThemeData(
            primarySwatch: Colors.amber,
            splashColor: const Color(0x66C8C8C8)
        ),
        home: new HomeView(title: 'Polski Kraft'));
  }
}

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List<Tab> tabs = <Tab>[
    new Tab(text: "Home"),
    new Tab(text: "Na Topie"),
    new Tab(text: "Najlepsze"),
    new Tab(text: "Najnowsze"),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Polski Kraft"),
      ),
      body: new Builder(
          builder: (BuildContext context) {
            return new Column(
                children: <Widget>[
                  new Expanded(
                    child: buildGrid(context),
                  ),
                ]);
          }),
      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (selectedIndex) {
            print(selectedIndex.toString());
          },
          currentIndex: 0,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
              title: new Text("Home"),
              icon: new Placeholder(),
            ),
            new BottomNavigationBarItem(
              title: new Text("Na Topie"),
              icon: new Placeholder(),
            ),
            new BottomNavigationBarItem(
              title: new Text("Najlepsze"),
              icon: new Placeholder(),
            ),
            new BottomNavigationBarItem(
              title: new Text("Najnowsze"),
              icon: new Placeholder(),
            ),
          ]),
    );
  }
}

class BeerCard extends StatelessWidget {

  const BeerCard(this.beerModel) : super(key: null);

  @required final BeerModel beerModel;

  @override
  Widget build(BuildContext context) {
    return new Material(
        elevation: .0,
        borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
        type: MaterialType.card,
        child: new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(beerModel.imageUrl)
                )
            ),
            child: new Stack(
                alignment: FractionalOffset.bottomLeft,
                children: <Widget>[
                  new Container(
                      constraints: new BoxConstraints.tightFor(
                          width: double.INFINITY),
                      child: new Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: new BoxDecoration(
                              color: Colors.black54
                          ),
                          child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                    beerModel.rating.toString(),
                                    maxLines: 1,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .display1
                                        .apply(
                                        color: Colors.white,
                                        fontWeightDelta: 1)),
                                new Text(
                                    beerModel.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .title
                                        .apply(color: Colors.white)),
                                new Text(
                                    beerModel.subtitle.toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .body1
                                        .apply(
                                        color: Colors.white,
                                        fontSizeFactor: 1.2))
                              ]))
                  )
                ]))
    );
  }
}


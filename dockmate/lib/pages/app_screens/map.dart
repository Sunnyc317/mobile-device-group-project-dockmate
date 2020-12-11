import 'package:dockmate/utils/util.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/listing.dart';
import 'package:dockmate/pages/app_screens/posting.dart';

final centre = LatLng(43.6532, -79.3832);
MapController _mapController = MapController();
List<ListingPlace> _lp = [];

class ListingPlace {
  Listing listing;
  Placemark place;

  ListingPlace({this.listing, this.place});
}

class Map extends StatefulWidget {
  final Function toggleView;
  Map({Key key, this.toggleView}) : super(key: key);
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  var _geolocator = Geolocator();
  var _zoom = 12.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            leading:
                Image.asset("assets/dock.png", scale: 20, color: Colors.white),
            title: Text("Find a house"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.zoom_in),
                  onPressed: () {
                    setState(() {
                      _zoom += 2.0;
                      _mapController.move(centre, _zoom);
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.zoom_out),
                  onPressed: () {
                    setState(() {
                      _zoom -= 2.0;
                      _mapController.move(centre, _zoom);
                    });
                  })
            ]),
        body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            minZoom: _zoom,
            center: centre,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: _markers())
          ],
        ),
        bottomNavigationBar:
            BottomBar(bottomIndex: 1, toggleView: widget.toggleView));
  }

  List<Marker> _markers() {
    LatLng loc;
    List<Marker> _marks = [];
    Listing _listing = new Listing();

    _listing.getAllListings().first.then((list) {
      setState(() {
        list.forEach((element) {
          _geolocator
              .placemarkFromAddress(element.address)
              .then((List<Placemark> places) {
            for (Placemark place in places) {
              _lp.add(ListingPlace(listing: element, place: place));
            }
          });
        });
      });
    });

    _lp.forEach((lp) {
      loc = LatLng(lp.place.position.latitude, lp.place.position.longitude);
      _marks.add(Marker(
          height: 45.0,
          width: 45.0,
          point: loc,
          builder: (context) => Container(
                  child: IconButton(
                icon: Icon(
                  Icons.house,
                  size: 25.0,
                  color: Colors.blue,
                ),
                onPressed: () {
                  _showModalBottomSheet(lp.listing);
                },
              ))));
    });

    return _marks;
  }

  Future<void> _showModalBottomSheet(Listing listing) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildListRow(
                    listing,
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.open_in_full),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      Posting(title: '', listing: listing)));
                            }),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

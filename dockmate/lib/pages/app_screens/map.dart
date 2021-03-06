import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:dockmate/utils/bottombar.dart';
import 'package:dockmate/model/listing.dart';

final centre = LatLng(43.6532, -79.3832);
final path = [];

class Map extends StatefulWidget {
  final Function toggleView;
  Map({Key key, this.toggleView}):super(key:key);
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
            title: Text('Find a House'),
            actions: <Widget>[]),
        body: FlutterMap(
          options: MapOptions(
            minZoom: _zoom,
            center: centre,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: _markers()),
          ],
        ),
        bottomNavigationBar: BottomBar(bottomIndex: 1, toggleView: widget.toggleView));
  }

  List<Marker> _markers() {
    List<Marker> marks = [];
    Listing _listing = new Listing();

    _listing.getAllListings().first.then((list) {
      setState(() {
        LatLng loc;
        list.forEach((element) {
          _geolocator
              .placemarkFromAddress(element.address)
              .then((List<Placemark> places) {
            for (Placemark place in places) {
              loc = LatLng(place.position.latitude, place.position.longitude);
              path.add(loc);
            }
          });
        });
      });
    });

    path.forEach((point) {
      marks.add(Marker(
          height: 45.0,
          width: 45.0,
          point: point,
          builder: (context) => Container(
                  child: Icon(
                Icons.house,
                size: 25.0,
                color: Colors.blue,
              ))));
    });

    return marks;
  }
}

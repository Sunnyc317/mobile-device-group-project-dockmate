import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dockmate/model/listing.dart';

class SavedListings {
  String id;
  String userID;
  String listingID;

  FirebaseFirestore _db = FirebaseFirestore.instance;

  SavedListings({this.id, this.userID, this.listingID});

  factory SavedListings.fromMap(
      Map<String, dynamic> map, DocumentReference reference) {
    return SavedListings(
        id: reference.id, userID: map['user_id'], listingID: map['listing_id']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'user_id': this.userID,
      'listing_id': this.listingID
    };
  }

  Stream<List<SavedListings>> getAllSavedListings() {
    return _db.collection('saved_listings').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => SavedListings.fromMap(doc.data(), doc.reference))
            .toList());
  }

  Future<void> insert(SavedListings list) async {
    var merge = SetOptions(merge: true);
    return _db
        .collection('saved_listings')
        .doc(list.id)
        .set(list.toMap(), merge);
  }

  Future<void> delete(String id) async {
    return _db.collection('saved_listings').doc(id).delete();
  }
}

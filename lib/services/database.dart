import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:metropay/models/mpayuser.dart';
import 'package:metropay/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference mpayuserCollection = Firestore.instance.collection('mpayusers');

  Future<void> updateUserData(String name, double balance, String boarding, String destination) async {
    return await mpayuserCollection.document(uid).setData({
      'name': name,
      'balance' : balance,
      'boarding' : boarding,
      'destination' : destination,
    });
  }

//  // mpay user list from snapshot
//  List<Mpayuser> _mpayuserListFromSnapshot(QuerySnapshot snapshot) {
//    return snapshot.documents.map((doc){
//      //print(doc.data);
//      return Mpayuser(
//          name: doc.data['name'] ?? '',
//          balance: doc.data['balance'] ?? 0.0,
//          boarding: doc.data['boarding'] ?? '1',
//          destination: doc.data['destination'] ?? '1',
//      );
//    }).toList();
//  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        balance: snapshot.data['balance'],
        boarding: snapshot.data['boarding'],
        destination: snapshot.data['destination'],

    );
  }

//  // get mpayusers stream
//  Stream<List<Mpayuser>> get mpayusers {
//    return mpayuserCollection.snapshots()
//    .map(_mpayuserListFromSnapshot);
//  }

  // get user doc stream
  Stream<UserData> get userData {
    return mpayuserCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}
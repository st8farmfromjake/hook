import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> setDocument(String docId, Map<String, dynamic> data) async {
  await db.collection("your_collection").doc(docId).set(data);
}

Future<void> updateDocument(String docId, Map<String, dynamic> data) async {
  await db.collection("your_collection").doc(docId).update(data);
}
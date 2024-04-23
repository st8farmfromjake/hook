import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

void main() {
  fetchDocument();
}

Future<List<dynamic>> fetchDocument() async {
  try {
    final User user = FirebaseAuth.instance.currentUser!;
    String email = user.email.toString();
    DocumentSnapshot doc = await db.collection("user_email_info").doc(email).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return [
        data['path'],
        data['linkID'],
        data['totalEmailsSent']
      ];
    } else {
      print("No document found!");
      return [];
    }
  } catch (e) {
    print("Error getting document: $e");
    return []; // Return an empty list in case of error
  }
}

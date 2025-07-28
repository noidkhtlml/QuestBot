import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveTestToHistory({
  required String materie,
  required String capitol,
  required int timp,
  required int scor,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final uid = user.uid;

  final userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();

  final familyCode = userDoc.data()?['familyCode'];
  if (familyCode == null) return;

  final docRef = FirebaseFirestore.instance
      .collection('statistici')
      .doc(familyCode);

  final newTestEntry = {
    'capitol': capitol,
    'timp': timp,
    'scor': scor,
    'timestamp': Timestamp.now(),
    'uid': uid,
  };

  await docRef.set({
    materie: {
      'tests': FieldValue.arrayUnion([newTestEntry])
    }
  }, SetOptions(merge: true));
}

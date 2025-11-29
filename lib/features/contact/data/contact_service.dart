import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveContactMessage({
    required String name,
    required String email,
    required String message,
    String? subject,
  }) async {
    try {
      await _firestore.collection('contactMessages').add({
        'name': name,
        'email': email,
        'message': message,
        'subject': subject,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}

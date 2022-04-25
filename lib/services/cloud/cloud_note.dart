import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';

class CloudNote {
  final String documentId;
  final String ownerUserID;
  final String text;

  CloudNote({
    required this.documentId,
    required this.ownerUserID,
    required this.text,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserID = snapshot.data()[ownerUserIdFieldName] as String,
        text = snapshot.data()[textFieldName] as String;
}

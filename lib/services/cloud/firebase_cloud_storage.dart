import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes/services/cloud/cloud_note.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';
import 'package:mynotes/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection("notes");

  Future<void> deleteNote({required String documentID}) async {
    try {
      await notes.doc(documentID).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (_) {
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserID}) =>
      notes.snapshots().map((event) => event.docs
          .map((doc) => CloudNote.fromSnapshot(doc))
          .where(((note) => note.ownerUserID == ownerUserID)));

  Future<Iterable<CloudNote>> getNotes({required String ownerUserID}) async {
    try {
      return await notes
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserID,
          )
          .get()
          .then(
              (value) => value.docs.map((doc) => CloudNote.fromSnapshot(doc)));
    } catch (e) {
      throw CouldBNotGetAllNotesException();
    }
  }

  void createNewNote({required String ownerUserID}) async {
    await notes.add({ownerUserIdFieldName: ownerUserID, textFieldName: ""});
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance();

  factory FirebaseCloudStorage() => _shared;
}

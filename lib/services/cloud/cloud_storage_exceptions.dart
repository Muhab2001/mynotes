class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateNoteException extends CloudStorageException {}

class CouldBNotGetAllNotesException extends CloudStorageException {}

class CouldNotUpdateNoteException extends CloudStorageException {}

class CouldNotDeleteNoteException extends CloudStorageException {}

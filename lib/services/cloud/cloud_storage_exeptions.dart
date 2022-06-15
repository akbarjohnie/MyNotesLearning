class CloudStorageExeption implements Exception {
  const CloudStorageExeption();
}

// C in CRUD
class CouldNotCreateNoteExeption extends CloudStorageExeption {}

// R in CRUD
class CouldNotGetAllNotesExeption extends CloudStorageExeption {}

// U in CRUD
class CouldNotUpdateNoteExeption extends CloudStorageExeption {}

// D in CRUD
class CouldNotDeleteNoteExeption extends CloudStorageExeption {}

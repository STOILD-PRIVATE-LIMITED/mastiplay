import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';

class FirestoreDocument {
  String id;
  String? path;
  Map<String, dynamic> data = {};
  DateTime updatedAt = DateTime(2023);

  FirestoreDocument({
    this.id = "",
    Map<String, dynamic>? data,
    this.path,
    DateTime? updatedAt,
  }) {
    this.data = data ?? this.data;
    this.updatedAt = updatedAt ?? this.updatedAt;
  }

  void loadFromJson(Map<String, dynamic> data) {
    this.data = data;
    updatedAt = data['updatedAt'] == null
        ? updatedAt
        : DateTime.parse(data['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    data['updatedAt'] = updatedAt.toIso8601String();
    return data;
  }

  // this fetches the document from firestore
  Future<FirestoreDocument> fetch() async {
    print("Fetch Firestore Doc: $path$id");
    assert(path != null,
        "Path shouldn't be null when fetching data from firestore");
    assert(id.isNotEmpty,
        "Id shouldn't be empty when fetching data from firestore");
    path = path!.replaceAll(' ', '');
    if (!path!.endsWith('/')) {
      path = '${path!}/';
    }
    final doc = await firestore.doc(path! + id).get();
    if (!doc.exists) {
    print("Document not found at: ${path! + id}"); 
      throw Exception("Document doesn't exist");
    }
    data = doc.data() ?? {};
    updatedAt = data['updatedAt'] != null
        ? DateTime.parse(data['updatedAt'])
        : updatedAt;
    return this;
  }

  // this creates a new firestore document and return the new document id
  Future<String> add() async {
    path = path!.replaceAll(' ', '');
    assert(path != null,
        "Path shouldn't be null when adding a document to firestore");
    if (!path!.endsWith('/')) {
      path = '${path!}/';
    }
    data['updatedAt'] = DateTime.now().toIso8601String();
    final doc = await firestore.collection(path!).add(data);
    return id = doc.id;
  }

  // this deletes the document from firestore
  Future<void> delete() async {
    path = path!.replaceAll(' ', '');
    assert(path != null,
        "Path shouldn't be null when deleting a document from firestore");
    assert(id.isNotEmpty,
        "Id shouldn't be empty when deleting a document from firestore");
    if (!path!.endsWith('/')) {
      path = '${path!}/';
    }
    log("Deleting Firestore Doc: $path$id");
    await firestore.doc(path! + id).delete();
  }

  // this updates/creates the document on firestore
  Future<void> update() async {
    print("Update Firestore Doc: $path/$id");
    path = path!.replaceAll(' ', '');
    assert(
        path != null, "Path shouldn't be null when updating data on firestore");
    assert(
        id.isNotEmpty, "Id shouldn't be empty when updating data on firestore");
    if (!path!.endsWith('/')) {
      path = '${path!}/';
    }
    data['updatedAt'] = DateTime.now().toIso8601String();
    await firestore.doc(path! + id).set(data);
  }
}

Future<String> randomSet(
  FirestoreDocument doc, {
  int digitCount = 6,
  Future<bool> Function(Transaction transaction, int id)? uniqueCondition,
  Future<void> Function(
          Transaction transaction, int id, Map<String, dynamic> data)?
      docSet,
}) async {
  int newId = 0;
  doc.path = doc.path!.replaceAll(' ', '');
  assert(doc.path != null,
      "Path shouldn't be null when adding a document to firestore");
  if (!doc.path!.endsWith('/')) {
    doc.path = '${doc.path!}/';
  }
  doc.updatedAt = DateTime.now();
  CollectionReference collection =
      FirebaseFirestore.instance.collection(doc.path!);
  await FirebaseFirestore.instance
      .runTransaction((Transaction transaction) async {
    for (int i = 0; i < digitCount; ++i) {
      newId = newId * 10 +
          (i == 0 ? 1 : 0) +
          math.Random().nextInt(i == 0 ? 9 : 10);
    }
    log("Random id generated: $newId");
    // checking ...
    uniqueCondition ??= (transaction, id) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(collection.doc(id.toString()));
      return !documentSnapshot.exists;
    };
    docSet ??= (transaction, id, data) async {
      transaction.set(collection.doc(id.toString()), data);
    };
    if (await uniqueCondition!(transaction, newId)) {
      log("Unique Condition is true");
      log("Calling docSet");
      await docSet!(transaction, newId, doc.toJson());
    } else {
      log("Unique Condition is false");
      throw Exception('Document with ID $newId already exists.');
    }
  });
  return newId.toString();
}

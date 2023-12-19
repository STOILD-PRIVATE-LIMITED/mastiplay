import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spinner_try/shivanshu/models/firestore/firestore_document.dart';
import 'package:spinner_try/shivanshu/models/globals.dart';

class FirestoreCollection {
  static const String users = 'users/';
  static const String products = 'products/';
  static const String cart = 'cart/';

  String? path;
  String id = "";
  List<FirestoreDocument> documents = [];

  FirestoreCollection({
    this.id = "",
    this.path,
  });

  // this fetches the collection from firestore
  Future<List<FirestoreDocument>> get({
    String? start,
    int? limit,
    String? orderBy,
    bool? descending,
  }) async {
    assert(path != null || id.isNotEmpty);
    path ??= id;
    path = path!.replaceAll(' ', '');
    if (!path!.endsWith('/')) {
      path = '$path/';
    }

    Query<Map<String, dynamic>> query = firestore.collection(path!);
    if (start != null) {
      query = query.orderBy(orderBy ?? FieldPath.documentId,
          descending: descending ?? false);
      query = query.startAfter([start]);
    }
    if (limit != null) {
      query = query.limit(limit);
    }

    final value = await query.get();
    return documents = value.docs
        .map((e) => FirestoreDocument(
            id: e.id,
            data: e.data(),
            path: path! + e.id,
            updatedAt: DateTime.tryParse(e.data()['updatedAt'])))
        .toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras/models/productos_model.dart';
import 'dart:async';

final CollectionReference productCollection =
    Firestore.instance.collection('productos');

class FirebaseService {
  static final FirebaseService _instance = new FirebaseService.internal();
  factory FirebaseService() => _instance;

  FirebaseService.internal();

  Future<ProductosModel> createProduct(
      String name, String image, int price, int quantity) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot doc = await tx.get(productCollection.document());

      final ProductosModel producto =
          new ProductosModel(doc.documentID, name, image, price, quantity);
      final Map<String, dynamic> data = producto.toMap();

      await tx.set(doc.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return ProductosModel.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getProductList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshot = productCollection.snapshots();

    if (offset != null) {
      snapshot = snapshot.skip(offset);
    }

    if (limit != null) {
      snapshot = snapshot.skip(limit);
    }

    return snapshot;
  }
}

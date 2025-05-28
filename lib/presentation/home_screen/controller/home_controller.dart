import '/core/app_export.dart';
import 'package:grocery_app/presentation/home_screen/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/items/get_category_resp.dart';
import '../models/category_item_model.dart';
import '../models/frame10_item_model.dart';
import '../models/frame13_item_model.dart';
import '../models/frame14_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/core/utils/dummy_data.dart';

class HomeController extends GetxController with StateMixin<dynamic> {
  TextEditingController searchproductsController = TextEditingController();
  Rx<HomeModel> homeModelObj = HomeModel().obs;
  GetCategoryResp getItemsResp = GetCategoryResp();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    String userId = Get.find<PrefUtils>().getUserid();
    if (userId.isEmpty) {
      Get.offNamed(AppRoutes.loginWithEmailIdScreen);
    }
    this.callFetchItems(
      successCall: _onFetchItemsSuccess,
      errCall: _onFetchItemsError,
    );
  }

  @override
  void onClose() {
    super.onClose();
    searchproductsController.dispose();
  }

  Future<void> _createDummyData() async {
    try {
      final batch = _firestore.batch();

      // Create categories
      final categoriesRef = _firestore.collection('categories');
      for (var category in DummyData.getDummyCategories()) {
        final docRef = categoriesRef.doc(category['sId']);
        batch.set(docRef, category);
      }

      // Create frame10 items
      final frame10Ref = _firestore.collection('frame10');
      for (var item in DummyData.getDummyFrame10()) {
        final docRef = frame10Ref.doc(item['sId']);
        batch.set(docRef, item);
      }

      // Create frame13 items
      final frame13Ref = _firestore.collection('frame13');
      for (var item in DummyData.getDummyFrame13()) {
        final docRef = frame13Ref.doc(item['sId']);
        batch.set(docRef, item);
      }

      // Create frame14 items
      final frame14Ref = _firestore.collection('frame14');
      for (var item in DummyData.getDummyFrame14()) {
        final docRef = frame14Ref.doc(item['sId']);
        batch.set(docRef, item);
      }

      await batch.commit();
    } catch (e) {
      print('Error creating dummy data: $e');
      rethrow;
    }
  }

  Future<bool> _checkIfDataExists() async {
    final categoriesSnapshot = await _firestore.collection('categories').get();
    return categoriesSnapshot.docs.isNotEmpty;
  }

  void callFetchItems({
    VoidCallback? successCall,
    VoidCallback? errCall,
  }) async {
    try {
      // Check if data exists
      final dataExists = await _checkIfDataExists();

      // If no data exists, create dummy data
      if (!dataExists) {
        await _createDummyData();
      }

      // Fetch all data
      final categoriesSnapshot =
          await _firestore.collection('categories').get();
      final frame10Snapshot = await _firestore.collection('frame10').get();
      final frame13Snapshot = await _firestore.collection('frame13').get();
      final frame14Snapshot = await _firestore.collection('frame14').get();

      // Convert Firestore data to response format
      final categories =
          categoriesSnapshot.docs.map((doc) {
            final data = doc.data();
            return {'name': data['name'], 'icon': data['icon'], 'sId': doc.id};
          }).toList();

      final frame10Items =
          frame10Snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'name': data['name'],
              'image': data['image'],
              'price': data['price'],
              'discount': data['discount'],
              'sId': doc.id,
            };
          }).toList();

      final frame13Items =
          frame13Snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'name': data['name'],
              'image': data['image'],
              'price': data['price'],
              'rating': data['rating'],
              'sId': doc.id,
            };
          }).toList();

      final frame14Items =
          frame14Snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'name': data['name'],
              'image': data['image'],
              'price': data['price'],
              'description': data['description'],
              'sId': doc.id,
            };
          }).toList();

      // Update response object
      getItemsResp = GetCategoryResp.fromJson({'items': categories});

      // Update model objects
      _updateModelObjects(
        categories: categories,
        frame10Items: frame10Items,
        frame13Items: frame13Items,
        frame14Items: frame14Items,
      );

      if (successCall != null) {
        successCall();
      }
    } catch (err) {
      onFetchItemsError(err);
      if (errCall != null) {
        errCall();
      }
    }
  }

  void _updateModelObjects({
    required List<dynamic> categories,
    required List<dynamic> frame10Items,
    required List<dynamic> frame13Items,
    required List<dynamic> frame14Items,
  }) {
    // Update categories
    List<CategoryItemModel> frame9ItemModelList = [];
    for (var element in categories) {
      var frame9ItemModel = CategoryItemModel();
      frame9ItemModel.groceriesTxt.value = element['name'].toString();
      frame9ItemModel.imageImg.value = element['icon']['url'].toString();
      frame9ItemModel.categoryId.value = element['sId'].toString();
      frame9ItemModel.categoryName.value = element['name'].toString();
      frame9ItemModelList.add(frame9ItemModel);
    }
    homeModelObj.value.frame9ItemList.value = frame9ItemModelList;

    // Update frame10 items
    List<Frame10ItemModel> frame10ItemModelList = [];
    for (var element in frame10Items) {
      var frame10ItemModel = Frame10ItemModel();
      frame10ItemModel.name.value = element['name'].toString();
      frame10ItemModel.image.value = element['image'].toString();
      frame10ItemModel.price.value = element['price'].toString();
      frame10ItemModel.discount.value = element['discount'].toString();
      frame10ItemModelList.add(frame10ItemModel);
    }
    homeModelObj.value.frame10ItemList.value = frame10ItemModelList;

    // Update frame13 items
    List<Frame13ItemModel> frame13ItemModelList = [];
    for (var element in frame13Items) {
      var frame13ItemModel = Frame13ItemModel();
      frame13ItemModel.name.value = element['name'].toString();
      frame13ItemModel.image.value = element['image'].toString();
      frame13ItemModel.price.value = element['price'].toString();
      frame13ItemModel.rating.value = element['rating'].toString();
      frame13ItemModelList.add(frame13ItemModel);
    }
    homeModelObj.value.frame13ItemList.value = frame13ItemModelList;

    // Update frame14 items
    List<Frame14ItemModel> frame14ItemModelList = [];
    for (var element in frame14Items) {
      var frame14ItemModel = Frame14ItemModel();
      frame14ItemModel.name.value = element['name'].toString();
      frame14ItemModel.image.value = element['image'].toString();
      frame14ItemModel.price.value = element['price'].toString();
      frame14ItemModel.description.value = element['description'].toString();
      frame14ItemModelList.add(frame14ItemModel);
    }
    homeModelObj.value.frame14ItemList.value = frame14ItemModelList;
  }

  void onFetchItemsSuccess(var response) {
    getItemsResp = GetCategoryResp.fromJson(response);
  }

  void onFetchItemsError(var err) {
    Get.rawSnackbar(
      messageText: Text('$err', style: TextStyle(color: Colors.white)),
    );
  }

  void _onFetchItemsSuccess() {
    // This is now handled in _updateModelObjects
  }

  void _onFetchItemsError() {
    Get.rawSnackbar(
      messageText: Text(
        'Something bad Happened on server',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

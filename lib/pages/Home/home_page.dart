import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/material_model.dart';
import '../../core/widgets/material_card.dart';
import '../../core/widgets/custom_circular_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();

  final List<DocumentSnapshot> _materials = [];
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  static const int _limit = 10;

  @override
  void initState() {
    super.initState();
    _getMaterials();
    onScroll();
  }

  void onScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _getMaterials();
      }
    });
  }

  Future<void> _getMaterials() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    Query query = _firestore
        .collection('materials')
        .orderBy('createdAt', descending: true)
        .limit(_limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;
      _materials.addAll(querySnapshot.docs);
    }

    if (querySnapshot.docs.length < _limit) {
      _hasMore = false;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        controller: _scrollController,
        itemCount: _materials.length + (_isLoading ? 1 : 0),
        itemBuilder: (_, index) {
          if (index < _materials.length) {
            final MaterialModel material = MaterialModel.fromMap(
              _materials[index].data() as Map<String, dynamic>,
            );
            return MaterialCard(material: material);
          } else {
            return const CustomCircularIndicator();
          }
        },
      ),
    );
  }
}

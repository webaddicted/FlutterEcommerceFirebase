import 'dart:ui';
import 'package:flutter/material.dart';

class DummyData {
  static List<Map<String, dynamic>> getDummyCategories() {
    return [
      {
        'name': 'Fruits & Vegetables',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=500',
        },
        'sId': 'cat_001',
      },
      {
        'name': 'Dairy & Bakery',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1608198093002-ad4e505484ba?w=500',
        },
        'sId': 'cat_002',
      },
      {
        'name': 'Meat & Fish',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=500',
        },
        'sId': 'cat_003',
      },
      {
        'name': 'Beverages',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=500',
        },
        'sId': 'cat_004',
      },
      {
        'name': 'Snacks & Munchies',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1582169296194-d4d644c5bb9e?w=500',
        },
        'sId': 'cat_005',
      },
      {
        'name': 'Household Items',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=500',
        },
        'sId': 'cat_006',
      },
      {
        'name': 'Personal Care',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=500',
        },
        'sId': 'cat_007',
      },
      {
        'name': 'Baby Care',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1519689680058-324335c77eba?w=500',
        },
        'sId': 'cat_008',
      },
      {
        'name': 'Pet Care',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?w=500',
        },
        'sId': 'cat_009',
      },
      {
        'name': 'Frozen Foods',
        'icon': {
          'url':
              'https://images.unsplash.com/photo-1580013759032-c96505e24c1f?w=500',
        },
        'sId': 'cat_010',
      },
    ];
  }

  static List<Map<String, dynamic>> getDummyFrame10() {
    return [
      {
        'name': 'Fresh Fruits',
        'image':
            'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=500',
        'price': '₹299',
        'discount': '20% OFF',
        'sId': 'frame10_001',
      },
      {
        'name': 'Organic Vegetables',
        'image':
            'https://images.unsplash.com/photo-1597362925123-77861d3fbac7?w=500',
        'price': '₹199',
        'discount': '15% OFF',
        'sId': 'frame10_002',
      },
      {
        'name': 'Fresh Dairy',
        'image':
            'https://images.unsplash.com/photo-1608198093002-ad4e505484ba?w=500',
        'price': '₹149',
        'discount': '10% OFF',
        'sId': 'frame10_003',
      },
    ];
  }

  static List<Map<String, dynamic>> getDummyFrame13() {
    return [
      {
        'name': 'Premium Fruits',
        'image':
            'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=500',
        'price': '₹399',
        'rating': '4.5',
        'sId': 'frame13_001',
      },
      {
        'name': 'Fresh Vegetables',
        'image':
            'https://images.unsplash.com/photo-1597362925123-77861d3fbac7?w=500',
        'price': '₹299',
        'rating': '4.3',
        'sId': 'frame13_002',
      },
      {
        'name': 'Organic Dairy',
        'image':
            'https://images.unsplash.com/photo-1608198093002-ad4e505484ba?w=500',
        'price': '₹249',
        'rating': '4.7',
        'sId': 'frame13_003',
      },
    ];
  }

  static List<Map<String, dynamic>> getDummyFrame14() {
    return [
      {
        'name': 'Seasonal Fruits',
        'image':
            'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=500',
        'price': '₹349',
        'description': 'Fresh seasonal fruits',
        'sId': 'frame14_001',
      },
      {
        'name': 'Organic Vegetables',
        'image':
            'https://images.unsplash.com/photo-1597362925123-77861d3fbac7?w=500',
        'price': '₹249',
        'description': 'Farm fresh vegetables',
        'sId': 'frame14_002',
      },
      {
        'name': 'Premium Dairy',
        'image':
            'https://images.unsplash.com/photo-1608198093002-ad4e505484ba?w=500',
        'price': '₹199',
        'description': 'Pure dairy products',
        'sId': 'frame14_003',
      },
    ];
  }
}

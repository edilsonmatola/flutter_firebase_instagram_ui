import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';

// Web Width Size
const webScreenSize = 600;
List<Widget> homeScreenItems = [
  FeedScreen(),
  Center(
    child: Text('Search'),
  ),
  AddPostScreen(),
  Center(
    child: Text('Notifications'),
  ),
  Center(
    child: Text('Profile'),
  ),
];

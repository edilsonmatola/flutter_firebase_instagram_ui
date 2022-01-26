import 'package:flutter/material.dart';
import '../screens/add_post_screen.dart';
// Web Width Size
const webScreenSize = 600;
const homeScreenItems = [
  Center(
    child: Text('Feed'),
  ),
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

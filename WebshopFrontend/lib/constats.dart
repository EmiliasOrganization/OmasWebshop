import 'dart:ui';

//LandingPage Sites

const List<String> contentElements = [
  'LandingPage',
  'Shop',
  'AboutUs',
];

//Color Scheme

const Color schemeColorOrange = Color(0xFFFFA54F);
const Color schemeColorGreen = Color(0xff4A6840);
const Color schemeColorMistyRose= Color(0xFFF6DEE0);

// Api Paths
///Shop Api
const String shopApi = 'http://localhost:8080/api/shop';
///Auth Api
const String authApiVerify = 'http://localhost:8000/api/auth/register/verify';


//LandingPage AboutUs Elements

final List<String> imgList = [
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];


// Build something Backend and Frontend can read to generify it
//Shop Categories
enum Category {
  EMPTY,
  BAGS,
  HATS,
  CHILDREN,
  SOCKS,
  CUDDLY_TOYS,
  GLOVES,
  CUSHIONS,
  BACKPACKS,
}

enum SubCategory
{
  EMPTY,
  // BAGS
  BAGS_SHOPPINGBAGS,
  BAGS_SHOULDERBAGS,
  BAGS_CROSSOVERS,
  //HATS
  HATS_HATS,
  HATS_HEADBANDS,
  HATS_TOQUES,
}


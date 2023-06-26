import 'dart:ui';

const String title = 'ArtisManus';

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


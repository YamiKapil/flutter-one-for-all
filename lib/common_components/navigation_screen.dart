import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_for_all/battery_level/battery_level.dart';
import 'package:one_for_all/click_game/click_game.dart';
import 'package:one_for_all/flutter_animation/animation_home.dart';
import 'package:one_for_all/flutter_animation/animation_td.dart';
import 'package:one_for_all/flutter_animation/chain_animation.dart';
import 'package:one_for_all/flutter_animation/custom_painter_polygon_animations/custom_painter_polygons_animation.dart';
import 'package:one_for_all/flutter_animation/hero_animation.dart';
import 'package:one_for_all/flutter_animation/implict_animation.dart';
import 'package:one_for_all/flutter_map/track_map.dart';
import 'package:one_for_all/flutter_painter/my_graph.dart';
import 'package:one_for_all/flutter_painter/paint_curves.dart';
import 'package:one_for_all/flutter_painter/path_painter.dart';
import 'package:one_for_all/flutter_weird/steless_to_stateful.dart';
import 'package:one_for_all/google_login/google_login.dart';
import 'package:one_for_all/google_map_live/google_map_live_screen.dart';
import 'package:one_for_all/isolate_and_compute/isolate_example.dart';
import 'package:one_for_all/like_animation/like_animation_screen.dart';
import 'package:one_for_all/loading_success_animation/loading_success_animation.dart';
import 'package:one_for_all/responsive_row/responsive_row.dart';
import 'package:one_for_all/tap_puzzle/screens/player_selection_screen.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_game_screen.dart';
import 'package:one_for_all/tap_puzzle/screens/tap_puzzle_splash.dart';
import 'package:one_for_all/wifi_scan_inapp/wifi_scan_screen.dart';

import '../a paint and painter/paint_demo.dart';
import '../amazing_brick/amazing_brick.dart';
import '../animated_listview_builder/animate_image.dart';
import '../animated_listview_builder/animated_listview_builder.dart';
import '../animated_listview_builder/initial_animated_listview.dart';
import '../custom_pie_chart/custom_pie_chart.dart';
import '../flutter_animation/tween_animation.dart';
import '../liquid_circular_progress/liquid_page.dart';
import '../riverpod_guide/riverpod_guide_home.dart';
import '../text_to_speech/flutter_text_to_speech.dart';
import 'animated_list_item.dart';
import '../bubble_trouble/bubble_home.dart';
import '../habit_tracker/habit_home.dart';
import 'navigation_button.dart';

List<Widget> listOfScreens = [
  const NavigationButton(
    screenName: 'Bubble Trouble',
    navigationScreen: BubbleHome(),
    appImage: 'assets/gifs/itachi.gif',
  ),
  const NavigationButton(
    screenName: 'Habit Tracker',
    navigationScreen: HabitHome(),
    appImage: 'assets/images/yugi2.png',
  ),
  const NavigationButton(
    screenName: 'Responsive Row',
    navigationScreen: ResponsiveRow(),
    appImage: 'assets/images/yugi2.png',
  ),
  const NavigationButton(
    screenName: 'Battery Level',
    navigationScreen: BatteryLevel(),
    icon: Icons.battery_unknown,
  ),
  NavigationButton(
    screenName: 'Tap Puzzle',
    // navigationScreen: PlayerSelectionScreen(),
    navigationScreen: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TapPuzzleSplash(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: GoogleFonts.audiowide().fontFamily,
      ),
    ),
    // icon: Icons.touch_app_outlined,
    appImage: 'assets/images/card_bg.jpg',
    appColor: Colors.lime,
  ),
  const NavigationButton(
    screenName: 'Animated Listview',
    navigationScreen: AnimatedListViewBuilder(),
    icon: Icons.list_alt_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Initial ListView Animation',
    navigationScreen: InitialAnimatedListView(index: 25),
    icon: Icons.line_style,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Initial ListView Animation',
    navigationScreen: AnimatedImage(),
    icon: Icons.line_style,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Riverpod Guide',
    navigationScreen: RiverpodGuideHome(),
    icon: Icons.waves_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Flutter text to speech',
    navigationScreen: FlutterTextToSpeech(),
    icon: Icons.waves_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Flutter Amazing Brick',
    navigationScreen: AmazingBrick(),
    icon: Icons.tab_sharp,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Animation',
    navigationScreen: AnimationHome(),
    icon: Icons.animation_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Chain Animation',
    navigationScreen: ChainAnimation(),
    icon: Icons.animation_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: '3D Animation',
    navigationScreen: Animation3D(),
    icon: Icons.animation_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Hero Animation',
    navigationScreen: HeroAnimation(),
    icon: Icons.animation_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Implict Animation',
    navigationScreen: ImplictAnimation(),
    icon: Icons.offline_bolt,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Tween Animation',
    navigationScreen: TweenAnimation(),
    icon: Icons.offline_bolt,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Custom Pie Chart',
    navigationScreen: CustomPieChart(),
    icon: Icons.pie_chart,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Painter and Polygons Animation',
    navigationScreen: CustomPainterPolygonsAnimation(),
    icon: Icons.pie_chart,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Painter and Polygons Animation',
    navigationScreen: LoadingSuccessAnimation(),
    icon: Icons.circle_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Painter and Polygons Animation',
    navigationScreen: PaintCurves(),
    icon: Icons.line_axis_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  NavigationButton(
    screenName: 'Painter and Polygons Animation',
    navigationScreen: PathExample(),
    icon: Icons.line_axis_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  NavigationButton(
    screenName: 'Liquid Circular Progress Indicator',
    navigationScreen: LiquidCircularProgressIndicatorPage(),
    icon: Icons.line_axis_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Click Game',
    navigationScreen: GameWidget(),
    icon: Icons.touch_app_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Isolate & Compute',
    navigationScreen: IsolateExample(),
    icon: Icons.touch_app_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  NavigationButton(
    screenName: 'Stateless to Stateful',
    navigationScreen: StateLessToStateFul(),
    icon: Icons.touch_app_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  NavigationButton(
    screenName: 'Paint Demo',
    navigationScreen: PaintDemo(),
    icon: Icons.format_paint_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Limit Graph',
    navigationScreen: MyLimitGraphWidget(
        heading: '',
        percentageValue: 50,
        percentageValueInString: '50',
        value: ''),
    icon: Icons.line_axis_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Google Login',
    navigationScreen: GoogleLoginScreen(),
    icon: Icons.line_axis_rounded,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Like Animation',
    navigationScreen: LikeAnimationScreen(),
    icon: Icons.favorite,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Google Live Map',
    navigationScreen: GoogleMapLiveScreen(),
    icon: Icons.map_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
  const NavigationButton(
    screenName: 'Google Live Map',
    navigationScreen: LocationTrackingScreen(),
    icon: Icons.map_outlined,
    // appImage: 'assets/images/card_bg.jpg',
  ),
];

import 'package:hive/hive.dart';
import 'package:one_for_all/habit_tracker/date_time/date_time.dart';

// reference our box
final _myBox = Hive.box('habit_database');

class HabitDatabase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  // create initial data
  void createDefaultData() {
    todaysHabitList = [
      ['Read a book', false],
    ];

    _myBox.put('start_date', todayDateFormatted());
  }

  // load data if it already exists
  void loadData() {
    // if it's a new day, get habit list from database
    if (_myBox.get(todayDateFormatted()) == null) {
      todaysHabitList = _myBox.get('current_habit_list');
      // set all habits completed to false since its a new day
      // for (var i in todaysHabitList) {
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
    // if it's not a new day, load todays list
    else {
      todaysHabitList = _myBox.get(todayDateFormatted());
    }
  }

  // update database
  void updateDatabase() {
    // update today entry
    _myBox.put(todayDateFormatted(), todaysHabitList);

    // update universal habit list in case it changed
    _myBox.put('current_habit_list', todaysHabitList);

    // calculate habit complete percentages for each day
    caluclateHabitPercentage();

    // load heat map
    loadHeatMap();
  }

  void caluclateHabitPercentage() {
    int countComplete = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countComplete++;
      }
    }
    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (countComplete / todaysHabitList.length).toStringAsFixed(1);
    _myBox.put('percentage_summary_${todayDateFormatted()}', percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDataTimeObject(_myBox.get('start_date'));

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDataTimeToString(
        startDate.add(Duration(days: i)),
      );
      double strength = double.parse(
        _myBox.get('percentage_summary_$yyyymmdd') ?? '0.0',
      );

      // split the datetime up like below so it doesnot worry about hours/min/sec etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEarchDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strength).toInt()
      };

      heatMapDataSet.addEntries(percentForEarchDay.entries);
    }
  }
}

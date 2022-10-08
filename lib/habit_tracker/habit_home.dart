import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:one_for_all/habit_tracker/components/monthly_summary.dart';
import 'package:one_for_all/habit_tracker/components/my_fab.dart';
import 'package:one_for_all/habit_tracker/components/new_habit_box.dart';
import 'package:one_for_all/habit_tracker/data/habit_database.dart';

import 'components/habit_tile.dart';

class HabitHome extends StatefulWidget {
  const HabitHome({super.key});

  @override
  State<HabitHome> createState() => _HabitHomeState();
}

class _HabitHomeState extends State<HabitHome> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box('habit_database');

  @override
  void initState() {
    // if there is no current habit list, then it is the 1st time
    // then create default data
    if (_myBox.get('current_habit_list') == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    // update the database
    db.updateDatabase();
    super.initState();
  }

  // // bool to control the habit complete checkbox
  // bool habitCompleted = false;

  // checkbox tap function
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
    });
    db.updateDatabase();
  }

  //create a new habit
  final _textController = TextEditingController();
  void createNewHabit() {
    // show alert dialog for user to enter the new habit details
    showDialog(
        context: context,
        builder: (context) {
          return NewHabitBox(
            controller: _textController,
            onSave: saveNewHabit,
            onCancel: cancelNewHabit,
          );
        });
  }

  // save new habit
  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_textController.text, false]);
    });
    Navigator.of(context).pop();
    _textController.clear();
    db.updateDatabase();
  }

  // cancel new habit
  void cancelNewHabit() {
    Navigator.of(context).pop();
    _textController.clear();
  }

  // edit habit tapped
  void editTapped(index) {
    showDialog(
      context: context,
      builder: (context) {
        return NewHabitBox(
          controller: _textController,
          onSave: () => editHabit(index),
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  // edit habit
  void editHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _textController.text;
    });
    _textController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // delete habit
  void deleteTapped(index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: ListView(
          shrinkWrap: true,
          children: [
            // monthly summary heat map
            MonthlySummary(
              datasets: db.heatMapDataSet,
              startDate: _myBox.get('start_date'),
            ),
            // list of habits
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todaysHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: db.todaysHabitList[index][0],
                  habitCompleted: db.todaysHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  editTapped: (context) => editTapped(index),
                  deleteTapped: (context) => deleteTapped(index),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
    );
  }
}

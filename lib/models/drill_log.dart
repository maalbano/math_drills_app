import 'drill.dart';
import 'package:localstorage/localstorage.dart';

class DrillLog {
  LocalStorage drillLog;
  Map _allDrills;

  DrillLog() {
    drillLog = LocalStorage('drill_log');
    initLog();

  }

  void initLog() async {
    bool ready = await drillLog.ready;
    if (ready) {
      _allDrills = drillLog.getItem('all_drills');
      if (_allDrills == null) {
        _allDrills = Map<String, dynamic>();
      }
      print('retrieved list with length ${_allDrills.length}');
      print(_allDrills.keys);
      //print(_allDrills);
    }
  }

  void clearDrills() async {
    _allDrills = Map<String, dynamic>();
    await drillLog.setItem('all_drills', _allDrills);
  }

  void saveDrill(Drill drill) async {
   if (_allDrills == null) {
     _allDrills = Map<String, dynamic>();
   }

   var timestamp = DateTime.now().millisecondsSinceEpoch;
   _allDrills[timestamp.toString()] = drill.toJSONEncodable();

   print('saving list with length ${_allDrills.length}');
   await drillLog.setItem('all_drills', _allDrills);
    print('done. try retrieving');
   _allDrills = drillLog.getItem('all_drills');
   print('retrieved list with length ${_allDrills.length}');

 }

  Map<String, dynamic> getDrillLog()  {
   return _allDrills;
 }

 double computeAccuracy() {

    double total = 0;
    double max = 0;

    _allDrills.forEach((key, value) {
      Drill drill = Drill.fromMap(value);
      total += drill.finalScore;
      max += drill.questions.length;
    });

    return total/max * 100;

 }

 double computeAveSpeed() {
   double total = 0;


   _allDrills.forEach((key, value) {
     Drill drill = Drill.fromMap(value);
     total += drill.drillTime;
   });

   return total/_allDrills.length;
 }


}

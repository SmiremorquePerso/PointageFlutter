import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Pointage extends StatefulWidget {
  @override
  _PointageState createState() => _PointageState();
}

class _PointageState extends State<Pointage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    /* onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),*/
  );

  @override
  void initState() {
    super.initState();
    /*_stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));*/
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime = StopWatchTimer.getDisplayTime(value,
                    hours: _isHours, milliSecond: false);
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// Button
          Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.lightBlue,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                          },
                          child: const Text(
                            'Start',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.green,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                          },
                          child: const Text(
                            'Stop',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.red,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

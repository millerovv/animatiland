import 'dart:async';

import 'package:flutter/material.dart';

/// Emulates list data loading
///
/// After "load" animates sliding list of data on screen
class LoadedListPage extends StatefulWidget {
  @override
  _LoadedListPageState createState() => _LoadedListPageState();
}

class _LoadedListPageState extends State<LoadedListPage> {
  static const _stubData = ['Sam', 'Andrew', 'Sabrina', 'Karl', 'Dan', 'Ben', 'Sansa', 'Alex', 'Julia', 'Hans'];

  bool _isLoaded = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => setState(() => _isLoaded = !_isLoaded));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: AppearAfterLoaded(
              isLoaded: _isLoaded,
              loadingChild:
                  SizedBox(height: MediaQuery.of(context).size.height - 200, child: const Center(child: CircularProgressIndicator())),
              loadedChild: Column(
                children: List.generate(
                    _stubData.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(title: Text(_stubData[index]), tileColor: Colors.white),
                        )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class AppearAfterLoaded extends StatelessWidget {
  const AppearAfterLoaded({Key key, this.isLoaded = false, @required this.loadingChild, @required this.loadedChild}) : super(key: key);

  final bool isLoaded;
  final Widget loadingChild;
  final Widget loadedChild;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: !isLoaded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
      firstCurve: Curves.easeIn,
      secondCurve: Curves.easeIn,
      firstChild: loadingChild,
      secondChild: TweenAnimationBuilder(
        tween: Tween<double>(begin: 54, end: isLoaded ? 0 : 54),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        builder: (context, offset, _) => AnimatedOpacity(
          opacity: isLoaded ? 1 : 0,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
          child: Padding(padding: EdgeInsets.only(top: offset), child: loadedChild),
        ),
      ),
    );
  }
}

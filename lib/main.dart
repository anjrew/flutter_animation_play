import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Animations',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Animations'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
        with TickerProviderStateMixin {
    int _tabIndex = 0;
    TabController _tabController;

    // Animated Container Values
    Map<String, dynamic> aniConiVals = {
        "padding": 10.0,
        "width": 100.0,
        "height": 100.0
    };

    // Animated builder values
    Animation<int> _animation;
    AnimationController _animationController;
    int _delay = 1;

    List<Widget> _tabViews;

    @override
    void initState() {
        super.initState();
        _animationController = new AnimationController(
                duration: Duration(seconds: _delay), vsync: this);
        _animation = new Tween(begin: 45, end: 360).animate(_animationController);
        _generateTabViews();
        _tabController = new TabController(
                initialIndex: 0, vsync: this, length: _tabViews.length);
    }

   
    @override
    Widget build(BuildContext context) {

        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),
            body: TabBarView(
                controller: _tabController,
                children: _tabViews,
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {},
                tooltip: 'Animate',
                child: Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
				selectedItemColor: Colors.blue,
				unselectedItemColor: Colors.red,
                currentIndex: _tabIndex,
                onTap: switchTabs,
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.airplanemode_active),
                        title: Text("Animated Container"),
						
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.build),
                        title: Text("Animated Builder"),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.transfer_within_a_station),
                        title: Text("Tween"),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.transfer_within_a_station),
                        title: Text("Transform"),
                    ),
                ],
            ),
        );
    }

    void changeAnimatedContainer() {
        setState(() {
            aniConiVals = {
                "padding": Random().nextDouble() * 10,
                "width": Random().nextDouble() * 200,
                "height": Random().nextDouble() * 200
            };
			_generateTabViews();
        });
    }

	void switchTabs(int index){
		setState(() {
			_tabIndex = index;
			_tabController.animateTo(index);
		});
	}

	 void _generateTabViews() {
        _tabViews = [
          _makeAnimatedContainer(),
          Container(
              key: UniqueKey(),
              alignment: Alignment.center,
              child: Column(children: [
                  AnimatedBuilder(
                      animation: _animationController,
                      child: FlutterLogo(),
                      builder: (BuildContext context, Widget child) => Transform.rotate(
                          angle: _animation.value.toDouble(),
                          child: child,
                      ),
                  ),
              ]),
          ),
          Container(
              key: UniqueKey(),
              alignment: Alignment.center,
              child: AnimatedContainer(
                  duration: Duration(seconds: 1),
              ),
          ),
      ];
    }

	Widget _makeAnimatedContainer(){
		return Container(
				key: const Key("Animated container main"),
				alignment: Alignment.center,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
					AnimatedContainer(
						key: const Key("Animated container"),
						padding: EdgeInsets.all(aniConiVals["padding"]),
						alignment: Alignment.center,
						decoration: BoxDecoration(
							color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
							shape: aniConiVals["width"] < 100 ? BoxShape.circle : BoxShape.rectangle,
							border: Border.all(
								color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
								width: Random().nextDouble() * 10
							)
						),
						width: aniConiVals["width"],
						height: aniConiVals["height"],
						duration: Duration(seconds: 1),
					),
					Text("The Random number is ${Random().nextInt(255)}"),
					IconButton(
						icon: Icon(Icons.add),
						onPressed: changeAnimatedContainer,
					),
				]),
          );
	}
}

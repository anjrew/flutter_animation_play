import 'package:flutter/material.dart';

class ValueAnimation extends StatefulWidget {
    @override
    _ValueAnimationState createState() => _ValueAnimationState();
}

class _ValueAnimationState extends State<ValueAnimation> with SingleTickerProviderStateMixin{
    Animation<double> _animation;
    AnimationController _animationController;
    int _delay = 1;
    double _min = 0;
    double _max = 6;
    double _sliderLevel = 0;

	@override
    void initState() {
        super.initState();
        _animationController = new AnimationController(
                duration: Duration(seconds: _delay), vsync: this);
		_animationController.addStatusListener((AnimationStatus status) {
			switch(status){
				case AnimationStatus.completed:
					Scaffold.of(context).showSnackBar(SnackBar(content: Text("Animation completed"),));
				break;
				case AnimationStatus.dismissed:
					Scaffold.of(context).showSnackBar(SnackBar(content: Text("Animation dismissed"),));
				break;
				case AnimationStatus.forward:
					Scaffold.of(context).showSnackBar(SnackBar(content: Text("Animation forward"),));
				break;
				case AnimationStatus.reverse:
					Scaffold.of(context).showSnackBar(SnackBar(content: Text("Animation reverse"),));
				break;
			}
		});
		_animationController.addListener(() => setState((){}));
        _animation =
                new Tween<double>(begin: _min, end: _max).animate(_animationController);
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            key: const Key("animatedBuilder"),
            alignment: Alignment.center,
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
						Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                                "Animating with value and setState",
                                style: Theme.of(context).textTheme.title,
                            ),
                        ),
						
                        Transform.rotate(
                            angle: _animation.value,
                            child: FlutterLogo(size: 300),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                IconButton(
                                    tooltip: "Move forward",
                                    icon: Icon(Icons.forward),
                                    onPressed: () => _animationController.forward(),
                                ),
                                IconButton(
                                    tooltip: "Move backward",
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () => _animationController.reverse(),
                                ),
                                IconButton(
                                    tooltip: "Fling",
                                    icon: Icon(Icons.restaurant_menu),
                                    onPressed: () => _animationController.fling(),
                                ),
                            ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                                IconButton(
                                    tooltip: "repeat",
                                    icon: Icon(Icons.repeat),
                                    onPressed: () => _animationController.repeat(),
                                ),
                                IconButton(
                                    tooltip: "Stop",
                                    icon: Icon(Icons.stop),
                                    onPressed: () => _animationController.stop(),
                                ),
                            ],
                        ),
                        Slider(
                            label: _sliderLevel.toString(),
                            value: _sliderLevel,
                            divisions: 12,
                            min: _min,
                            max: _max,
                            onChanged: _sliderMoved,
                        )
                    ]),
        );
    }

    void _sliderMoved(double level) {
        print(level);
        setState(() => _sliderLevel = level);
        _animationController.animateTo(level / 6);
    }
}

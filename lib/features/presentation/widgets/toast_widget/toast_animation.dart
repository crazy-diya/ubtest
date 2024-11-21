import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:union_bank_mobile/utils/extension.dart';

enum AniProps { opacity, translateY }

class SlideInToastMessageAnimation extends StatelessWidget {
  final Widget child;

  const SlideInToastMessageAnimation(this.child);

  @override
  Widget build(BuildContext context) {
    
    final tween = MovieTween()
      ..tween(AniProps.translateY, (-100.0).tweenTo(0.0),duration: 250.milliseconds,curve:Curves.easeOut)
      ..tween(AniProps.translateY, (0.0).tweenTo(0.0), duration:const Duration(seconds: 3, milliseconds: 250))
      ..tween(AniProps.translateY, (0.0).tweenTo(-100.0),duration: 250.milliseconds,curve:Curves.easeIn)
      ..tween(AniProps.opacity, (0.0).tweenTo(1.0),duration:  500.milliseconds)
      ..tween(AniProps.translateY, (1.0).tweenTo(1.0),duration:  3.seconds)
      ..tween(AniProps.translateY, (1.0).tweenTo(0.0),duration:  500.seconds);

    

    return PlayAnimationBuilder<Movie>(
      duration: tween.duration,
      tween: tween,
      builder: (context, animation,  child) => Opacity(
        opacity: animation.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AniProps.translateY)),
            child: child),
      ),
      child: child,
    );
  }
}

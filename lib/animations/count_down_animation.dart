//animation
import 'package:animation_assets/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CountDownAnimation extends HookConsumerWidget {
  const CountDownAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1000),
    );
    useAnimation(animationController);

    final count = useState(3);

    // void coundDownStop() {
    //   ref.read(countDownStateProvider.notifier).stop();
    // }

    useEffect(() {
      print(count.value);
      animationController.forward();

      animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print('--');
          animationController.reset();
          count.value--;
          if (count.value == 0) {
            print('Finish');
            ref.read(countDownStateProvider.notifier).stop();
          }
        }
      });
      return null;
    }, [count.value]);

    return Container(
      color: Colors.black54,
      child: Center(
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform.scale(
                  scale: animationController.value,
                  child: Text(
                    count.value.toString(),
                    style: TextStyle(
                        fontSize: 250,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ));
            }),
      ),
    );
  }
}

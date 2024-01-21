import '../../../core/base/base.dart';

class ItemPersonWidget extends StatelessWidget {
  final Animation<double> animation;
  final VoidCallback? onTap;
  final int item;
  final bool selected;
  final bool removing;

  const ItemPersonWidget({
    super.key,
    required this.animation,
    this.onTap,
    required this.item,
    this.selected = false,
    this.removing = false,
  }) : assert(item >= 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
        top: 2.0,
      ),
      child: ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: removing ? Curves.easeInOut : Curves.bounceOut),
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: selected ? Colors.black12 : Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text(
                  (item + 1).toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

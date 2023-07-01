import 'package:fluent_ui/fluent_ui.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderWidget extends StatelessWidget {
  final Widget? child;
  final Widget? child2;
  final Widget? child3;
  final int? pageCount;
  const SliderWidget(
      {super.key, this.child, this.child2, this.pageCount, this.child3});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            children: [
              if (child != null) child!,
              if (child2 != null) child2!,
              if (child3 != null) child3!,
            ],
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: pageController,
          count: pageCount ?? 2,
          effect: WormEffect(
            dotColor: FluentTheme.of(context).borderInputColor,
            activeDotColor: FluentTheme.of(context).accentColor,
            dotHeight: 8,
            dotWidth: 8,
          ),
          onDotClicked: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }
}

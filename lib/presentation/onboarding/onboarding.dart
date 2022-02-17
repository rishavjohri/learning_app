import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/domain/model.dart';
import 'package:learning_app/presentation/onboarding/onBoarding_viewmodel.dart';
import 'package:learning_app/presentation/resources/assets_manager.dart';
// import 'package:learning_app/presentation/resources/assets_manager.dart';
import 'package:learning_app/presentation/resources/color_manager.dart';
import 'package:learning_app/presentation/resources/string_manager.dart';
import 'package:learning_app/presentation/resources/values_manager.dart';
// import 'package:learning_app/presentation/resources/theme_manager.dart';
import 'package:learning_app/presentation/resources/routes_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController = PageController(initialPage: 0);

  OnBoarding_viewModel _boarding_viewModel = OnBoarding_viewModel();
  _bind() {
    _boarding_viewModel.start();
  }

  @override
  void initState() {
    // TODO: implement initState
    _bind();
    super.initState();
  }
  //  List<SliderObject> _getSliderData() =>
  //     [
  //       SliderObject(AppStrings.onBoardingtitle1,
  //           AppStrings.onBoardingSubtitle1, ImageAssets.onboardingLogo1),
  //       SliderObject(AppStrings.onBoardingtitle2,
  //           AppStrings.onBoardingSubtitle2, ImageAssets.onboardingLogo2),
  //       SliderObject(AppStrings.onBoardingtitle3,
  //           AppStrings.onBoardingSubtitle3, ImageAssets.onboardingLogo3),
  //       SliderObject(AppStrings.onBoardingtitle4,
  //           AppStrings.onBoardingSubtitle4, ImageAssets.onboardingLogo4),
  //     ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _boarding_viewModel.outputSliderViewObject,
        builder: (context, snapShot) {
          return _getcontentWidget(snapShot.data);
        });
  }

  Widget _getcontentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfSlides,
            onPageChanged: (index) {
              _boarding_viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(sliderViewObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginRoute);
                    },
                    child: Text(
                      AppStrings.Skip,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.end,
                    ),
                  )),
              _getBottomSheetWidget(sliderViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: () {
                _pageController.animateToPage(_boarding_viewModel.getPrevious(),
                    duration: Duration(milliseconds: Durationconstant.d300),
                    curve: Curves.bounceInOut); // go to next slide
              },
            ),
          ),

          // circles indicator
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )
            ],
          ),

          // right arrow
          Padding(
            padding: EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
              onTap: () {
                // go to next slide_pageController.animateToPage(_getPreviousIndex(),
                _pageController.animateToPage(_boarding_viewModel.getNext(),
                    duration: Duration(milliseconds: Durationconstant.d300),
                    curve: Curves
                        .bounceInOut); // go to next slide: Curves.bounceInOut);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int _currentindex) {
    if (index == _currentindex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc); // selected slider
    } else {
      return SvgPicture.asset(ImageAssets.solidcircleIc); // unselected slider
    }
  }

  @override
  void dispose() {
    // view model.dispose
    _boarding_viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _sliderObject;

  OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}

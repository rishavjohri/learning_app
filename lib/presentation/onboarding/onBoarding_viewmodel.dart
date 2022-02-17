import 'dart:async';
import 'package:learning_app/domain/model.dart';
import 'package:learning_app/presentation/base/baseview.dart';
import 'package:learning_app/presentation/resources/assets_manager.dart';
import 'package:learning_app/presentation/resources/string_manager.dart';

class OnBoarding_viewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // Stream controller
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;

  int _currentIndex = 0;
  // inputs.
  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _list = _getSliderData();

    // send slider data to view .
    _postDataToView();
  }

  @override
  int getNext() {
    // TODO: implement getNext
     int nextIndex = _currentIndex ++;
  if(nextIndex >= _list.length )
  {
    _currentIndex = 0;
  }
return _currentIndex;
  }

  @override
  int getPrevious() {
    // TODO: implement getPrevious

     int previousIndex = _currentIndex --;
  if(previousIndex == -1)
  {
    _currentIndex = _list.length -1;
  }
 
  return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged

    _currentIndex=index;
    _postDataToView(); 
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SlideViewObject) => SlideViewObject);
  //private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingtitle1,
            AppStrings.onBoardingSubtitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingtitle2,
            AppStrings.onBoardingSubtitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingtitle3,
            AppStrings.onBoardingSubtitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingtitle4, AppStrings.onBoardingtitle4,
            ImageAssets.onboardingLogo4)
      ];
      _postDataToView()
      {
        inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
      }
}

// view model recieve input form view.
abstract class OnBoardingViewModelInputs {
  void getNext();
  void getPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

// view recieve output form viewmodel.
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

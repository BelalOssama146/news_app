import 'package:flutter/cupertino.dart';
import '../../../../data/api_manager.dart';
import '../../../../data/model/source.dart';
import '../../../base/base_api_state.dart';

class TabsViewModel extends ChangeNotifier{
  BaseApiState sourceApiState = BaseLoadingState() ;
  getSources(String categoryId) async{
    try{
      sourceApiState = BaseLoadingState();
      notifyListeners();
     List<Source> sources = (await ApiManager.getSources(categoryId)).sources!;
      sourceApiState = BaseSuccessState(sources);
      notifyListeners();
    }catch(e){
      sourceApiState = BaseErrorState(e.toString());
      notifyListeners();
    }
  }
}

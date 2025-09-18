import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/api_manager.dart';
import '../../../../data/model/source.dart';
import '../../../base/base_api_state.dart';

class TabsListCubit extends Cubit<TabsListState> {
  TabsListCubit() : super(TabsListState.initial());
  getSources(String categoryId) async{
    try{
      emit(TabsListState(tabsListApiState: BaseLoadingState()));
      List<Source> sources = (await ApiManager.getSources(categoryId)).sources!;
      emit(TabsListState(tabsListApiState: BaseSuccessState(sources)));
    }catch(e){
      emit(TabsListState(tabsListApiState: BaseErrorState(e.toString())));
    }
  }
}

class TabsListState {
  late BaseApiState tabsListApiState;

  TabsListState({required this.tabsListApiState});

  TabsListState.initial() {
    tabsListApiState = BaseIdleState();
  }

  TabsListState copyWith({BaseApiState? tabsListApiState}) {
    return TabsListState(
      tabsListApiState: tabsListApiState ?? this.tabsListApiState,
    );
  }
}

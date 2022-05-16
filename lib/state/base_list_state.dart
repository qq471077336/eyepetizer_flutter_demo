import 'package:eyepetizer_flutter_demo/model/paging_model.dart';
import 'package:eyepetizer_flutter_demo/viewmodel/base_list_viewmodel.dart';
import 'package:eyepetizer_flutter_demo/widget/loading_state_widget.dart';
import 'package:eyepetizer_flutter_demo/widget/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListState<L, M extends BaseListViewModel<L, PagingModel<L>>,
        T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  M get viewModel;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<M>(
        model: viewModel,
        onModelInit: (model) => model.refresh(),
        builder: (context, model, child) {
          return LoadingStateWidget(
            loadingState: model.loadingState,
            retry: model.retry,
            child: SmartRefresher(
              controller: model.refreshController,
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              enablePullUp: true,
              child: getContentChild(model),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;

  Widget getContentChild(M model);
}

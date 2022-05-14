import 'package:eyepetizer_flutter_demo/viewmodel/home/home_page_viewmodel.dart';
import 'package:eyepetizer_flutter_demo/widget/home/banner_widget.dart';
import 'package:eyepetizer_flutter_demo/widget/loading_state_widget.dart';
import 'package:eyepetizer_flutter_demo/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({Key? key}) : super(key: key);

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<HomePageViewModel>(
        model: HomePageViewModel(),
        onModelInit: (model) => model.refresh(),
        builder: (context, model, child) {
          return LoadingStateWidget(
            loadingState: model.loadingState,
            retry: model.retry,
            child: _banner(model),
          );
        });
  }

  _banner(model) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BannerWidget(model: model),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

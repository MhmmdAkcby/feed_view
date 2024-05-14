import 'package:feed_view/core/image_zoom/image_zoom.dart';
import 'package:flutter/material.dart';

import 'package:feed_view/model/json_model.dart';
import 'package:feed_view/services/json_services.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends FeedManage<FeedView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder<List<JsonModel>?>(
        future: _item,
        builder: (context, AsyncSnapshot<List<JsonModel>?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Placeholder();
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData) {
                final data = snapshot.data;
                return _ListViewCreate(data: data, defaultValue: _defaultValue);
              } else {
                return const Placeholder();
              }
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListViewCreate extends StatelessWidget {
  const _ListViewCreate({
    super.key,
    required this.data,
    required int defaultValue,
  }) : _defaultValue = defaultValue;

  final List<JsonModel>? data;
  final int _defaultValue;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data?.length ?? _defaultValue,
      itemBuilder: (context, index) {
        return _Card(data: data?[index]);
      },
    );
  }
}

class _Card extends StatelessWidget with ImageZoomMixin {
  const _Card({
    Key? key,
    required JsonModel? data,
  }) : _data = data;

  final JsonModel? _data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_data?.firstName ?? ''),
        leading: InkWell(
          onTap: () {
            imageZoom(context, _data?.avatar ?? '');
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(_data?.avatar ?? ''),
          ),
        ),
      ),
    );
  }
}

abstract class FeedManage<T extends StatefulWidget> extends State<T> {
  final int _defaultValue = 0;
  late final Future<List<JsonModel>?> _item;
  final IJsonServices _jsonServices = JsonServices();

  @override
  void initState() {
    super.initState();
    _item = _jsonServices.fetchJsonModelAdvance();
  }
}

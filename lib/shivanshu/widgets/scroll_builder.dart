import 'package:flutter/material.dart';
import 'package:spinner_try/shivanshu/utils.dart';
import 'package:spinner_try/shivanshu/utils/loading_elevated_button.dart';

class ScrollBuilder extends StatefulWidget {
  final Future<Iterable<Widget>> Function(
      BuildContext context, int start, int interval) loader;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final int interval;
  final Widget? loadingWidget;
  final bool automaticLoading;
  final bool reverse;
  final ScrollController? scrollController;
  final Widget? header;
  final Widget? footer;
  const ScrollBuilder({
    super.key,
    required this.loader,
    this.interval = 20,
    this.loadingWidget,
    this.automaticLoading = false,
    this.reverse = false,
    this.scrollController,
    this.separatorBuilder,
    this.header,
    this.footer,
  });

  @override
  State<ScrollBuilder> createState() => _ScrollBuilderState();
}

class _ScrollBuilderState extends State<ScrollBuilder>
    with AutomaticKeepAliveClientMixin {
  List<Widget> items = [];
  bool showLoadMore = true;
  bool initialized = false;

  bool showRetry = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMore(0).then((value) {
        if (context.mounted) {
          setState(() {
            initialized = true;
          });
        }
      }).onError((error, stackTrace) async {
        if (context.mounted) {
          showMsg(context, error.toString());
          setState(() {
            showRetry = true;
            initialized = true;
          });
        }
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int length = items.length +
        1 +
        (widget.header != null ? 1 : 0) +
        (widget.footer != null ? 1 : 0);
    return !initialized
        ? Center(
            child: widget.loadingWidget ??
                const CircularProgressIndicatorRainbow())
        : ListView.separated(
            reverse: widget.reverse,
            separatorBuilder:
                widget.separatorBuilder ?? (ctx, index) => Container(),
            // key: , add key here if the widgets rebuild on their own
            controller: widget.scrollController,
            itemCount: length,
            itemBuilder: (context, index) {
              if (widget.header != null) {
                if (index == 0) {
                  return widget.header;
                } else {
                  index--;
                }
              }
              if (widget.footer != null && index == length - 1) {
                return widget.footer;
              }
              if (index == items.length) {
                if (!showLoadMore) {
                  return Container();
                }
                if (widget.automaticLoading && !showRetry) {
                  _loadMore(index);
                  return widget.loadingWidget ??
                      const Center(child: CircularProgressIndicatorRainbow());
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingElevatedButton(
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(showRetry ? 'Retry' : 'Load more'),
                      errorHandler: (err) {
                        if (context.mounted) {
                          setState(() {
                            showRetry = true;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: showRetry ? Colors.red : null),
                      onPressed: () async => await _loadMore(index),
                    ),
                  ],
                );
              }
              return items[index];
            },
          );
  }

  Future<void> _loadMore(int start) async {
    Iterable<Widget> newItems = [];
    showRetry = false;
    try {
      newItems = await widget.loader(context, start, widget.interval);
    } catch (e) {
      if (context.mounted) {
        showMsg(context, e.toString());
        setState(() {
          showRetry = true;
          initialized = true;
        });
      }
      return;
    }
    if (newItems.length < widget.interval) {
      showLoadMore = false;
    }
    if (context.mounted) {
      setState(() {
        items.addAll(newItems);
      });
    }
  }
}

class ScrollBuilder2<T> extends StatefulWidget {
  const ScrollBuilder2({
    super.key,
    required this.loader,
    required this.itemBuilder,
    this.separatorBuilder,
    this.loadingMargin = 1000,
    this.footer,
  });
  final double loadingMargin;
  final Future<List<T>> Function(int start) loader;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget? footer;

  @override
  State<ScrollBuilder2> createState() => _ScrollBuilder2State<T>();
}

class _ScrollBuilder2State<T> extends State<ScrollBuilder2<T>> {
  // final _scrollController = ScrollController();
  final List<T> items = [];
  bool finished = false;
  String? err;

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener);
    fetchData();
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void _scrollListener() {
  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent - widget.loadingMargin) {
  //     fetchData();
  //   }
  // }

  Future<void> fetchData() async {
    try {
      err = null;
      final List<T> fetchedItems = (await widget.loader(items.length)).cast();
      if (fetchedItems.isEmpty) {
        setState(() {
          finished = true;
        });
        return;
      }
      setState(() {
        items.addAll(fetchedItems);
      });
    } catch (e) {
      setState(() {
        err = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == items.length) {
          if (err != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(err!),
                  LoadingElevatedButton(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    onPressed: fetchData,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  )
                ],
              ),
            );
          }
          if (finished) {
            return widget.footer ?? Container();
          }
          return FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                return const Center(child: CircularProgressIndicatorRainbow());
              });
        }
        return widget.itemBuilder(context, items[index]);
      },
      // controller: _scrollController,
      separatorBuilder:
          widget.separatorBuilder ?? (ctx, index) => const SizedBox(height: 10),
      itemCount: items.length + (finished ? 0 : 1),
    );
  }
}

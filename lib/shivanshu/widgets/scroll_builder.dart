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

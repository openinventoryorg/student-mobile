import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:line_icons/line_icons.dart';

typedef Future<T> FetchCallback<T>();

typedef Widget SnapshotWidgetBuilder<T>(BuildContext context, T data);

class HandledBuilder<T> extends StatefulWidget {
  final FetchCallback<T> fetch;
  final SnapshotWidgetBuilder<T> builder;

  const HandledBuilder({
    Key key,
    @required this.fetch,
    @required this.builder,
  }) : super(key: key);

  @override
  _HandledBuilderState<T> createState() => _HandledBuilderState<T>();
}

class _HandledBuilderState<T> extends State<HandledBuilder<T>> {
  T data;
  bool hasError;

  @override
  void initState() {
    super.initState();
    hasError = false;
    SchedulerBinding.instance.addPostFrameCallback((_) => load());
  }

  Future<void> load() async {
    setState(() {
      data = null;
      hasError = false;
    });
    try {
      T value = await widget.fetch();
      setState(() => data = value);
    } catch (err) {
      String errMessage = err.toString();
      if (err is DioError) {
        errMessage = err.message;
      }

      setState(() => hasError = true);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(errMessage, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.amber,
          action: SnackBarAction(
            label: 'OK',
            onPressed: Scaffold.of(context).hideCurrentSnackBar,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasError)
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(icon: Icon(LineIcons.refresh), onPressed: load),
            Text('Something went wrong'),
          ],
        ),
      );

    if (data == null) return Center(child: CircularProgressIndicator());

    return widget.builder(context, data);
  }
}

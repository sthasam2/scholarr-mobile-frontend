import 'package:flutter/material.dart';

Widget expandingAppBar(context, greeting, _pinned, _floating, _snap) {
  return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        pinned: _pinned,
        floating: _floating,
        snap: _snap,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 10.0,
        expandedHeight: 160.0,
        titleSpacing: 0.0,
        flexibleSpace: FlexibleSpaceBar(
          title: RichText(
            text: TextSpan(
                text: greeting,
                style: Theme.of(context).textTheme.bodyText2,
                children: [
                  TextSpan(
                    text: "\nYour name",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ]),
          ),
        ),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(
          height: 20,
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              color: index.isOdd ? Colors.white : Colors.black12,
              height: 100.0,
              child: Center(
                child: Text('$index', textScaleFactor: 5),
              ),
            );
          },
          childCount: 20,
        ),
      ),
    ],
  );
}

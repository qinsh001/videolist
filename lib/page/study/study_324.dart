import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videolist/network/x_http_utils.dart';
import 'package:videolist/utils/log_extensions.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../widget/sticky_child_delegate.dart';

class Study324 extends StatefulWidget {
  const Study324({super.key});

  @override
  State<Study324> createState() => _Study324State();
}

class _Study324State extends State<Study324> {
  late AppLifecycleListener lifecycleListener;

  @override
  void initState() {
    super.initState();
    lifecycleListener = AppLifecycleListener();
  }

  @override
  void dispose() {
    lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        _buildSliverBar(),
        _buildTitleText(),
        const PinnedHeaderSliver(child: Divider()),
        SliverPersistentHeader(
          delegate: StickyChildDelegate(
              child: PreferredSize(
                  preferredSize: Size.fromHeight(100),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Text('Header'),
                    color: Colors.red,
                  ))),
          floating: true,
        ),
        SliverResizingHeader(
          minExtentPrototype: Text(
            'One',
          ),
          maxExtentPrototype: Text('\nTwo\nThree'),
          child: Text(
            'SliverResizingHeader\nWith Two Optional\nLines of Text',
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: CarouselView(
                itemExtent: 300,
                shrinkExtent: 300,
                children: List<Widget>.generate(20, (int index) {
                  return UncontainedLayoutCard(
                      index: index, label: 'Item $index');
                }),
              ),
            ),
          ),
        ),
        SliverList.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text('Item $index'), onTap: () {});
          },
        ),
      ]),
    );
  }
}

Widget _buildSliverBar() {
  const Icon icon = Icon(CupertinoIcons.settings, color: Colors.blue);
  const TextStyle style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  const Text text = Text('Settings2', style: style);
  Widget action = IconButton(onPressed: () {}, icon: icon);
  return SliverLayoutBuilder(builder: (_, scs) {
    double factor = (scs.scrollOffset / kToolbarHeight).clamp(0, 1);
    factor = factor < 0.2 ? 0 : factor;
    AppBar header = AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      actions: [action],
      centerTitle: true,
      title: Opacity(opacity: factor, child: text),
    );
    return PinnedHeaderSliver(child: header);
  });
}

Widget _buildTitleText() {
  const TextStyle style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  const Text text = Text('Settings', style: style);
  return const SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(left: 12.0, bottom: 8),
      child: text,
    ),
  );
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({
    super.key,
    required this.index,
    required this.label,
  });

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.5),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.clip,
          softWrap: false,
        ),
      ),
    );
  }
}

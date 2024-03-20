import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';

class MultiSelectDialogChildren extends StatefulWidget {
  final List<dynamic> options;
  final List<String> selectedOptions;
  final String title;
  final VoidCallback? onTapOnAddChild;

  const MultiSelectDialogChildren({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.title,
    required this.onTapOnAddChild,
  });

  @override
  MultiSelectDialogChildrenState createState() =>
      MultiSelectDialogChildrenState();
}

class MultiSelectDialogChildrenState extends State<MultiSelectDialogChildren> {
  late List<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List<String>.from(widget.selectedOptions);
  }

  bool get allSelected => _selectedOptions.length == widget.options.length;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Toggle select all or deselect all items
                        if (allSelected) {
                          _selectedOptions.clear();
                        } else {
                          _selectedOptions.clear();
                          _selectedOptions.addAll(widget.options
                              .map((option) => option.toString()));
                        }
                      });
                    },
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Select All"),
                          if (allSelected)
                            SvgPicture.asset(
                              Assets.iconsCircleTick,
                              width: 24,
                              height: 24,
                            ),
                        ],
                      ),
                    ),
                    // ),
                    // Row(
                    //   children: [
                    //     const Text("Select All"),
                    //     if (allSelected)
                    //       SvgPicture.asset(
                    //         Assets.iconsCircleTick,
                    //         width: 24,
                    //         height: 24,
                    //       ),
                    //   ],
                    // ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.options.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Colors.transparent,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.options[index]),
                            if (_selectedOptions
                                    .contains(widget.options[index]) ||
                                allSelected)
                              SvgPicture.asset(
                                Assets.iconsCircleTick,
                                width: 24,
                                height: 24,
                              ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            final option = widget.options[index].toString();
                            if (_selectedOptions.contains(option)) {
                              _selectedOptions.remove(option);
                            } else {
                              _selectedOptions.add(option);
                            }
                          });
                        },
                        selected:
                            _selectedOptions.contains(widget.options[index]),
                        // selectedTileColor: Colors.grey.withOpacity(0.3),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: widget.onTapOnAddChild,
            child: const Text(
              "+ Add Child",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_selectedOptions);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

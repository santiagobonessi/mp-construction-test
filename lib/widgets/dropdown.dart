import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    Key? key,
    required this.placeholder,
    required this.elements,
    this.selectedValue,
    this.callback,
    this.isDisabled,
  }) : super(key: key);

  final String placeholder;
  final List<String> elements;
  final String? selectedValue;
  final dynamic callback;
  final bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: DropdownButton(
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 20,
                  hint: Text(placeholder),
                  style: Theme.of(context).textTheme.bodyText1,
                  value: selectedValue,
                  items: elements.map((element) {
                    return DropdownMenuItem<String>(
                      value: element,
                      child: Text(element),
                    );
                  }).toList(),
                  onChanged: (isDisabled != null && isDisabled == true)
                      ? null
                      : (selectedItem) {
                          callback(selectedItem);
                        },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

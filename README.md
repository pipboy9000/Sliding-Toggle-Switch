# Toggle Switch

A minimal sliding toggle switch widget. It can be customized with desired width, height and colors.

## Getting Started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  sliding_toggle_switch: ^1.0.0
```

Import it:

```dart
import 'package:sliding_toggle_switch/sliding_toggle_switch.dart';
```

## Usage Examples

### Basic toggle switch

```dart
// The minimum amount of code to use the switch:
            SlidingToggleSwitch(
              onChange: (value) {
                print(value);
              },
            ),
```
The default configurations look like this:
![Basic toggle switch](https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExc29yNGk5ZW82YzU0NHZocHV0dXhtY2l5eTEzdWltOGF6NnZxMnB4ZyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/XF5CaoWnsf65w0qSr3/giphy.gif)

### Example with all available customizable properties

```dart
    SlidingToggleSwitch(
        width: 100,
        height: 30,
        disabled: true,
        initialValue: true,
        thumbDisabledColor: Colors.grey,
        thumbOnColor: Colors.green.shade600,
        trackDisabledColor: Colors.grey.shade600,
        trackOffColor: Colors.transparent,
        trackOnColor: Colors.transparent,
        thumbOffColor: Colors.grey.shade300,
        borderColor: Colors.black38,
        borderWidth: 3,
        onChange: (value) {
            print(value);
        },
    ),
```

Various options can look like this:

![Basic toggle switch with custom height and font size](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcm9yeXN2OHV2bnU0cHp1NGw3aHA3M3l2ZHN3YWM0M3l3bnMxdDFldCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/e6LX8uOK6UA3kaL5Su/giphy.gif)
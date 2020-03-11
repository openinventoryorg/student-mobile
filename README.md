# Open Inventory Mobile App

A new Flutter project.

## Documentation

When documenting follow given guidelines,

### use `///` instead of `//` to document

```dart
// This is a regular comment

/// This is a documentation comment
```

### **Every** non UI class should be heavily documented

```dart
class LogicClass{
    final String _var;

    get var1 => _var;

    void _method(){
    }
}
```

This class should be documented as,

```dart
/// What this class does
class LogicClass{
    /// What is this variable?
    final String _var;

    /// Why is there a getter?
    get var1 => _var;

    /// What does this method do?
    /// Which objects uses this?
    void method(){
    }
}
```

### UI Classes(classes inside `/views`) do not need to documented

Classes inside view directory should be clutter free. So do not document then unless you do something implicitly or your intentions may not be clear. Howver all logic methods and callbacks should be lifted outside of the UI declaration and put in a method. Document this method as above.

```dart
class UIClass{
    @override
    Widget build(BuildContext context) {
    }

    Widget listTile(){
    }

    void onPress(){
    }
}
```

This should be documented as,

```dart
class UIClass{
    @override
    Widget build(BuildContext context) {
    }

    Widget listTile(){
    }

    /// What does this do?
    void onPress(){
    }
}
```

**Also move all callback methods and logic methods to the end of file. Method organizations should be,

1. constants
2. fields
3. contructor and factories
4. build methods(if any)
5. build helper methods
6. logic methods

# Day 1. GetX Overview

## Install

Addd dependencies in file pubspec.yaml

````
dependencies:
 
  get: ^3.4.6
  
````

## Get Started

### 1. State management

<b>Advantages</b>

- Update only necessary widgets
- Uses less memory than other types of state management
- Forget about StatefulWidget. With Get you don't have to think about using StatefulWidget or StateLessWidget anymore. Now all you need is a single component, GetWidget
- The organization of the project structure will be extremely clear, the logical code will be completely separated from the UI
- Update widgets without spending ram for that
- Optimize memory, you won't have to worry about Out Memory anymore, Get will automatically clean up unnecessary components
  
<b>Working principle</b>

Basically `Get` works just like `Rx`, there are also `Observables` and components to listen for `Observable` changes.

Declaring a reactive variable

````
The first is using Rx{Type}.

    var count = RxString();
    
The second is to use Rx and type it with Rx<Type>

    var count = Rx<String>();
    
The third, more practical and easier approach, is just to add an .obs to your variable.

    var count = 0.obs;
    Rx<int> count = 0.obs;

````

<b>Declare the `Observables` and handle the entire logic in view</b>

````
class Controller extends GetxController {
  var count = 0.obs;
  void increment() {
    counter.value++;
  }
}
````

<b>To listen to `Observables` in the View, you can use one of the following ways:</b>

1. GetX Component

When the value of `observable count` changes, the Widget using it will automatically be updated without affecting other widgets in the widget tree.

````
// View
GetX<Controller>(
  builder: (value) {
    print("count  rebuild");
    return Text('${controller.count.value}');
  },
)
````

2. GetBuilder 

````
// Controller
class Controller extends GetxController {
  int counter = 0;
  void increment() {
    counter++;
    update(); // use update() to update counter variable on UI when increment be called
  }
}
````

````
// View
GetBuilder<Controller>(
  init: Controller(), // INIT IT ONLY THE FIRST TIME
  builder: (controller) => Text(
    '${controller.counter}',
  ),
)
````

3. Obx

````
// Controller 
class HomeController extends GetxController {
  var count = 0.obs;
  void increment() {
    counter.value++;
  }
}
````

````
// View
Obx(() => Text(_controller.count.value.toString())
````

[More details about state management](https://github.com/jonataslaw/getx/blob/master/documentation/en_US/state_management.md)

### 2. Route management

To use all the features of Get you must use `GetMaterialApp` instead of `MaterialApp`

````
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp();
  }
}
````

<b>Navigation routes</b>

````
// Open without named
Get.to(NextScreen());

// Open with named
Get.toNamed("/NextScreen");

// Close
Get.back();
````

[More details about route management](https://github.com/jonataslaw/getx/blob/master/documentation/en_US/route_management.md)

### 3. Dependency management

#### Bindings

Where to provide dependencies (repository, usecase, ....) for that screen including controller is also provided here

````
class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}
````

Depending on the case, we have different methods of using bindings.

1. Get.put

`Get.put` covers most of the use cases for dependency management. When we inject a dependency using `Get.put`, it calls `Get.find `internally, which means, the dependency loads immediately, and can be used directly.

````
class HomePage extends StatelessWidget {
	
  Controller controller = Get.put(Controller()); // Controller dependency injected
	
  @override
  Widget build(BuildContext context) {
    return Text(controller.name); // can be used directly
  }
}
````

2. Get.lazyPut

As the name suggests, it lazy loads the dependencies, which basically means that the dependencies will be created immediately, but will be loaded to memory only when `Get.find` is called for the first time. Super useful if you have all your dependencies in the `initialBinding`, as they get loaded only when they're actually used by the widgets. As it returns void, it should preferably be declared in a Binding.

Normally, Get.lazyPut loads dependencies only one time, which means that if the route gets removed, and created again, Get.lazyPut will not load them again

````
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller()); // here!
    Get.lazyPut<Controller>(() => Controller(), tag: 'taggg!'); // or optionally with tag
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(Get.find<Controller>().name); // use Get.find and mention the type
  }
}
````

3. Get.putAsync

When using `SharedPreferences` or `databases`, we need to work with dependencies `asynchronously`. We can use `Get.putAsync` for that.

````
Get.putAsync<SharedPreferences>(() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', 'Batman');
  return prefs;
}, tag: 'tagsAreEverywhere', permanent: true); // Yes, we do get tag and permanent properties with this as well

Get.find<SharedPreferences>().getString('name'); // Get.find works as you'd expect
````

4. Get.create

This one creates a new instance of the dependency every time `Get.find` is called

We use it when we have multiple widgets on a page, that depend on the same controller, but need to update individually.

Example: A shopping cart

````
Get.create<ShoppingController>(() => ShoppingController());
````

5. GetView

It’s a stateless widget that has a controller getter, simple as that. If we have a single controller as a dependency, we can use GetView instead of `StatelessWidget` and avoid writing `Get.find`

````
class HomePage extends GetView<Controller> { // specify the type
  @override
  Widget build(BuildContext context) {
    return Text(controller.name); // GetView gives us an instance of Controller, named 'controller'
  }
}
````

6. GetWidget

It’s very similar to `GetView` with one tiny difference — it gives us the same instance of Get.find every time. This becomes surprisingly useful when used in combination with `Get.create`, as we can have multiple widgets interact with the same instance of a dependency

````
class SomeBinding implements Bindings {
  @override
  dependencies() {
    Get.create<Controller>(() => Controller());
  }
}

class SomeListTile extends GetWidget<Controller> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => Text('${controller.count.value}')), // controller is an instance of Get.find
        FlatButton(onPressed: () => controller.count.value++), // Get.find is called only once, same instance
      ]
    );
  }
}
````


[More details about dependency management](https://github.com/jonataslaw/getx/blob/master/documentation/en_US/dependency_management.md)

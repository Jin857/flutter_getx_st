# flutter_getx_st

学习 Flutter Getx 框架教程.

- [关于 flutter_getx_st ](#flutter_getx_st)
- [安装](#安装)
- [路由进阶](#路由进阶)
  - [Get.toName 与 Get.rootDelegate.toName 区别](#Get.toName与Get.rootDelegate.toName区别)
  - [Get.toName 与 Get.rootDelegate.toName 区别](#Get.toName与Get.rootDelegate.toName区别)
  - [Get.rootDelegate.toName使用](#Get.rootDelegate.toName使用)
- [依赖注入](#依赖注入)
  - [与其他依赖管理工具的比较](#与其他依赖管理工具的比较)
  - [最常用的创建实例的方法](#最常用的创建实例的方法)
  - [GetView](#GetView)
- [控制器Controller](#控制器Controller)


# 安装

1. 安装 Getx 插件 flutter pub add get.

2. Getx 中文教程 https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md

3.  import 'package:get/get.dart';

# 路由进阶

## Get.toName与Get.rootDelegate.toName区别
   1. Get.toName
    是用于导航到一个特定的路由。它是一个简化的方式，可以直接使用路由的名字来跳转到对应的页面。
    当你调用这个方法时，GetX 会在当前的导航栈中找到你要去的路由并进行跳转。

   2. Get.rootDelegate.toName
    这个方法是用于更底层的路由管理，尤其是在处理多层次或复杂的路由结构时。如果你的应用使用了嵌套的 GetX 路由，或者如果你是通过 GetX 的 GetMaterialApp 来设置路由时，Get.rootDelegate 提供了对根导航的访问。
    即 嵌套路由 / GetMaterialApp.router() 需要使用 Get.rootDelegate 进行页面跳转。
    它可以用于在全局的导航上下文中跳转，比如在当前状态不是导航器的子树时，依然能够找到根导航器来进行路由跳转。

    【总结: 使用Get.toName在普通路由下使用 Get.rootDelegate.toName 在复杂路由下使用】

## Get.rootDelegate.toName使用
   1. 使用场景
      1. GetMaterialApp.router  来设置路由。
      2. 使用 Getx 嵌套路由
        例如: 
        GetPage( 
            name: Routes.OTHER,
            page: () => const OtherPage(),
            children: [ // 嵌套路由
                GetPage(
                name: Routes.Sixth,
                page: () => const Sixth(),
                ),
            ],
        ),
        注解:
            一级路由:  "/xx" 
            二级路由: "/xx/aa" 
            三级路由: "/xx/aa/bb"
            ...

   2. 需要明确 Get.rootDelegate.xx 下跳转方式

      使用 Get.rootDelegate 路由跳转前需要了解 Get.rootDelegate 下跳转方式以及跳转逻辑

      1. Get.rootDelegate.toNamed(Routes.OTHER)
         可跳转任何界面但跟目录不会改变 即 进入的所有界面都会【有】返回按钮。
      
      2. Get.rootDelegate.offNamed(Routes.OTHER)
        查看源码：
        ```dart
            Future<T> offNamed<T>(
                String page, {
                dynamic arguments,
                Map<String, String>? parameters,
            }) async {
                history.removeLast();
                return toNamed<T>(page, arguments: arguments, parameters: parameters);
            }
        ```
        会执行 history.removeLast(); 也就是删除 history(历史) 路由饯 中最后一个路由。适用于 删除当前页面跳转下一页面使用。
       
       3. await Get.rootDelegate.offAndToNamed("${Routes.HOME}${Routes.SECEOND}");
        查看源码:
        ```dart
             Future<T?>? offAndToNamed<T>(
                String page, {
                dynamic arguments,
                int? id,
                dynamic result,
                Map<String, String>? parameters,
                PopMode popMode = PopMode.History,
            }) async {
                if (parameters != null) {
                final uri = Uri(path: page, queryParameters: parameters);
                page = uri.toString();
                }

                await popRoute(result: result);
                return toNamed(page, arguments: arguments, parameters: parameters);
            }
        ```
        会先执行 await popRoute(result: result); 在执行 Get.rootDelegate.toNamed;
        查看 popRoute(result: result)
        ```dart
            // returns the popped page
            @override
            Future<bool> popRoute({
                Object? result,
                PopMode popMode = PopMode.Page,
            }) async {
                //Returning false will cause the entire app to be popped.
                final wasPopup = await handlePopupRoutes(result: result);
                if (wasPopup) return true;
                final popped = await _pop(popMode);
                refresh();
                if (popped != null) {
                //emulate the old pop with result
                return true;
                }
                return false;
            }
        ```
        回去清空当前路由饯，然后将指定的页面加入到路由栈。

       4. Get.rootDelegate.offAndToNamed 与 Get.rootDelegate.offNamed 区别
            1. Get.rootDelegate.offAndToNamed
                功能：这个方法会先移除所有当前的路由栈中的页面，然后将指定的页面加入到路由栈。
                行为：会清空所有已存在的页面（包括当前页面），并跳转到指定的路由。它类似于“替换整个路由栈”的操作。
                用途：适用于需要清除所有历史路由并跳转到一个新页面的情况。例如，在登录后进入主页面时，你可能不希望用户能够通过返回按钮回到登录页面。
            
            2. Get.rootDelegate.offNamed
                功能：这个方法会移除当前页面，并跳转到指定的路由，但不会清空整个路由栈。
                行为：它只移除当前页面，并保留其他页面在栈中的顺序。也就是说，当前页面被移除，新的页面会被压入栈中，且可以通过“返回”操作返回到之前的页面。
                用途：适用于你只需要关闭当前页面，返回到上一个页面或跳转到一个特定页面的情况
                在使用时，选择哪种方法取决于你是否需要清空路由栈，以及跳转的方式。

# 依赖注入

## 与其他依赖管理工具的比较
    Provider：Provider 是 Flutter 官方推荐的依赖注入和状态管理工具。它需要较多的样板代码，使用起来相对复杂。
    Riverpod：Riverpod 是 Provider 的增强版，提供了更多的功能和更好的性能，但学习曲线较陡。
    GetX：GetX 简单易用，提供了更多的功能，如路由管理和状态管理，适合各种规模的项目。

## 最常用的创建实例的方法

### Get.put 不使用控制器实例也会被创建 【通常用于注册初始化用】

#### 使用场景 
全局单例：需要在整个应用程序中共享的依赖。
初始化即创建：需要在应用启动时立即创建的依赖。

#### 用法 
```dart
Get.put();
```
Get.put 是 GetX 提供的一个方法，用于将一个实例注入到依赖管理系统中。它的主要作用是创建一个新的实例，并将其注册为依赖，供整个应用程序的其他部分使用。使用Get.put 可以方便地管理和访问依赖实例，避免手动管理实例的生命周期。

#### 我们使用 Get.put 的时候，还可以配置一些选项：
dependency：要注入的依赖实例
tag：依赖实例的可选标签，用于区分相同类型的不同实例。
permanent：是否将依赖设置为永久存在，即使不再使用也不会被销毁。

#### 学习项目

##### 初始化注入控制器
```dart
    void main() {
    Initializtion.init();
    runApp(const MainApp());
    }
```

##### 使用 Get.find<xxxx>() 从 Getx 中找到对应控制器
```dart
final InitializtionController controller = Get.find<InitializtionController>();
```

##### controller 数据展示
```dart
 Obx(() => Text('Count: ${controller.count}',style: const TextStyle(fontSize: 20),),),
```

##### controller 事件处理
```dart
Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 10,
    children: [
        ElevatedButton(
            onPressed: () {controller.increment();},
            child: const Text('数字添加'),),
        ]
    ),
```

### Get.lazyPut 懒加载方式创建实例，只有在使用时才创建
懒加载一个依赖，只有在使用时才会被实例化。适用于不确定是否会被使用的依赖或者计算高昂的依赖。
个人实际开发中通常用于页面页面控制器使用。可在路由中配置。

#### 用法 
```dart
Get.lazyPut();
Get.lazyPut<LazyController>(() => LazyController());
```
通常在 GetPage 中通过 Binding 进行配置

LazyController 在这时候并不会被创建，而是等到你使用 LazyController 的时候才会被 initialized，也就是执行下面代码的时候才 initialized：
```dart
Get.find<LazyController>();
```

### Get.putAsync 是 Get.put()的异步版版本

因为 Get.putAsync 是 Get.put 异步版本，所以和 Get.put 用法相识，区别在于 注册异步实例 使用

#### 用法 
```dart
Get.putAsync<T>();
```
#### 举例
```dart
    await Get.putAsync(() => SharedPreferences.getInstance());
    await Get.putAsync(() => SimulatorInit.loadConfig());
```
这里的 SharedPreferences SimulatorInit 都是获取资源，是异步处理方法，在注入是可以使用 putAsync 进行全局注入

### Get.create 每次使用都会创建一个新的实例

适用于需要多次创建的依赖 例如 商品详情, 在商品详情页也可以进入 下一个商品详情页，如果使用 Get.lazyPut 其他几种方式注入，所注入的都是单利会导致进入的界面数据异常。所以只能使用 create 进行创建。

#### 用法 
```dart
Get.create<T>();
``` 

### Bindings依赖注入

Binding 类是一个将依赖注入进行分离，Binding 模块在路由跳转时，统一对界面通过懒注入的方式将 binding 模块的 GetXController 注入到界面中，简单说，就是把 UI 中的控制器实例化部分抽离出来了，抽离时需要实现 Bindings 类。
可以统一管理复杂模块的多个 GetXController，可以将路由、状态管理器和依赖管理器完全集成。

上面讲解  Get.lazyPut 时有使用

#### 注入方式

上面通过 GetPage() 进行 binding 注入还可以通过下面方式注入

```dart
GetPage(
    name: '/',
    page: () => HomeView(), 
    binding: HomeBinding(),
    ), // 绑定到路由中
```

直接跳转

```dart
Get.to(HomeBinding(), binding: HomeBinding());
```

## GetView

使用 GetView 代替 StatelessWidget，可以直接使用controller.变量调用，前提条件就是只能用于只有一个 controller 控制器的项目。

GetView 是一个 Stateless Widget，仅是为了方便使用 controller。如果我们只有一个 controller 作为依赖，可以使用 GetView 取代 StatelessWidget 并且不用再写Get.find。

```dart
// 视图界面实现
class SimpleView extends GetView<HomeController> { // 这里extends的是GetView 
  const SimpleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text('${controller.count}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

# 控制器Controller

Get有两个不同的状态管理器：简单的状态管理器（GetBuilder）和响应式状态管理器（GetX）。

## 简单的状态管理器（GetBuilder）

## 响应式状态管理器（GetX）

响应式编程可能会让很多人感到陌生，因为觉得它很复杂，但是GetX将响应式编程变得非常简单。

## 局部状态组件
需要清楚三部分
1. 控制器中对象定义
2. 控制器中对象如何更新
3. weight中如何展示
展示时如何只更新局部Weight （很关键 因为这个是关键）

搞清楚这个问题就是搞清楚 obs
什么是 obs
obs 对象如何定义
obs 数据如何更新
obs 数据如何使用

# 关于flutter隔离(isolate)
## 什么是isolate
隔离(isolate)是dart语言用来开启新线程的方式。
## 隔离(isolate)与异步(async awit)之间的区别
我门常用的异步,我门通常是用异步来处理请求逻辑，因为请求逻辑比较简单，不会有庞大的算法或者数据处理逻辑，所以UI不会有卡顿。但是当我们做一些计算量比较大的算法时异步处理会导致页面出现卡顿，是因为flutter项目时单线程项目，这里的异步只是均匀的分配时间给cpu进行处理，并不是真的开新线程去处理，我门可以将flutter项目开成一个主线程(主隔离)。这样就很好理解，使用isolate会开启一个新的线程，这里新线程的算法不会影响到主线程的运算，就不会出现页面UI卡顿等现象。
## 因为多个isolate之间相互调用
因为isolate之间互不干扰，所以isolate之间的变动是不共用的，所以需要有个服务去关联isolate之间的运行。
用法教程: isolate_main.dart












 





            




        

    

    





[TOC]

# swift 4.0

## 1.命名空间

> * 在同一个项目中,所有的类都是共享的,可以直接访问,不用import
>
> * 不同的项目中有相同的类,是可以共存的

## 2.构造函数

> * 是一种特俗的函数
>
> * 主要用来在创建对象时,初始化对象
>
> * 给对象的成员变量设置初始值
>
> * Swift支持函数重载,所有构造函数都是init
>
> * 作用: 分配空间,设置初始值

__重载:方法名字相同,参数不同__

____

## **注意**

>* Object-c的初始化,是从类继承关系链,从父类开始逐级向子类初始化
>
>* Swift的初始化,是先从子类开始,逐级向父类初始化
>
>* 非optonal属性,都必须在构造函数中设置初始值,从而保证对象再被实例化的时候,属性都被正确地初始化
>
>* 在调用父类构造函数之前,必须保证本类的属性已经完成初始化
>
>* Swift中的构造函数不用写func关键字

**1.构造函数的目的是: 给自己的属性分配空间并且设置初始值 
2.调用父类构造函数之前,需要先给本类的属性设置初始值 
3.调用父类的构造函数,给父类的属性分配空间并设置初始值 
4.如果重载了构造函数,并且没有实现父类的init方法,系统不再提供init函数(默认会提供的), **

___

## 3.重载与重写

**重载: overload**

> * 函数名字相同
>
> * 参数类型和个数不同
>
> * 如果重载了构造函数,并没有实现父类的init方法,系统不再提供init()构造函数
>
> * 默认的init()构造函数,不能给本类的属性分配空间

**重写: override**

>* 父类中已存在此方法
>
>* 子类重新实现父类的方法

```swift
class ZYImage: NSObject {

    var name:String

    //重写
    override init() {
        name = "zhouyu"
        super.init()
    }

    //重载
    init(name: String) {
        self.name = name
        super.init()
    }
}

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = ZYImage()
        print(image.name)

        let image2 = ZYImage(name: "wangwu")
        print(image2.name)
    }
```

___

## 4. KVC构造函数

**要搞清一个问题**

>* iOS开发中,很多类的属性都是需要用到的时候才创建的,所以是可选的
>
>* 定义模型属性时,如果是对象,通常是可选的: 需要的时候才创建,延迟加载,避免写构造函数. 例如: var name: String?

**注意**

> * KVC 是 OC 特有的，KVC 本质上是在运行时，动态向对象发送 setValue:ForKey: 方法，为对象的属性设置数值. 因此，在使用 KVC 方法之前，需要确保对象已经被正确实例化. 
> * 必选属性必须在调用父类构造函数之前完成初始化分配工作

**基本数据类型在Swift ，与KVC不兼容 **

>如果基本数据类型为nil，KVC在调用 setValue(value: AnyObject?, forKey key: String) 找不到这个属性, 使用KVC时给基本数据类型设置初始值

```swift
import UIKit

@objcMembers class Person: NSObject {
    /// 姓名
    var name: String?
    /// 年龄
    var age: Int = 0

    /// `重写`构造函数
    ///
    /// - parameter dict: 字典
    /// - returns: Person 对象
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forKey key: String) {
        print("\(key) \(String(describing: value))")
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("\(key) \(String(describing: value))")
    }
}
```

```swift
let person = Person(dict: ["name": "zhouyu" ,"age": 28])
```

**注意点**

> * 如果父类中已经实现了父类的相关方法，子类中不用再实现相关方法

```swift
/// 学生类
class Student: Person {

    /// 学号
    var no: String?
}
```

**注意@objcMembers**

> * @objcMembers 在Swift 4中继承 NSObject 的 swift class 不再默认全部 bridge 到 OC，如果我们想要使用的话我们就需要在class前面加上@objcMembers 这么一个关键字。
> * 引用: 在 swift 3 中除了手动添加 @objc 声明函数支持 OC 调用还有另外一种方式：继承 NSObject。
> * class 继承了 NSObject 后，编译器就会默认给这个类中的所有函数都标记为 @objc ，支持 OC 调用。
> * 苹果在Swift 4 中苹果修改了自动添加 @objc 的逻辑： 一个继承 NSObject 的 swift 类不再默认给所有函数添加 @objc。
> * 只在实现 OC 接口和重写 OC 方法时才自动给函数添加 @objc 标识。

----

## 5.Swift4.0运行时获取类的属性列表

```swift
import UIKit
//@objcMembers Swift 4.0后,必须写,运行时才能获取属性
@objcMembers class Person: NSObject {
    /// 姓名
    var name: String?
    /// 年龄
    var age: Int = 0
    /// 性别
    var sex: String?

    class func getClassPropertyList() -> [String] {
        var propertyList:[String] = []
        var count: UInt32 = 0

        //UnsafeMutablePointer<objc_property_t>?  数组
        let list = class_copyPropertyList(self, &count)

        for i in 0..<Int(count) {
            //objc_property_t
            guard let property = list?[i] else { continue }
            //UnsafePointer<Int8>   Int8-->Byte-->Char-->C语言的字符串
            let propertyCharName = property_getName(property)
            //C语言的字符串转Swift的String
            guard let propertyName = String(utf8String: propertyCharName)  else { continue }
            propertyList.append(propertyName)
        }

        free(list)
        return propertyList
    }
}
```

```swift
print(Person.getClassPropertyList())
//结果
["name", "age", "sex"]
```

**注意**

>* 1.基本数据类型,在OC中没有可选值这一说,如果定义成可选项,KVC获取不到,会崩溃 
>* 2.private修饰的属性,运行时同样获取不到此属性,也会是KVC崩溃 
>* 3.在Swift 4中继承 NSObject 的 swift class 不再默认全部 bridge 到 OC，如果想使用运行时获取类的细节,需要在class前面加上@objcMembers关键字。
---------------------
## 6.便利构造函数

**目的**

>* 条件判断，只有满足条件，才实例化对象，可以防治造成不必要的内存开销简化对象的创建本身不负责属性的创建和初始化工作
>
>* 简化对象的创建
>* 本身不负责属性的创建和初始化工作

**特点**

- 默认情况下，所有的构造方法都是指定构造函数 `Designated`
- `convenience` 关键字修饰的构造方法就是便利构造函数

>- convenience关键字修饰init(), 可以返回nil
>- 只有便利构造函数中可以调用self.init()
>- 便利构造函数不能被重写和super
>- 用于条件检测和简化对象创建
>- 常用与UIKit中,使用类工厂方法快速创建类似的控件

```swift
 convenience init?(name: String, age: Int, sex: String) {
        //书写判断条件
        if age <= 0 {
            return nil
        }

        //MARK: 调用self.init
        self.init()

        //给属性赋值
        self.name = name
        self.age = age
        self.sex = sex
    }
```

**应用场景**

> - 根据给定参数判断是否创建对象，而不像指定构造函数那样必须要实例化一个对象出来
> - 在实际开发中，可以对已有类的构造函数进行扩展，利用便利构造函数，简化对象的创建

**注意点**

> - 指定构造函数必须调用其直接父类的的指定构造函数（除非没有父类）
>
> - 便利构造函数必须调用同一类中定义的其他`指定构造函数`或者用 `self.` 的方式调用`父类的便利构造函数`
>
> - 便利构造函数可以返回 `nil`
>
> - 便利构造函数不能被重载

---

## 7.闭包

**定义一个函数**

```swift
//: 定义一个 sum 函数
func sum(num1 num1: Int, num2: Int) -> Int {
    return num1 + num2
}
sum(num1: 10, num2: 30)

//: 在 Swift 中函数本身就可以当作参数被定义和传递
let mySum = sum
let result = mySum(num1: 20, num2: 30)
```

**定义一个闭包**

>闭包 = { (行参) -> 返回值 in // 代码实现 }
>
>`in` 用于区分函数定义和代码实现

```swift
//: 闭包 = { (行参) -> 返回值 in // 代码实现 }
let sumFunc = { (num1 x: Int, num2 y: Int) -> Int in
    return x + y
}
sumFunc(num1: 10, num2: 20)
```

**闭包格式小结**

```swift
// 格式： let 闭包名: (形参) -> 返回类型 = { (形参1, 形参2, ...) in 代码实现 }
// 说明： 使用形参列表，可以直接提供外部参数
//
// 格式： let 闭包名: (形参类型) -> 返回类型 = { (形参1, 形参2, ...) in 代码实现 }
//
// 格式： { (外部参数1 形参1, 外部参数2 形参2, ...) -> 返回类型 in 代码实现 }
// 说明： 使用外部参数会方便调用
//
// 格式： { (形参列表) -> 返回类型 in 代码实现 }
```

****

**最简单的闭包，如果没有参数/返回值，则 `参数/返回值/in` 统统都可以省略**

```swift
let demoFunc = {
    print("hello")
}
```

**闭包基本使用**

* 模拟在后台线程加载数据

```swift
func loadData() {
    dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
        print("耗时操作 \(NSThread .currentThread())")
    })
}
```

* 尾随闭包，如果闭包是最后一个参数，可以用以下写法
* 注意上下两段代码，`}` 的位置

```swift
func loadData() {
    dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
        print("耗时操作 \(NSThread .currentThread())")
    }
}
```

* 闭包的简写，如果闭包中没有参数和返回值，可以省略

```swift
func loadData() {
    dispatch_async(dispatch_get_global_queue(0, 0)) {
        print("耗时操作 \(NSThread .currentThread())")
    }
}
```

**自定义闭包参数，实现主线程回调**

- 添加没有参数，没有返回值的闭包

 ```swift
override func viewDidLoad() {
    super.viewDidLoad()

    loadData {
        print("完成回调")
    }
}

// MARK: - 自定义闭包参数
func loadData(finished: ()->()) {

    dispatch_async(dispatch_get_global_queue(0, 0)) {
        print("耗时操作 \(NSThread.currentThread())")

        dispatch_sync(dispatch_get_main_queue()) {
            print("主线程回调 \(NSThread.currentThread())")

            // 执行回调
            finished()
        }
    }
}
 ```

- 添加回调参数

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    loadData4 { (html) -> () in
        print(html)
    }
}

/// 加载数据
/// 完成回调 - 传入回调闭包，接收异步执行的结果
func loadData4(finished: (html: String) -> ()) {

    dispatch_async(dispatch_get_global_queue(0, 0)) {
        print("加载数据 \(NSThread.currentThread())")

        dispatch_sync(dispatch_get_main_queue()) {
            print("完成回调 \(NSThread.currentThread())")

            finished(html: "<h1>hello world</h1>")
        }
    }
}
```

**循环引用**

```swift
class NetworkTools: NSObject {

    /// 加载数据
    ///
    /// - parameter finished: 完成回调
    func loadData(finished: () -> ()) {
        print("开始加载数据...")

        // ...
        finished()
    }

    deinit {
        print("网络工具 88")
    }
}
```

```swift
class ViewController: UIViewController {

    var tools: NetworkTools?

    override func viewDidLoad() {
        super.viewDidLoad()

        tools = NetworkTools()
        tools?.loadData() {
            print("come here \(self.view)")
        }
    }

    /// 与 OC 中的 dealloc 类似，注意此函数没有()
    deinit {
        print("控制器 88")
    }
}
```

> 运行不会形成循环引用，因为 loadData 执行完毕后，就会释放对 self 的引用



**修改 `NetworkTools`，定义回调闭包属性**

```swift
/// 完成回调属性
var finishedCallBack: (()->())?

/// 加载数据
///
/// - parameter finished: 完成回调
func loadData(finished: () -> ()) {

    self.finishedCallBack = finished

    print("开始加载数据...")

    // ...
    working()
}

func working() {
    finishedCallBack?()
}

deinit {
    print("网络工具 88")
}
```

> 运行测试，会出现循环引用

**解除循环引用**

* **与 OC 类似的方法**

```swift
/// 类似于 OC 的解除引用
func demo() {
    weak var weakSelf = self
    tools?.loadData() {
        print("\(weakSelf?.view)")
    }
}
```

* **Swift 推荐的方法**

```swift
loadData { [weak self] in
    print("\(self?.view)")
}
```

* **还可以**

```swift
loadData { [unowned self] in
    print("\(self.view)")
}
```

**闭包(Block) 的循环引用小结**

- Swift

  - ```
    [weak self]
    ```

    - `self`是可选项，如果self已经被释放，则为`nil`

  - ```
    [unowned self]
    ```

    - `self`不是可选项，如果self已经被释放，则出现`野指针访问`

- Objc

  - ```
    __weak typeof(self) weakSelf;
    ```

    - 如果`self`已经被释放，则为`nil`

  - ```
    __unsafe_unretained typeof(self) weakSelf;
    ```

    - 如果`self`已经被释放，则出现野指针访问





@escaping-逃逸闭包**

*逃逸闭包和非逃逸闭包的区别*

> 非逃逸闭包的生命周期与函数相同：
>
> * 把闭包作为参数传给函数
> * 函数中调用闭包
> * 退出函数。结束



> 逃逸闭包的生命周期：
>
> * 闭包作为参数传递给函数；
> * 退出函数;
> * 闭包被调用，闭包生命周期结束

*即逃逸闭包的生命周期长于函数，函数退出的时候，逃逸闭包的引用仍被其他对象持有，不会在函数结束时释放*

**场景**

> One way that a closure can escape is by being stored in a variable that is defined outside the function.
>
> 闭包逃逸的:一种方法是存储在函数外部定义的变量中

```swift
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

**注意**

> 逃逸闭包中,访问自身的属性用self.

```swift
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "100"
```





**@autoclosure**

```swift
//1 一般情况
func or(first:Bool,second:()->Bool) -> Bool {
    if first {
        return true
    }
    else {
        return second()
    }
}

//1 函数调用
or(2>3) { () -> Bool in
    return 4 > 3
}//等价于(2>3)|| (4>3),返回结果为true

//--------------------------------------------------

//2使用autoclosure
func or(first:Bool,second: @autoclosure ()->Bool) -> Bool {
    if first {
        return true
    }
    else {
        return second()
    }
}

//2 函数调用
or(2>3,second: 4>3)

```

*这看起来既干净又方便理解，一看就知道2>3与4>3进行或运算。*

> * @autoclosure：Apple为了让语法看起来更漂亮些，在Swift中为我们提供了这么一个神奇的东西@autoclosure，他可以让我们的表达式自动封装成一个闭包。



**@autoclosure 和@escaping 放在类型前面修饰**

```swift
 func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) { 
    customerProviders.append(customerProvider) 
 }
```





---

## 8.懒加载

> 在 iOS 开发中，懒加载是无处不在的

**懒加载的简单写法**

```swift
lazy var demoPerson: Person = Person()
```

**懒加载的本质是一个闭包**

> 以上代码可以改写为以下格式

```swift
let personFunc = { () -> Person in
    print("懒加载")
    return Person()
}
lazy var demoPerson: Person = self.personFunc()
```

**慢慢简化**

```swift
lazy var demoPerson: Person = { () -> Person in
    print("懒加载")
    return Person()
}()
```

----

**注意swift4中懒加载不一样了**

```swift
lazy var man: Person? = nil
class ViewController: UIViewController {
    
    lazy var man: Person? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        man = Person(dict: ["name":"zhangsan","age":30])
    }
```

## 9.枚举

> 在枚举名字后面写 : CaseIterable 来允许枚举被遍历,所有情况的集合名为 allCases。

```swift
enum Beverage:CaseIterable{
	case coffee,tea,juice
}
```

> 遍历枚举

```swift
for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice
```

**关联值**

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

**这次可以将关联值提取为switch语句的一部分。您将每个关联值提取为常量（带`let`前缀）或变量（带`var`前缀），以便在`switch`案例正文中使用：**

```swift
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
```

**预先填充默认值**

```swift
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```

**隐含分配**

```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPoint: String {
    case north, south, east, west
}

let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"

```

**接收一个初始值设定项**

```swift
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.uranus

```

***然而，并非所有可能的`Int`值都会找到匹配的行星。因此，原始值初始值设定项始终返回*可选的*枚举大小写。在上面的示例中，`possiblePlanet`是类型`Planet?`或“可选” `Planet`。***

```swift
let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
```





**递推枚举**

```swift
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

```

**递归函数是处理具有递归结构的数据的简单方法。例如，这是一个计算算术表达式的函数：**

```swift
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
// Prints "18"
```

## 10.结构体和类

**结构体和类有许多共同点**

>- 定义存储值的属性
>- 定义提供功能的方法
>- 定义下标以使用下标语法提供对其值的访问
>- 定义初始化程序以设置其初始状态
>- 扩展以扩展其功能，超越默认实现
>- 符合协议以提供某种标准功能

**类具有结构不具备的其他功能**

> - 继承使一个类能够继承另一个类的特性。
> - 类型转换使您可以在运行时检查和解释类实例的类型。
> - Deinitializers允许类的实例释放它已分配的任何资源。
> - 引用计数允许对类实例的多个引用。

**定义语法**

```swift
//结构和类具有类似的定义语法
struct SomeStructure {
    // structure definition goes here
}
class SomeClass {
    // class definition goes here
}
```

**注意:**

> 无论何时定义新结构或类，都要定义新的Swift类型。给出类型`UpperCamelCase`名称（如`SomeStructure`和`SomeClass`这里）来匹配标准swift类型的资本（如`String`，`Int`和`Bool`）。提供属性和方法`lowerCamelCase`名称（例如`frameRate`和`incrementCount`）以区别于类型名称。

**结构体定义和类定义的示例：**

```swift
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

**结构体和类实例**

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()

//您可以使用点语法访问实例的属性。在点语法中，您在实例名称后面立即写入属性名称，用句点（.）分隔，不带任何空格：
print("The width of someResolution is \(someResolution.width)")
// Prints "The width of someResolution is 0"

//您可以深入查看子属性，例如width属性中的resolution属性VideoMode：
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"

//您还可以使用点语法为变量属性分配新值：
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is now 1280"

```

**结构体类型的成员初始化器**

```swift
let vga = Resolution(width: 640, height: 480)
```

> 注意:    与结构不同，类实例不接收默认的成员初始值设定项。

**结构和枚举是值类型**

> 所有结构和枚举都是Swift中的值类型。这意味着您创建的任何结构和枚举实例以及它们作为属性的任何值类型在代码中传递时始终会被复制。

**理解**

> 标准库（如数组，字典和字符串）定义的集合使用优化来降低复制的性能成本。这些集合不是立即复制，而是共享内存，其中元素存储在原始实例和任何副本之间。如果修改了集合的其中一个副本，则在修改之前复制元素。您在代码中看到的行为总是好像立即发生了复制。

```swift
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
//检查width属性cinema显示它确实已更改为2048：
print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide"

//但是，width原始hd实例的属性仍具有旧值1920：
print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide"

```

**tips**

>当`cinema`给出当前值时`hd`，存储的*值*`hd`被复制到新`cinema`实例中。最终结果是两个完全独立的实例，它们包含相同的数值。但是，因为它们是单独的实例，所以设置宽度`cinema`to `2048`不会影响存储的宽度`hd`，如下图所示：

![sharedStateStruct_2x](/Users/yuanwang/Desktop/汪俊swift4.2笔记/sharedStateStruct_2x.png)

**相同的行为适用于枚举：**

```swift
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"
```

> 当`rememberedDirection`赋值为`currentDirection`，它实际上设置为该值的副本。更改`currentDirection`此后的值不会影响存储的原始值的副本`rememberedDirection`。

**类是引用类型**

> 与值类型不同，*引用类型*在分配给变量或常量时或者传递给函数时*不会被*复制。而不是副本，使用对同一现有实例的引用。

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
```

***由于类是引用类型，`tenEighty`而`alsoTenEighty`实际上都指向*同一个* `VideoMode`实例。实际上，它们只是同一个实例的两个不同名称，如下图所示：***

![sharedStateClass_2x](/Users/yuanwang/Desktop/汪俊swift4.2笔记/sharedStateClass_2x.png)

```swift
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"
```

**Identity Operators**

>因为类是引用类型，所以多个常量和变量可以在后台引用同一个类的单个实例。（对于结构和枚举，情况也是如此，因为它们在分配给常量或变量或传递给函数时总是被复制。）

有时可以找出两个常量或变量是否完全引用类的相同实例。为了实现这一点，Swift提供了两个身份运算符：

> * 与（`===`）相同
>
> - 与（`!==`）不一样

```swift
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."
```

> == 和===不一样

**指针**

> 如果您有使用C，C ++或Objective-C的经验，您可能知道这些语言使用*指针*来引用内存中的地址。引用某个引用类型的实例的Swift常量或变量类似于C中的指针，但它不是指向内存中地址的直接指针，并且不需要您编写星号（`*`）来指示你正在创建一个参考。相反，这些引用的定义与Swift中的任何其他常量或变量一样。标准库提供指针和缓冲区类型，如果需要直接与指针交互，可以使用它们 - 请参阅[手动内存管理](https://developer.apple.com/documentation/swift/swift_standard_library/manual_memory_management)。

## 11.属性

**存储型属性**

`变量结构体实例`

```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
```

`常量结构体实例`

> 如果创建结构的实例并将该实例分配给常量，则无法修改实例的属性，即使它们被声明为变量属性：

```swift
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3
rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property
```

`lazy 存储型属性`

**注意**

> 您必须始终将惰性属性声明为变量（使用`var`关键字），因为在实例初始化完成之后，可能无法检索其初始值。常量属性*在*初始化完成*之前*必须始终具有值，因此不能声明为惰性。

```swift
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property has not yet been created
```

**注意**

>如果`lazy`同时由多个线程访问标记有修饰符的属性且该属性尚未初始化，则无法保证该属性仅初始化一次。

**计算属性**

> 除了存储的属性之外，类，结构和枚举还可以定义*计算属性*，这些*属性*实际上不存储值。相反，它们提供了一个getter和一个可选的setter来间接检索和设置其他属性和值。

```swift
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"
```

**如果计算属性的setter没有为要设置的新值定义名称，`newValue`则使用默认名称。**

```swift
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
```

**只读计算属性**

> 具有getter但没有setter的*计算属性*称为*只读计算属性*。只读计算属性始终返回一个值，可以通过点语法访问，但不能设置为其他值。

**注意**

> 您必须将计算属性（包括只读计算属性）声明为带有`var`关键字的变量属性，因为它们的值不固定。该`let`关键字仅用于常量属性，以指示一旦将它们设置为实例初始化的一部分，就无法更改它们的值。

```swift
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"
```

**Property Observers**

> * 每次设置属性值时都会调用属性观察者，即使新值与属性的当前值相同。
>
> * 可以将属性观察器添加到您定义的任何存储属性，但惰性存储属性除外。
>
> * 可以通过覆盖子类中的属性，将属性观察器添加到任何继承的属性（无论是存储还是计算）。
> * 不需要为非重写的计算属性定义属性观察器，因为您可以在计算属性的setter中观察并响应其值的更改。

**您可以选择在属性上定义其中一个或两个观察者：**

>`willSet` 在存储值之前调用。
>
>`didSet` 在存储新值后立即调用。

**willSet**

> 如果实现了一个`willSet`观察者，它会将新属性值作为常量参数传递。您可以在实现过程中指定此参数的名称`willSet`。如果未在实现中编写参数名称和括号，则该参数的默认参数名称为`newValue`。

**didSet**

> 如果您实现了一个`didSet`观察者，它会传递一个包含旧属性值的常量参数。您可以为参数命名或使用默认参数名称`oldValue`。如果为其自己的`didSet`观察者中的属性分配值，则分配的新值将替换刚刚设置的值。

**`willSet`与`didSet`注意**

> The `willSet` and `didSet` observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They are not called while a class is setting its own properties, before the superclass initializer has been called.
>
> 超类属性的“willSet”和“didSet”观察者在子类初始化器中设置属性时被调用，在超类初始化器被调用之后。在调用超类初始化器之前，在类设置其自身属性时不会调用它们。

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
```

**全局和局部变量**

> 计算和观察属性的功能也可用于*全局变量*和*局部变量*。

全局变量:在任何函数，方法，闭包或类型上下文之外定义的变量。

局部变量:在函数，方法或闭包上下文中定义的变量。

> 您还可以在全局或本地范围内定义`计算变量`并为`存储变量`定义观察者。计算变量计算它们的值，而不是存储它们，它们的编写方式与计算属性相同。

## 太有用了,注意!

> 存储类型属性在首次访问时会被初始化。它们保证只初始化一次，即使在同时由多个线程访问时也是如此，并且它们不需要用`lazy`修饰符标记。 (言外之意懒加载是多余的,因为var p:Person    p = Person()这样就可以保证p被首次访问的时候就只初始化一次)

```swift
//存储类型属性在首次访问时会被初始化。它们保证只初始化一次
var p:Person = nil
////存储类型属性在首次访问时会被初始化。它们保证只初始化一次
var p:Person = Person()
```

**类的全部静态变量**

```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
```

> 上面的计算类型属性示例用于只读计算类型属性，但您也可以使用与计算实例属性相同的语法定义读写计算类型属性。

**Demo**

```swift
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
```

## 12.实例方法

```swift
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
```

**self属性**

```swift
类型的每个实例都有一个名为的隐式属性self，它与实例本身完全等效。您可以使用该self属性在其自己的实例方法中引用当前实例。
```

**`self`消除了调用的方法参数`x`和也被称为的实例属性之间的歧义`x`：**

```swift
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// Prints "This point is to the right of the line where x == 1.0"
```

**从实例方法中修改值类型**

> 结构和枚举是*值类型*。默认情况下，无法在其实例方法中修改值类型的属性。
>
> 您可以通过将`mutating`关键字放在该方法的关键字之前来选择此行为`func`：

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"
```

> 您不能在结构类型的常量(let)上调用变异方法，因为它的属性不能更改，即使它们是变量属性

```swift
let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
// this will report an error
```

**Mutating Method**

> Mutating Method可以为隐式`self`属性分配一个全新的实例。`Point`上面显示的示例可能是以下列方式编写的：

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}
```

> 枚举的Mutating Method可以将隐式`self`参数设置为与同一枚举不同的大小写：

```swift
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off
```

**class method——类方法**

> 通过`static`在方法的`func`关键字之前写入关键字来指示类型方法
>
> 类也可以使用`class`关键字来允许子类覆盖超类的该方法的实现

```swift
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()
```

**Demo**

```swift
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// Prints "level 6 has not yet been unlocked"

```

## 13.Subscripts

> 类，结构和枚举可以定义*下标*，*下标*是用于访问集合，列表或序列的成员元素的快捷方式。您可以使用下标按索引设置和检索值，而无需单独的设置和检索方法。例如，您可以访问在元素`Array`实例作为`someArray[index]`和元素的`Dictionary`实例作为`someDictionary[key]`。
>
> 您可以为单个类型定义多个下标，并根据传递给下标的索引值的类型选择要使用的相应下标重载。下标不限于单个维度，您可以定义具有多个输入参数的下标，以满足您的自定义类型的需求。

**语法**

```swift
subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
    }
    set(newValue) {
        // perform a suitable setting action here
    }
}

subscript(index: Int) -> Int {
    // return an appropriate subscript value here
    //在这儿返回一个适当的下表值
}
```

**Demo**

```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"
```

**Subscript Options**

```swift
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
    matrix[0, 1] = 1.5
    matrix[1, 0] = 3.2
```

## 14.Base Class

> OC类似

## 15.初始化

**构造函数和遍历构造函数**

> **规则1**
>
> A designated initializer must call a designated initializer from its immediate superclass.
>
> **规则2**
>
> A convenience initializer must call another initializer from the *same* class.
>
> **规则3**
>
> A convenience initializer must ultimately call a designated initializer.

***记住这个的一个简单方法是：***

- Designated initializers must always delegate *up*.

- Convenience initializers must always delegate *across*.

  这些规则如下图所示：

  ![initializerDelegation01_2x](/Users/yuanwang/Desktop/%E6%B1%AA%E4%BF%8Aswift4.2%E7%AC%94%E8%AE%B0/initializerDelegation01_2x.png)

   遍历构造器同一类中穿越至指定构造器,指定构造器向上.

`构造函数`

```swift
init(parameters) {
    statements
}
```

`遍历构造函数`

```swift
convenience init(parameters) {
    statements
}
```

**Demo1**

```swift
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
// namedMeat's name is "Bacon"

let mysteryMeat = Food()
// mysteryMeat's name is "[Unnamed]"

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

```

**Demo2**

```swift
import UIKit  
  
extension UIButton{  
      
    //swit中类方法是以class开头的方法，类似于oc中+开头的方法  
    class func createButton(imageName:String,bgImageName:String)->UIButton{  
          
        let btn=UIButton()  
        btn.setImage(UIImage(named:imageName), for: .normal)  
        btn.sizeToFit()  
      
        return btn  
    }  
      
    /*  
     convenience:便利，使用convenience修饰的构造函数叫做便利构造函数  
     便利构造函数通常用在对系统的类进行构造函数的扩充时使用。  
     便利构造函数的特点：  
     1、便利构造函数通常都是写在extension里面  
     2、便利函数init前面需要加载convenience   
     3、在便利构造函数中需要明确的调用self.init()  
      
     */  
      
    convenience init(imageName:String,bgImageName:String){  
          
        self.init()  
          
        setImage(UIImage(named:imageName), for: .normal)  
        setBackgroundImage(UIImage(named:bgImageName), for: .normal)  
        sizeToFit()  
    }  
} 
```

**Demo3**

```
class InitViewController: UIViewController {

    convenience init(_ name: String) {
        //这里也是要明确调用self.init()
        self.init()
        
        self.username = name;
    }
    
    //定义一个存储属性，属性声明最好加一个感叹号，这是因为：如果重写了init方法，不加感叹号的属性都要在init方法中赋值，否则编译报错，加个感叹号就可以在init方法中不初始化该属性。
    var username : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.purple
        
        if let username = self.username {
            print(username)
        }
    }
}
```
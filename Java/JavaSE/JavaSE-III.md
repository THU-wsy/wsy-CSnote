# 第13章_泛型(Generic)

## 1. 泛型概述

泛型即为`类型参数`，即，在定义类、接口、方法时，同时声明了一个或者多个类型变量（如：`<E>`），称为泛型类、泛型接口、泛型方法，它们统称为泛型。

**泛型的作用：泛型提供了在编译阶段约束所能操作的数据类型，并自动进行检查的能力！这样可以避免强制类型转换，及其可能出现的异常**。

**泛型的本质：把具体的数据类型作为参数传给类型变量**。

**注意**：泛型的类型变量，只能使用引用数据类型进行赋值。（不能使用基本数据类型，可以使用包装类替换）

**泛型擦除**：事实上，泛型是工作在编译阶段的，一旦程序编译成class文件，class文件中就不存在泛型了，这就是泛型擦除。

## 2. 自定义泛型结构

### 2.1 自定义泛型类

自定义泛型类的格式如下

```java
// 这里的<E, T>其实指的就是类型变量，可以是一个，也可以是多个。
// 类型变量建议用大写的英文字母，常用的有：E、T、K、V 等
修饰符 class 类名<E, T>{
    
}
```

```java
public class MyArrayList<E> {
    private Object[] arr = new Object[100];
    private int size = 0;
    public boolean add(E e) {
        arr[size++] = e;
        return true;
    }
    public E get(int index) {
        return (E) arr[index];
    }
}
public class Test {
    public static void main(String[] args) {
        MyArrayList<String> arr = new MyArrayList<>();
        arr.add("java1");
        arr.add("java2");
        System.out.println(arr.get(1)); // java2
    }
}
```

除此之外，类型变量也可以做一定的限定：

```java
public class MyClass<E extends Animal> {
}
public class Test {
    public static void main(String[] args) {
        // 报错，必须是Animal类型或者其子类
        // MyClass<String> a = new MyClass<>(); 
        
        MyClass<Animal> b = new MyClass<>();
        MyClass<Cat> c = new MyClass<>();
    }
}
```

当我们在类或接口中定义某个成员时，该成员的相关类型是不确定的，而这个类型需要在使用这个类或接口时才可以确定，那么我们可以使用泛型类、泛型接口。

**说明**

- 如果在创建自定义泛型类的对象时，没有指明泛型参数类型，那么泛型将被擦除，泛型对应的类型均按照Object处理，但不等价于Object。
- 除创建泛型类对象外，子类继承泛型类时、实现类实现泛型接口时，也可以确定泛型结构中的泛型参数。
- 如果我们设计子类继承某个泛型类时，子类也不确定泛型的类型，则子类也需要继续使用泛型参数。例如`class Son<E> extends Dad<E> {}`
- 除此之外，我们还可以在现有的父类的泛型参数的基础上，新增泛型参数。例如`class Son<E, T> extends Dad<E> {}`

**注意**

- 对于数组的声明，无法直接使用泛型参数，即 `E[] arr = new E[10];` 是错误的，因为数组不是泛型类。我们需要使用以下语句声明数组 `E[] arr = (E[]) new Object[10];`
- 在本类/本接口的静态方法中，无法使用类/接口上声明的泛型参数。
- 异常类不能是泛型类。


### 2.2 自定义泛型接口

定义格式如下：

```java
修饰符 interface 接口名<E>{
    
}
```

例如
```java
// 泛型接口
public interface Data<T> {

}
// 实现类
public class StringData implements Data<String> {

}
```

泛型接口的具体细节与泛型类几乎类似。

### 2.3 自定义泛型方法

泛型方法的格式

```java
修饰符 <E> 返回值类型 方法名(形参列表) {
    
}
```

```java
public class Test{
    public static void main(String[] args){
        ArrayList<Animal> ans = new ArrayList<>();
        go(ans);
    }
    
    //这是一个泛型方法<T>表示一个不确定的数据类型，由调用者确定
    public static <T> void go(ArrayList<T> t){
    
    }
}
```

某个方法形参类型或者返回值类型不确定时，这个方法可以单独定义泛型参数，成为一个泛型方法。

**说明**

- 泛型方法，与其所在的类是否是泛型类没有关系。换而言之，如果一个方法只使用了其泛型类上定义的泛型参数，就并不是一个泛型方法。简而言之，只有在方法修饰符后定义了泛型参数`<E>`才是一个泛型方法。
- 泛型方法中的泛型参数的具体类型是在方法被调用时确定的。
- 泛型方法可以声明为static


**泛型的应用场景**

```java
// DAO:database access object，内部封装了操作数据库相关表的增删改查操作
class DAO<T> {
    public void insert(T bean) {
        // 通过相应的sql语句，将bean对象的属性值写入到数据表中
    }
    public void deleteById(int id) {}
    public void update(int id, T bean) {}
    public T queryForInstance(int id) { return null; }
    public List<T> queryForList(int id) { return null; }
}
/*
* ORM思想(object relational mapping)
* 数据库中的一个表 与 Java中的一个类对应
* 表中的一条记录 与 Java类的一个对象对应
* 表中的一个字段(或列) 与 Java类的一个属性(或字段)对应
*/
class Table {
    int id;
    String name;
    String info;
}
class TableDAO extends DAO<Table> {
    // 利用泛型，使得只能操作某张固定的表
}
```


## 3. 泛型在继承上的体现

**类`SuperA`是类`A`的父类或接口，则 `G<SuperA>` 与 `G<A>` 是并列的两个类，没有任何子父类的关系**。比如 `ArrayList<Object>` 与 `ArrayList<String>`没有子父类关系，所以下面的语句显然是错误的：

```java
ArrayList<Object> list1 = new ArrayList<>();
ArrayList<String> list2 = new ArrayList<>();
list1 = list2; // 报错
```

**类`SuperA`是类`A`的父类或接口，则`A<G>`是`SuperA<G>`的子类(或实现类)**，即`A<G>`的实例可以赋值给`SuperA<G>`类型的变量。比如，`ArrayList<String>`就是`List<String>`的子类，所以下面的赋值是正确的：

```java
List<String> list1 = null;
ArrayList<String> list2 = new ArrayList<>();
list1 = list2; 
```

## 4. 通配符的使用

根据上述讨论，我们发现在方法传递参数时，参数类型如果限制为`List<Object>`，也无法传入`List<String>`类型的实参，即使是`ArrayList<String>`也无法传入，因为泛型参数已经限定为`Object`，我们只能传入`A<Object>`类型的参数，其中`A`是`List`或其实现类。

为了让我们**使用泛型**时更具有通用性，我们可以使用类型通配符`?`，它表示一切泛型参数。

### 4.1 通配符

例如：`List<?>`就可以看作是各种List泛型的父类，如`List<String>`、`List<Object>`、`ArrayList<Object>`等等。所以将`List<String>`类型的对象赋值给`List<?>`是完全可以的。

```java
public class MyTest {
    public static void main(String[] args) {
        List<String> l1 = new ArrayList<>();
        ArrayList<String> l2 = new ArrayList<>();
        l1.add("123");
        l2.add("456");
    }
    public static void method(List<?> list) {
        // 1. 通配符的读操作
        // String obj = list.get(0); //报错
        Object obj = list.get(0);
        
        // 2. 通配符的写操作
        // list.add("123"); //报错
        list.add(null);
    }
}
```

**通配符的读操作**：由于`?`可能代表一切类型，所以进行读操作的时候，读出来的值类型必须声明为`Object`

**通配符的写操作**：由于`?`可能代表一切类型，所以为了不产生冲突，只能写入`null`

**使用注意点**：

1. `?`不能用在泛型方法声明上，即返回值类型前面的`<>`不能使用`?`

```java
public static <?> void test(ArrayList<?> list){
} // 报错
```

2. 不能用在泛型类的声明上

```java
class GenericTypeClass<?>{
} // 报错
```

3. 不能用在创建对象上，即不能new一个带`?`类型的对象

```java
new ArrayList<?>(); // 报错
```

### 4.2 有限制的通配符

泛型上限：`<? extends Father>`，表示 `?` 能接收的必须是`Father`及其子类。

泛型下限：`<? super Father>`，表示 `?` 能接受的必须是`Father`及其父类。

**注意**：有限制的通配符**限制了泛型变量的范围**，例如对于`List<? extends Father>`的类型，即使是`ArrayList<Object>`的对象也不能赋值给它，泛型变量必须是`Father`及其子类。

**`<? extends Father>`的读操作**：由于`?`可能代表的类型最大是`Father`，所以进行读操作的时候，读出来的值类型最精确的声明是`Father`

**`<? extends Father>`的写操作**：由于`?`可能代表的类型最大是`Father`，所以为了不产生冲突，只能写入`null`

**`<? super Father>`的读操作**：由于`?`可能代表的类型最小是`Father`，所以进行读操作的时候，读出来的值类型必须声明为`Object`

**`<? super Father>`的写操作**：由于`?`可能代表的类型最小是`Father`，所以进行写操作的时候，只要是`Father`类型或其子类的对象，都能写入

```java
public class MyTest {
    public static void main(String[] args) {
        List<? extends Father> list = null;
        ArrayList<Object> list1 = new ArrayList<>();
        // list = list1; // 报错
    }
    public static void method1(List<? extends Father> list) {
        // list.add(new Father());// 报错
        list.add(null);
        
        // Son s = list.get(0); // 报错
        Father f = list.get(0);
    }
    public static void method2(List<? super Father> list) {
        // list.add(new Object()); // 报错
        list.add(new Father());
        
        // Father f = list.get(0); // 报错
        Object o = list.get(0);
    }
}
class Father {
    public int idF = 10;
}
class Son extends Father{
    public int idS = 5;
}
```

# 第14章_数据结构与集合源码

## 1. List接口分析

### 1.1 ArrayList底层源码

调用空参构造器创建ArrayList对象时，底层会**初始化一个长度为0的Object数组(懒惰初始化)**：

```java
Object[] elementData = new Object[]{};
```

首次添加元素时，会初始化一个**长度为10的数组**：

```java
elementData = new Object[10];
elementData[0] = "新元素";
```

当底层数组已满时再添加元素，会**扩容1.5倍**(如果大小还是不够，比如调用addAll一次添加多个元素时，则会默认扩容到刚好所需的大小)，然后将原有数组中的元素复制到新的数组中。

**懒惰初始化的原因**：用的时候，再创建数组，避免浪费。因为很多方法的返回值是ArrayList类型，需要返回一个ArrayList的对象，例如：后期从数据库查询对象的方法，返回值很多就是ArrayList。有可能你要查询的数据不存在，要么返回null，要么返回一个没有元素的ArrayList对象。

注意：jdk7及之前并没有采用懒惰初始化，而是在调用空参构造器时直接初始化一个长度为10的数组。

### 1.2 Vector底层源码

调用空参构造器创建Vector对象时，底层会初始化一个长度为10的Object数组：

```java
Object[] elementData = new Object[10];
```

当底层数组已满时再添加元素，会扩容2倍。


### 1.3 LinkedList底层源码

**底层有两个指针first和last，分别记录第一个结点的位置和最后一个结点的位置**：

```java
transient Node<E> first;
transient Node<E> last;
```

Node的属性如下：

```java
private static class Node<E> {
    E item;
    Node<E> next;
    Node<E> prev;
}
```

调用空参构造器创建LinkedList对象时，底层什么都没做，即first和last都是默认为null。当添加元素时，底层会创建一个新的Node结点，并设置next和prev指针，最后再调整first和last指向相应的结点。注意LinkedList底层作为一个双向链表，是不存在扩容问题的。


## 2. Map接口分析

### 2.1 HashMap底层源码(JDK7)

#### 2.1.1 创建对象的过程

调用空参构造器创建HashMap对象时，底层会默认初始化一个**长度为16的Entry数组**：

```java
Entry[] table = new Entry[16];
```

如果调用有参构造器，设置底层table的长度为initialCapacity，实际上底层table的长度capacity未必就会被设置为initialCapacity，而是会被设置为2的幂次方，且满足 `capacity >= initialCapacity`，源码如下：

```java
public HashMap(int initialCapacity, float loadFactor) {
    //...
    //通过此循环，得到capacity的最终值，此最终值决定了Entry数组的长度。
    //此时的capacity一定是2的幂次方
    int capacity = 1;
    while (capacity < initialCapacity)
        capacity <<= 1;

    this.loadFactor = loadFactor; //装载因子
    threshold = (int)Math.min(capacity * loadFactor, MAXIMUM_CAPACITY + 1);  //临界值
    table = new Entry[capacity]; //初始化数组，长度为capacity
    
    //...
}
```

注1：**装载因子loadFactor默认为0.75**，虽然也可以通过有参构造器修改，但不建议这么做。
注2：**底层table数组的长度一定是2的幂次方**。
注3：`int threshold`是临界值，其值**由 capacity 与 loadFactor 相乘得到**，所以会随着 capacity 的变化而变化。

**Entry的定义如下**：

```java
static class Entry<K,V> implements Map.Entry<K,V> {
    final K key;
    V value;
    Entry<K,V> next;
    int hash;  //使用key得到的哈希值2进行赋值。

    Entry(int h, K k, V v, Entry<K,V> n) {
        value = v;
        next = n;
        key = k;
        hash = h;
    }
}
```

#### 2.1.2 put(key,value)的过程

源码如下：

```java
public V put(K key, V value) {
    //1、HashMap允许添加key为null的值。将此(key,value)存放到table索引0的位置。
    if (key == null)
        return putForNullKey(value);
    //2、将key传入hash()，内部使用了key的哈希值1，此方法执行结束后，返回哈希值2
    int hash = hash(key);
    //3、确定当前(key,value)在数组中的存放位置i
    int i = indexFor(hash, table.length);
    
    for (Entry<K,V> e = table[i]; e != null; e = e.next) {
        Object k;
        if (e.hash == hash && ((k = e.key) == key || key.equals(k))) {
            V oldValue = e.value;
            e.value = value;
            e.recordAccess(this);
            return oldValue;  //如果put是修改操作，会返回原有旧的value值。
        }
    }

    //.....
    //将(key,value)封装为一个Entry对象，并将此对象保存在索引i位置。
    addEntry(hash, key, value, i); 
    return null; //如果put是添加操作，会返回null.
}
```

下面我们详细描述其过程。我们将(key1,value1)调用put()方法添加到当前的map中，其过程如下：

**第1步**：如果key1为null，则会将(key1,value1)这个Entry对象**放到table索引为0的位置**。因为此时key1为null，所以产生Hash冲突时只需比较另一个对象的键是否为null即可，如果也为null，则直接用value1替换其值。该过程对应源码中的步骤1。

**第2步**：调用key1所在类的hashCode()方法，计算key1对应的哈希值1，此哈希值1经过某种算法(hash())之后，得到哈希值2。该过程对应源码中的步骤2。hash()方法的源码如下：

```java
final int hash(Object k) {
    int h = 0;
    if (useAltHashing) {
        if (k instanceof String) {
            return sun.misc.Hashing.stringHash32((String) k);
        }
        h = hashSeed;
    }

    h ^= k.hashCode();

    // This function ensures that hashCodes that differ only by
    // constant multiples at each bit position have a bounded
    // number of collisions (approximately 8 at default load factor).
    h ^= (h >>> 20) ^ (h >>> 12);
    return h ^ (h >>> 7) ^ (h >>> 4);
}
```

**第3步**：将哈希值2作为参数调用indexFor()方法，从而得到(key1,value1)在数组table中的索引位置i。该过程对应源码中的步骤3。indexFor()方法源码如下：

```java
static int indexFor(int h, int length) {
    return h & (length-1);
}
```

注意：**由于table的length为2的幂次方，所以length-1的二进制表示是全1的，用位与运算可以快速确定索引，效率极高**。

**第4步**：如果数组索引i上没有元素，则(key1,value1)添加成功。addEntry()方法的源码如下：

```java
void addEntry(int hash, K key, V value, int bucketIndex) {
    //扩容的条件
    if ((size >= threshold) && (null != table[bucketIndex])) {
        resize(2 * table.length); //默认扩容为原有容量的2倍
        hash = (null != key) ? hash(key) : 0;
        bucketIndex = indexFor(hash, table.length);
    }

    createEntry(hash, key, value, bucketIndex);
}
```

```java
void createEntry(int hash, K key, V value, int bucketIndex) {
    Entry<K,V> e = table[bucketIndex];
    table[bucketIndex] = new Entry<>(hash, key, value, e);
    size++;
}
```

即首先判断是否需要扩容(扩容的细节下面会补充)，如果无需扩容，则直接调用createEntry()创建Entry对象：**我们注意到新添加的(key1,value1)对象是一定放在索引i处的，而之前索引i处的对象会被(key1,value1)对象中的next指针指向(如果之前索引i处没有对象，则next指向null)，从形状上看，索引i处存放新添加的对象，然后它指向旧的对象，构成一个单向链表；并且，(key1,value1)对象中的hash属性由哈希值2赋值**。

**第5步**：如果数组索引i上有元素(key2,value2)，不失一般性我们假设其next指针指向null(如果索引i处是一个单链表，则逐一比较即可，步骤类似)，于是产生了Hash冲突。我们首先要比较key1刚算出的哈希值2，和(key2,value2)对象中存储的hash属性的值。如果这两个值不相同，则(key1,value1)添加成功，如上调用addEntry()方法即可。

**第6步**：如果第5步中所比较的两个hash值相同，则会进行源码中`(k = e.key) == key || key.equals(k)`的判断，即比较key1和key2：如果它们地址值相同，则相同；否则，调用key1所在类的equals()方法，将key2作为参数传递进去比较，如果返回true则相同。简而言之，若equals()返回false，则(key1,value1)添加成功，如上调用addEntry()方法即可；否则，认为key1和key2是相同的，**此时直接将(key2,value2)对象中的value属性赋值为value1**。

**扩容操作细节**：根据源码，我们发现扩容条件为`(size >= threshold) && (null != table[i])`，也就是说，当我们添加元素时，发现数组索引i处如果没有元素，则直接添加即可，不会扩容；如果索引i处有元素，并且此时HashMap中的**已有的元素数量size大于等于临界值threshold**，则会进行扩容，**默认数组长度扩容至2倍**。


### 2.2 HashMap底层源码(JDK8)

我们简要描述JDK8与JDK7的主要不同之处：

（1）在jdk8中，调用空参构造器创建HashMap对象后，底层只做了一件事，就是把装载因子设置为0.75，其余什么都没做，即并没有初始化table数组。当首次添加(key,value)时，进行判断，如果发现table尚未初始化，则对数组进行初始化，默认长度仍为16。

（2）在jdk8中，HashMap底层定义的是Node内部类，替换jdk7中的Entry内部类。即，我们创建的底层数组是`Node[]`，但它实际上也是实现了Entry接口。

（3）如果当前的(key,value)经过一系列判断之后，可以添加到当前的数组角标i中。**假设此时角标i位置上有元素，在jdk7中是将新的(key,value)指向已有的旧的元素（头插法），而在jdk8中是旧的元素指向新的(key,value)元素（尾插法）**

（4）jdk7的底层结构是数组+单向链表，而jdk8的底层结构是数组+单向链表+红黑树。

（5）单向链表转化为红黑树的时机：当我们将在索引i处添加新元素时，如果**数组索引i位置上的已有元素个数达到8，并且数组的长度达到64时**，我们就将此索引i位置上的多个元素改为使用红黑树的结构进行存储。注意：**如果数组索引i位置上的已有元素个数达到8，但是数组长度并未达到64，则会直接先进行扩容操作**。

（6）红黑树转化为单向链表的时机：**如果是删除元素，则当红黑树根root为空、或者root的左子树/右子树为空、或者root的左子树的左子树为空时，会直接将该索引处的红黑树转化为单向链表。如果是扩容操作，当新的红黑树的结点个数小于等于6的时候，就会退化为单向链表**。

### 2.3 LinkedHashMap底层源码

LinkedHashMap是HashMap的子类，它在HashMap使用的数组+单向链表+红黑树的基础上，又增加了一对双向链表，记录添加的(key,value)的先后顺序，便于我们遍历所有的key-value。其底层内部定义的Entry对象继承了HashMap的Node对象，而且额外添加了**before和after指针**：

```java
static class Entry<K,V> extends HashMap.Node<K,V> {
	Entry<K,V> before, after; //增加的一对双向链表
	
	Entry(int hash, K key, V value, Node<K,V> next) {
		super(hash, key, value, next);
	}
}
```

## 3. Set接口分析

- HashSet底层使用的就是HashMap
- LinkedHashSet底层使用的就是LinkedHashMap
- TreeSet底层使用的就是TreeMap

它们添加的元素就是Entry对象的key，**对应的value是一个全局常量**：

```java
public boolean add(E e) {
    return map.put(e, PRESENT)==null;
}
private static final Object PRESENT = new Object();
```

## 4. 【拓展】HashMap的相关问题

### 1、Entry中的hash属性为什么不直接使用key的hashCode()返回值呢？

不管是JDK1.7还是JDK1.8中，都不是直接用key的hashCode值直接与table.length-1计算求下标的，而是先对key的hashCode值进行了一个运算，JDK1.7和JDK1.8关于hash()的实现代码不一样，但是不管怎么样都是为了提高hash code值与 (table.length-1)的按位与完的结果，**尽量的均匀分布**。

虽然算法不同，但是**思路都是将hashCode值的高位二进制与低位二进制值进行了异或，让高位二进制也参与到index的计算中**。

为什么要hashCode值的二进制的高位参与到index计算呢？

因为一个HashMap的table数组一般不会特别大，至少在不断扩容之前，那么table.length-1的大部分高位都是0，**直接用hashCode和table.length-1进行&运算的话，就会导致总是只有最低的几位是有效的**，那么就算你的hashCode()实现的再好也难以避免发生碰撞，这时让高位参与进来的意义就体现出来了。它对hashcode的低位添加了随机性并且混合了高位的部分特征，显著减少了碰撞冲突的发生。

### 2、key-value中的key是否可以修改？

key-value存储到**HashMap中会存储key的hash值**，这样就不用在每次查找时重新计算每一个Entry的hash值了，因此如果已经put到Map中的key-value，再修改key的属性，而这个属性又参与hashcode值的计算，那么会导致匹配不上。所以不建议修改key。

### 3、JDK1.7中HashMap的循环链表是怎么回事？如何解决？

![](/zzimages/2023071966666.jpg)

避免HashMap发生死循环的常用解决方案：

- 多线程环境下，使用线程安全的ConcurrentHashMap替代HashMap，推荐
- 多线程环境下，使用synchronized或Lock加锁，但会影响性能，不推荐
- 多线程环境下，使用线程安全的Hashtable替代，性能低，不推荐

HashMap死循环只会发生在JDK1.7版本中，主要原因：头插法+链表+多线程并发+扩容。

在JDK1.8中，HashMap改用尾插法，解决了链表死循环的问题。



# 第15章_File类与IO流

## 1. java.io.File类的使用

### 1.1 概述

-  File类及本章下的各种流，都定义在java.io包下。
-  一个File对象代表硬盘或网络中可能存在的一个文件或者文件目录（俗称文件夹），与平台无关。
- File 能新建、删除、获取名称、重命名文件和目录，但File不能读写文件中的数据。如果需要访问文件中的数据，则需要使用输入/输出流。
  - File对象可以作为参数传递给流的构造器。
- 想要在Java程序中表示一个真实存在的文件或目录，那么必须有一个File对象，但是Java程序中的一个File对象，也可能没有一个真实存在的文件或目录。

### 1.2 构造器

* `public File(String pathname) ` ：以pathname为路径创建File对象，可以是绝对路径或者相对路径，如果pathname是相对路径，则默认的当前路径在系统属性user.dir中存储。
* `public File(String parent, String child) ` ：以parent为父路径，child为子路径创建File对象。parent必须是一个目录路径，而child可以是一个文件路径或目录路径。
* `public File(File parent, String child)` ：根据一个父File对象和子文件路径创建File对象。parent对应的路径必须是一个目录路径，而child可以是一个文件路径或目录路径

关于路径：

* **绝对路径**：以windows操作系统为例，包括盘符在内的文件或文件目录的完整路径
* **相对路径**：相对于某一个目录来讲的相对位置。
  * IDEA中，main中的文件的相对路径，是相对于`当前project`
  * IDEA中，单元测试方法中的文件的相对路径，是相对于`当前module`

> 注意：
>
> 1. 无论该路径下是否存在文件或者目录，都不影响File对象的创建。
>
> 2. window的路径分隔符使用`\`，而Java程序中的`\`表示转义字符，所以在Windows中表示路径，需要用`\\`。或者直接使用`/`也可以，Java程序支持将`/`当成平台无关的`路径分隔符`。
>
> 3. 当构造路径是绝对路径时，那么getPath和getAbsolutePath结果一样。当构造路径是相对路径时，那么getAbsolutePath的路径 = user.dir的路径 + 构造路径

### 1.3 常用方法

#### 1、获取文件和目录基本信息

* `public String getName()`：获取名称
* `public String getPath()`：获取创建文件对象时，使用的路径
* `public String getAbsolutePath()`：获取绝对路径
* `public File getAbsoluteFile()`：获取绝对路径表示的文件
* `public String getParent()`：获取上层文件目录路径。若无，返回null
* `public long length()`：获取文件长度（即：字节数）。不能获取目录的长度。
* `public long lastModified()`：获取最后一次的修改时间，毫秒值

> 如果File对象代表的文件或目录存在，则File对象实例初始化时，就会用硬盘中对应文件或目录的属性信息（例如，时间、类型等）为File对象的属性赋值，否则除了路径和名称，File对象的其他属性将会保留默认值。

举例：

```java
@Test
public void test1() {
    File file1 = new File("IOtest/hello.txt");
    System.out.println(file1.getName()); //hello.txt
    System.out.println(file1.getPath()); //IOtest\hello.txt
    System.out.println(file1.getAbsolutePath()); //D:\IT\JavaSEProject\TestModule\IOtest\hello.txt
    System.out.println(file1.getAbsoluteFile()); //D:\IT\JavaSEProject\TestModule\IOtest\hello.txt
    System.out.println(file1.getParent()); //IOtest
    System.out.println(file1.length()); //6
    System.out.println(file1.lastModified()); //1689746110429
}
```

#### 2、列出目录的下一级

* `public String[] list()`：返回一个String数组，表示该File目录中的所有一级子文件/目录名称。
* `public File[] listFiles()`：返回一个File数组，表示该File目录中的所有一级子文件/目录对象。 

**注意**：

1. 当主调是文件时，或者路径不存在时，返回null
2. 当主调是空文件夹时，返回一个长度为0的数组
3. 当主调是一个文件夹，且里面有隐藏文件时，隐藏文件同样会返回到数组中
4. 当主调是一个文件夹，但是没有权限访问该文件夹时，返回null

```java
@Test
public void test2() {
    File file1 = new File("IOtest");
    String[] arr1 = file1.list();
    for (String s : arr1)
        System.out.println(s); // hello.txt  testDir  thuwsy.txt
    System.out.println("------------------");
    File[] arr2 = file1.listFiles();
    for (File f : arr2)
        System.out.println(f); // IOtest\hello.txt  IOtest\testDir  IOtest\thuwsy.txt
}
```

**补充**：`list()`和`listFiles()`有重载方法，用于条件过滤。
```java
public String[] list(FilenameFilter filter)
public File[] listFiles(FilenameFilter filter)
public File[] listFiles(FileFilter filter)
```

举例：输出当前目录中的所有txt文件的文件名

```java
@Test
public void test3() throws IOException {
    File file1 = new File("IOtest");
    String[] arr = file1.list(new FilenameFilter() {
        @Override
        public boolean accept(File dir, String name) {
            return name.endsWith(".txt");
        }
    });
    for (String s : arr)
        System.out.println(s);
}
```

#### 3、File类的重命名功能

- `public boolean renameTo(File dest)`:把文件重命名为指定的文件路径。实际上就类似linux的mv指令，剪切并重命名。

#### 4、判断功能的方法

- `public boolean exists()` ：此File表示的文件或目录是否实际存在。
- `public boolean isDirectory()` ：此File表示的是否为目录。
- `public boolean isFile()` ：此File表示的是否为文件。
- `public boolean canRead()`：判断是否可读
- `public boolean canWrite()`：判断是否可写
- `public boolean isHidden()`：判断是否隐藏

> 如果文件或目录不存在，那么上述方法全部返回false

#### 5、创建、删除功能

- `public boolean createNewFile()` ：创建文件。若文件存在，则不创建，返回false。
- `public boolean mkdir()` ：创建文件目录。如果此文件目录存在，就不创建了。如果此文件目录的上层目录不存在，也不创建。
- `public boolean mkdirs()` ：创建文件目录。如果上层文件目录不存在，一并创建。
- `public boolean delete()` ：删除文件或者空目录。删除注意事项：1、Java中删除后不会进入回收站；2、对于目录而言，只能删除空目录。


**举例(递归遍历目录)**：

```java
    @Test
    public void test() {
        File file1 = new File("IOtest/testDir");
        printFileName(file1);
        System.out.println(getDirectorySize(file1));
        deleteDirectory(file1);
    }
    // 遍历指定目录下的所有文件的名称，包括子文件目录中的文件
    public void printFileName(File file) { // file可能是文件，也可能是目录
        if (file.isFile())
            System.out.println(file.getName());
        else if (file.isDirectory()) {
            File[] arr = file.listFiles();
            for (File f : arr)
                printFileName(f);
        }
    }
    // 计算指定目录中所有文件占用空间的大小
    public long getDirectorySize(File file) {
        long size = 0;
        if (file.isFile())
            size = file.length();
        else if (file.isDirectory()) {
            File[] arr = file.listFiles();
            for (File f : arr)
                size += getDirectorySize(f);
        }
        return size;
    }
    // 删除指定目录及其下的所有文件
    public void deleteDirectory(File file) {
        if (file.isDirectory()) {
            File[] arr = file.listFiles();
            for (File f : arr)
                deleteDirectory(f);
        }
        file.delete();
    }
```

## 2. IO流原理及流的分类

### 2.1 Java IO原理

I/O流中的I/O是`Input/Output`的缩写， I/O技术是非常实用的技术，用于处理设备之间的数据传输。如读/写文件，网络通讯等。
- `输入input`：读取外部数据（磁盘、光盘等存储设备的数据）到程序（内存）中。
- `输出output`：将程序（内存）数据输出到磁盘、光盘等存储设备中。

### 2.2 流的分类

`java.io`包下提供了各种“流”类和接口，用以获取不同种类的数据，并通过`标准的方法`输入或输出数据。

- 按数据的流向不同分为：**输入流**和**输出流**。
  - **输入流** ：把数据从`其他设备`上读取到`内存`中的流。 
  - **输出流** ：把数据从`内存` 中写出到`其他设备`上的流。

- 按操作数据单位的不同分为：**字节流（8bit）**和**字符流（16bit）**。
  - **字节流** ：以字节为单位，读写数据的流。
  - **字符流** ：以字符为单位，读写数据的流。

- 根据IO流的角色不同分为：**节点流**和**处理流**。
  - **节点流**：直接从数据源或目的地读写数据。也称为原始流、低级流。
  - **处理流**：不直接连接到数据源或目的地，而是“连接”在已存在的流（节点流或处理流）之上，通过对数据的处理为程序提供更为强大的读写功能。也称为包装流。

### 2.3 流的API

Java的IO流共涉及40多个类，实际上非常规则，都是从如下4个抽象基类派生的。

| （抽象基类） |   输入流    |    输出流    |
| :----------: | :---------: | :----------: |
|    字节流    | InputStream | OutputStream |
|    字符流    |   Reader    |    Writer    |

- 由这四个类派生出来的子类名称都是以其父类名作为子类名后缀。

![](/zzimages/20230720121713.png)


**常用的节点流：** 　

* 文件流： FileInputStream、FileOutputStrean、FileReader、FileWriter 
* 字节/字符数组流： ByteArrayInputStream、ByteArrayOutputStream、CharArrayReader、CharArrayWriter 
  * 对数组进行处理的节点流（对应的不再是文件，而是内存中的一个数组）。

**常用处理流：**

* 缓冲流：BufferedInputStream、BufferedOutputStream、BufferedReader、BufferedWriter
  * 作用：增加缓冲功能，避免频繁读写硬盘，进而提升读写效率。
* 转换流：InputStreamReader、OutputStreamReader
  * 作用：实现字节流和字符流之间的转换。
* 对象流：ObjectInputStream、ObjectOutputStream
  * 作用：提供直接读写Java对象功能

## 3. 节点流之一：FileReader\FileWriter

### 3.1 Reader与Writer

**Java提供一些字符流类，以字符为单位读写数据，专门用于处理文本文件。不能操作图片，视频等非文本文件**。

> 文本文件：.txt、.java、.c、.cpp、.py等
>
> 非文本文件：.doc、.xls、.ppt、.jpg 、.pdf、.mp3、.mp4、.avi 等

#### 3.1.1 字符输入流：Reader

`java.io.Reader`抽象类是表示用于读取字符流的所有类的父类，可以读取字符信息到内存中。它定义了字符输入流的基本共性功能方法。

- `public int read()`： 从输入流读取一个字符。 虽然读取了一个字符，但是会自动提升为int类型。返回该字符的Unicode编码值。如果已经到达流末尾了，则返回-1。
- `public int read(char[] cbuf)`： 从输入流中读取一些字符，并将它们存储到字符数组cbuf中 。每次最多读取cbuf.length个字符。返回实际读取的字符个数。如果已经到达流末尾，没有数据可读，则返回-1。 
- `public int read(char[] cbuf,int off,int len)`：从输入流中读取一些字符，并将它们存储到字符数组cbuf中，从`cbuf[off]`开始的位置存储。每次最多读取len个字符。返回实际读取的字符个数。如果已经到达流末尾，没有数据可读，则返回-1。 
- `public void close()`：关闭此流并释放与此流相关联的任何系统资源。    

> 注意：当完成流的操作时，必须调用close()方法，释放系统资源，否则会造成内存泄漏。

#### 3.1.2 字符输出流：Writer

`java.io.Writer `抽象类是表示用于写出字符流的所有类的超类，将指定的字符信息写出到目的地。它定义了字节输出流的基本共性功能方法。

- `public void write(int c)` ：写出单个字符。
- `public void write(char[] cbuf) `：写出字符数组。 
- `public void write(char[] cbuf, int off, int len) `：写出字符数组的某一部分。off：数组的开始索引；len：写出的字符个数。 
- `public void write(String str) `：写出字符串。 
- `public void write(String str, int off, int len)`：写出字符串的某一部分。off：字符串的开始索引；len：写出的字符个数。
- `public void flush() `：刷新该流的缓冲。  
- `public void close()` ：关闭此流。

> 注意：当完成流的操作时，必须调用close()方法，释放系统资源，否则会造成内存泄漏。

### 3.2 FileReader 与 FileWriter

#### 3.2.1 FileReader

`java.io.FileReader`类用于读取字符文件，构造时使用系统默认的字符编码和默认字节缓冲区。

- `FileReader(File file)`：创建一个新的 FileReader ，给定要读取的File对象。   
- `FileReader(String fileName)`：创建一个新的 FileReader ，给定要读取的文件的名称。  

**读写文件的步骤**：

1. 创建读取或写出的File类的对象
2. 创建输入流或输出流
3. 具体的读入或写出的过程。
   - 读操作常用`read(char[] cbuffer)`
   - 写操作常用`write(String str)` 或 `write(char[] cbuffer, 0, len)`
4. 关闭流资源，避免内存泄漏

**注意事项**：

- 因为涉及到流资源的关闭操作，所以出现异常的话，需要使用try-catch-finally的方式来处理异常。推荐使用try-with-resource，代码简洁，让资源自动调用close()。
- 对于输入流来讲，要求File类的对象对应的物理磁盘上的文件必须存在，否则会报FileNotFoundException。如果传入的是一个目录，则会报IOException异常。
- 对于输出流来讲，File类的对象对应的物理磁盘上的文件可以不存在。
  - 如果此文件不存在，则在输出的过程中，会自动创建此文件，并写出数据到此文件中。
  - 如果此文件存在。若使用 `FileWriter(file)` 创建流，则输出数据过程中，会新建同名的文件对现有的文件进行覆盖；若使用 `FileWriter(file, true)` 创建流，则输出数据过程中，会在现有的文件的末尾追加写出内容。

**举例**：读取hello.txt文件中的字符数据，并显示在控制台上

```java
@Test
public void test1() {
    File file = new File("IOtest/hello.txt");
    try (
            FileReader fr = new FileReader(file);
            ) {
        char[] buffer = new char[1024];
        int len = 0;
        while ((len = fr.read(buffer)) != -1) {
            String str = new String(buffer, 0, len);
            System.out.println(str);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

#### 3.2.2 FileWriter

`java.io.FileWriter `类用于写出字符到文件，构造时使用系统默认的字符编码和默认字节缓冲区。

- `FileWriter(File file)`： 创建一个新的 FileWriter，给定要写入的File对象。   
- `FileWriter(String fileName)`：创建一个新的 FileWriter，给定要写入的文件的名称。  
- `FileWriter(File file, boolean append)`：创建一个新的FileWriter，指明是否在现有文件末尾追加内容。
- `FileWriter(String fileName, boolean append)`：创建一个新的FileWriter，指明是否在现有文件末尾追加内容。

**举例**：将hello.txt文件复制一份，得到hello_copy.txt

```java
@Test
public void test2() {
    File src = new File("IOtest/hello.txt");
    File dest = new File("IOtest/hello_copy.txt");
    try (
            FileReader fr = new FileReader(src);
            FileWriter fw = new FileWriter(dest);
            ) {
        char[] buffer = new char[1024];
        int len = 0;
        while ((len = fr.read(buffer)) != -1) {
            fw.write(buffer, 0, len);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### 3.3  关于flush（刷新）

因为内置缓冲区的原因，如果FileWriter不关闭输出流，无法写出字符到文件中。但是关闭的流对象，是无法继续写出数据的，否则会报异常。如果我们既想写出数据，又想继续使用流，就需要`flush()` 方法了。

- `flush()` ：刷新缓冲区，流对象可以继续使用。
- `close() `：先刷新缓冲区，然后通知系统释放资源。流对象不可以再被使用了。

注意：即便是flush()方法写出了数据，操作的最后还是要调用close方法，释放系统资源。

举例：

```java
public class FWWriteFlush {
    //注意：应该使用try-catch-finally处理异常。这里出于方便阅读代码，使用了throws的方式
    @Test
    public void test() throws IOException {
        // 使用文件名称创建流对象
        FileWriter fw = new FileWriter("fw.txt");
        // 写出数据，通过flush
        fw.write('刷'); // 写出第1个字符
        fw.flush();
        fw.write('新'); // 继续写出第2个字符，写出成功
        fw.flush();

        // 写出数据，通过close
        fw.write('关'); // 写出第1个字符
        fw.close();
        fw.write('闭'); // 继续写出第2个字符,【报错】java.io.IOException: Stream closed
        fw.close();
    }
}
```

## 4. 节点流之二：FileInputStream\FileOutputStream

如果我们读取或写出的数据是非文本文件，则Reader、Writer就无能为力了，必须使用字节流。

### 4.1 InputStream和OutputStream

#### 4.1.1 字节输入流：InputStream

`java.io.InputStream `抽象类是表示字节输入流的所有类的超类，可以读取字节信息到内存中。它定义了字节输入流的基本共性功能方法。

- `public int read()`： 从输入流读取一个字节。返回读取的字节值。虽然读取了一个字节，但是会自动提升为int类型。如果已经到达流末尾，没有数据可读，则返回-1。 
- `public int read(byte[] b)`： 从输入流中读取一些字节数，并将它们存储到字节数组b中。每次最多读取b.length个字节。返回实际读取的字节个数。如果已经到达流末尾，没有数据可读，则返回-1。 
- `public int read(byte[] b, int off, int len)`：从输入流中读取一些字节数，并将它们存储到字节数组b中，从`b[off]`开始存储，每次最多读取len个字节 。返回实际读取的字节个数。如果已经到达流末尾，没有数据可读，则返回-1。 
- `public byte[] readAllBytes()`：直接将当前字节输入流对应的文件对象的所有字节数据装到一个字节数组中返回
- `public void close()`：关闭此输入流并释放与此流相关联的任何系统资源。    

####  4.1.2 字节输出流：OutputStream

`java.io.OutputStream `抽象类是表示字节输出流的所有类的超类，将指定的字节信息写出到目的地。它定义了字节输出流的基本共性功能方法。

- `public void write(int b)` ：将指定的字节输出流。虽然参数为int类型四个字节，但是只会保留一个字节的信息写出。
- `public void write(byte[] b)`：将 b.length字节从指定的字节数组写入此输出流。  
- `public void write(byte[] b, int off, int len)` ：从指定的字节数组写入len字节，从偏移量off开始输出到此输出流。  
- `public void flush()`：刷新此输出流并强制任何缓冲的输出字节被写出。  
- `public void close()`：关闭此输出流并释放与此流相关联的任何系统资源。  

### 4.2 FileInputStream 与 FileOutputStream

#### 4.2.1 FileInputStream

`java.io.FileInputStream `类是文件输入流，从文件中读取字节。

- `FileInputStream(File file)`：通过打开与实际文件的连接来创建一个 FileInputStream ，该文件由文件系统中的 File对象 file命名。 
- `FileInputStream(String name)`：通过打开与实际文件的连接来创建一个 FileInputStream ，该文件由文件系统中的路径名name命名。  

**读写文件的步骤**：与字符流类似，只不过做读写操作时，针对的是`byte[]`数组

**注意**：对于字符流，只能用来操作文本文件，不能用来处理非文本文件的。而对于字节流，通常是用来处理非文本文件的，但如果涉及到文本文件的复制操作，也可以使用字节流。

#### 4.2.2 FileOutputStream

`java.io.FileOutputStream `类是文件输出流，用于将数据写出到文件。

- `public FileOutputStream(File file)`：创建文件输出流，写出由指定的File对象表示的文件。 
- `public FileOutputStream(String name)`：创建文件输出流，指定的名称为写出文件。
- `public FileOutputStream(File file, boolean append)`：创建文件输出流，指明是否在现有文件末尾追加内容。
- `public FileOutputStream(String name, boolean append)`：创建文件输出流，指明是否在现有文件末尾追加内容。

**举例**：将picture.png图片复制一份，得到picture_copy.png

```java
@Test
public void test1() {
    File src = new File("IOtest/picture.png");
    File dest = new File("IOtest/picture_copy.png");
    try (
            FileInputStream is = new FileInputStream(src);
            FileOutputStream os = new FileOutputStream(dest);
            ) {
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = is.read(buffer)) != -1) {
            os.write(buffer, 0, len);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

## 5. 处理流之一：缓冲流

`为了提高数据读写的速度`，Java API提供了带缓冲功能的流类：缓冲流。

缓冲流要“套接”在相应的节点流之上，根据数据操作单位可以把缓冲流分为：
- **字节缓冲流**：`BufferedInputStream`，`BufferedOutputStream` 
- **字符缓冲流**：`BufferedReader`，`BufferedWriter`

缓冲流的基本原理：在创建流对象时，内部会创建一个缓冲区数组（默认使用`8192个字节(8KB)`的缓冲区），通过缓冲区读写，减少系统IO次数，从而提高读写的效率。

- **读数据时**：它先用原始的节点流一次性读取8KB的数据存入缓冲流内部的数组中，然后再从8KB的字节数组缓冲区中读取。
- **写数据时：** 它是先把数据写到缓冲流内部的8KB的数组中，等数组存满了，再通过原始的节点流，一次性写到目标文件中。

注意：**缓冲流的性能不一定比节点流高，比如节点流读写时自己加一个很大的数组，性能就会很好，但此时内存空间消耗就会很大**。所以缓冲流相当于帮我们加了一个相对而言大小比较合理的缓冲区数组，使得在时间和空间上都比较好。

### 5.1 构造器

* `public BufferedInputStream(InputStream in)` ：创建一个新的字节型的缓冲输入流。 
* `public BufferedOutputStream(OutputStream out)`：创建一个新的字节型的缓冲输出流。
* `public BufferedReader(Reader in)` ：创建一个新的字符型的缓冲输入流。 
* `public BufferedWriter(Writer out)`： 创建一个新的字符型的缓冲输出流。

**举例**：将picture.png图片复制一份，得到picture_copy1.png

```java
@Test
public void test1() {
    File src = new File("IOtest/picture.png");
    File dest = new File("IOtest/picture_copy1.png");
    try (
            FileInputStream fis = new FileInputStream(src);
            FileOutputStream fos = new FileOutputStream(dest);
            BufferedInputStream bis = new BufferedInputStream(fis);
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            ) {
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = bis.read(buffer)) != -1) {
            bos.write(buffer, 0, len);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

注意：涉及到嵌套的多个流时，如果都显式关闭的话，需要先关闭外层的流，再关闭内层的流（其实在开发中，只需要关闭最外层的流即可，因为在关闭外层流时，内层的流也会自动被关闭）。不过我们采用try-with-resource方法后，就无需自己手动关闭流了。


### 5.2 字符缓冲流特有方法

字符缓冲流有两个特有的方法：

* BufferedReader：`public String readLine()`: 读一行文字，注意返回的String中没有换行符。如果读到末尾，则返回null。 
* BufferedWriter：`public void newLine()`: 写一行行分隔符(即写一个换行符)，由系统属性定义符号。 

**举例**：利用readLine()复制一个文本文件

```java
@Test
public void test1() {
    try (
            BufferedReader br = new BufferedReader(new FileReader("IOtest/1.txt"));
            BufferedWriter bw = new BufferedWriter(new FileWriter("IOtest/1copy.txt"));
            ) {
        String data;
        while ((data = br.readLine()) != null) {
            bw.write(data);
            bw.newLine();
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

## 6. 处理流之二：转换流

### 6.1 InputStreamReader 与 OutputStreamWriter

使用`FileReader` 读取项目中的文本文件。由于IDEA设置中针对项目设置了UTF-8编码，当读取Windows系统中创建的文本文件时，如果Windows系统默认的是GBK编码，则读入内存中会出现乱码。因此我们引入了转换流，转换流实现了字节与字符之间的转换。

**InputStreamReader** 

- 转换流`java.io.InputStreamReader`，是Reader的子类(字符输入流)，是从字节流到字符流的桥梁。它读取字节，并使用指定的字符集将其解码为字符。它的字符集可以由名称指定，也可以接受平台的默认字符集。 

- 构造器
    - `InputStreamReader(InputStream in)`: 创建一个使用默认字符集的字符流。 
    - `InputStreamReader(InputStream in, String charsetName)`: 创建一个指定字符集的字符流。

**OutputStreamWriter**

- 转换流`java.io.OutputStreamWriter` ，是Writer的子类(字符输出流)，是从字符流到字节流的桥梁。使用指定的字符集将字符编码为字节。它的字符集可以由名称指定，也可以接受平台的默认字符集。 

- 构造器
  - `OutputStreamWriter(OutputStream out)`: 创建一个使用默认字符集的字符流。 
  - `OutputStreamWriter(OutputStream out, String charsetName)`: 创建一个指定字符集的字符流。

**举例**：将utf-8格式的文件复制一份成为gbk格式的文件

```java
@Test
public void test1() {
    try (
            FileInputStream fis = new FileInputStream("IOtest/1_utf-8.txt");
            InputStreamReader isr = new InputStreamReader(fis, "utf-8");
            FileOutputStream fos = new FileOutputStream("IOtest/1_gbk.txt");
            OutputStreamWriter osw = new OutputStreamWriter(fos, "gbk");
            ) {
        char[] buffer = new char[1024];
        int len = 0;
        while ((len = isr.read(buffer)) != -1) {
            osw.write(buffer, 0, len);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```


### 6.2 字符编码和字符集

#### 6.2.1 编码与解码

计算机中储存的信息都是用`二进制数`表示的，而我们在屏幕上看到的数字、英文、标点符号、汉字等字符是二进制数转换之后的结果。按照某种规则，将字符存储到计算机中，称为**编码** 。反之，将存储在计算机中的二进制数按照某种规则解析显示出来，称为**解码** 。

**字符编码（Character Encoding）** : 就是一套自然语言的字符与二进制数之间的对应规则。

**乱码的情况**：按照A规则存储，同样按照A规则解析，那么就能显示正确的文本符号。反之，按照A规则存储，再按照B规则解析，就会导致乱码现象。

所以，解码时使用的字符集必须与当初编码时使用的字符集兼容。例如文件编码使用的是GBK，解码时使用的是utf-8，那么文件中的英文数字等都不会乱码(因为都向下兼容ASCII)，但中文字符就会出现乱码。

#### 6.2.2 字符集

**字符集Charset**：也叫编码表。是一个系统支持的所有字符的集合，包括各国家文字、标点符号、图形符号、数字等。

计算机要准确的存储和识别各种字符集符号，需要进行字符编码，一套字符集必然至少有一套字符编码。常见字符集有ASCII字符集、GBK字符集、Unicode字符集等。

可见，当指定了**编码**，它所对应的**字符集**自然就指定了，所以**编码**才是我们最终要关心的。

**1、ASCII字符集** 

* ASCII码：上个世纪60年代，美国制定了一套字符编码，对`英语字符`与二进制位之间的关系，做了统一规定。这被称为ASCII码。
* 基本的ASCII字符集，使用7位（bits）表示一个字符（最前面的1位统一规定为0），共`128个`字符。
  
**2、ISO-8859-1字符集**

* 拉丁码表，别名Latin-1，用于显示欧洲使用的语言
* ISO-8859-1使用单字节编码，兼容ASCII编码。
  
**3、GBxxx字符集**

* GB就是国标的意思，是为了`显示中文`而设计的一套字符集。
* **GB2312**：简体中文码表。一个小于127的字符的意义与原来相同，即向下兼容ASCII码。但两个大于127的字符连在一起时，就表示一个汉字，这样大约可以组合了包含7000多个简体汉字。此外数学符号、罗马希腊的字母、日文的假名们都编进去了，这就是常说的"全角"字符，而原来在127号以下的那些符号就叫"半角"字符了。
* **GBK**：最常用的中文码表。是在GB2312标准基础上的扩展规范，使用了`双字节`编码方案(但一个ASCII字符还是用一个字节存储的)，共收录了21003个汉字，完全兼容GB2312标准，同时支持`繁体汉字`以及日韩汉字等。
* **GB18030**：最新的中文码表。收录汉字70244个，采用`多字节`编码，每个字可以由1个、2个或4个字节组成。
  
**4、Unicode字符集** ：

* Unicode编码为表达`任意语言的任意字符`而设计，也称为统一码、标准万国码。Unicode 将世界上所有的文字用`2个字节`统一进行编码，为每个字符设定唯一的二进制编码，以满足跨语言、跨平台进行文本处理的要求。
  - Unicode 的缺点：这里有三个问题：
    - 第一，英文字母只用一个字节表示就够了，如果用更多的字节存储是`极大的浪费`。
    - 第二，如何才能`区别Unicode和ASCII`？计算机怎么知道两个字节表示一个符号，而不是分别表示两个符号呢？
    - 第三，如果和GBK等双字节编码方式一样，用最高位是1或0表示两个字节和一个字节，就少了很多值无法用于表示字符，`不够表示所有字符`。
* Unicode在很长一段时间内无法推广，直到互联网的出现，为解决Unicode如何在网络上传输的问题，于是面向传输的众多 UTF（UCS Transfer Format）标准出现。具体来说，有三种**编码方案**，UTF-8、UTF-16和UTF-32。

* **UTF-8编码方案**：
  * Unicode是字符集，UTF-8、UTF-16、UTF-32是三种`将数字转换到程序数据`的编码方案。顾名思义，UTF-8就是每次8个位传输数据，而UTF-16就是每次16个位。其中，UTF-8 是在互联网上`使用最广`的一种 Unicode 的实现方式。
  * 互联网工程工作小组（IETF）要求所有互联网协议都必须支持UTF-8编码。所以，我们开发Web应用，也要使用UTF-8编码。UTF-8 是一种`变长的编码方式`。它使用1-4个字节为每个字符编码，编码规则：
    1. 128个US-ASCII字符，只需一个字节编码。
    2. 拉丁文等字符，需要二个字节编码。 
    3. 大部分常用字（含中文），使用三个字节编码。
    4. 其他极少使用的Unicode辅助字符，使用四字节编码。


> 注意：在中文操作系统上，ANSI（美国国家标准学会、AMERICAN NATIONAL STANDARDS INSTITUTE: ANSI）编码即为GBK；在英文操作系统上，ANSI编码即为ISO-8859-1。


#### 6.2.3 字符在文件与内存中的存储

**字符在文件中的存储**：字符存储在磁盘文件中时，一般采用GBK或者UTF-8，所以一个ASCII字符都只占1个字节。但中文(包括中文标点)如果以GBK的方式存储，会占2个字节；而以UTF-8的方式存储，会占3个字节。

**字符在内存中的存储**：我们知道Java中一个字符(char)占用2个字节，因为在内存中使用的是Unicode字符集。将磁盘文件中的字符读入内存时，会做如下的转换：

|Unicode符号范围(十六进制)  | UTF-8编码方式（二进制）|
|------|------|
|0000 0000-0000 007F | 0xxxxxxx（兼容原来的ASCII）|
|0000 0080-0000 07FF | 110xxxxx 10xxxxxx|
|0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx|
|0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx|

![](/zzimages/image-20220525164636164.png)


## 7. 处理流之三/四：数据流、对象流

### 7.1 数据流与对象流说明

如果需要将内存中定义的变量（包括基本数据类型或引用数据类型）保存在文件中，可以使用Java提供的数据流和对象流来处理这些类型的数据：

**数据流：DataOutputStream、DataInputStream**
  - DataOutputStream：允许应用程序将基本数据类型、String类型的变量写入输出流中
  - DataInputStream：允许应用程序以与机器无关的方式从底层输入流中读取基本数据类型、String类型的变量。

数据流DataInputStream中的方法：
  
```java
  byte readByte()                short readShort()
  int readInt()                  long readLong()
  float readFloat()              double readDouble()
  char readChar()				 boolean readBoolean()					
  String readUTF()               void readFully(byte[] b)
```

注1：对数据流DataOutputStream中的方法：将上述的方法的read改为相应的write即可。

注2：数据流的弊端：只支持Java基本数据类型和字符串的读写，而不支持其它Java对象的类型。下面介绍的对象流既支持基本数据类型的读写，也支持引用数据类型的读写。

**对象流：ObjectOutputStream、ObjectInputStream**
  
  - ObjectOutputStream：将Java基本数据类型和对象写入字节输出流中。通过在流中使用文件可以实现Java各种基本数据类型的数据以及对象的持久存储。
  - ObjectInputStream：对以前使用ObjectOutputStream写出的基本数据类型的数据和对象进行读入操作，保存在内存中。

### 7.2 对象流API

#### 7.2.1 ObjectOutputStream

构造器：`public ObjectOutputStream(OutputStream out) `

常用方法：

- 对于基本数据类型和String类型，方法名与数据流相同，都是writeXxx。例如writeInt(int val)，writeUTF(String str)等
- `public void writeObject(Object obj)`：特有方法，写出一个obj对象

#### 7.2.2 ObjectInputStream

构造器：`public ObjectInputStream(InputStream in) `

常用方法：

- 对于基本数据类型和String类型，方法名与数据流相同，都是readXxx
- `public void readObject(Object obj)`：特有方法，读入一个obj对象


### 7.3 认识对象序列化机制

**1、何为对象序列化机制？**

`对象序列化机制`允许把内存中的Java对象转换成平台无关的二进制流，从而允许把这种二进制流持久地保存在磁盘上，或通过网络将这种二进制流传输到另一个网络节点。当其它程序获取了这种二进制流，就可以恢复成原来的Java对象。

- 序列化过程：使用ObjectOutputStream流实现。用一个字节序列表示一个对象，然后将其写入到文件。
- 反序列化过程：使用ObjectInputSteam流实现。该字节序列还可以从文件中读取到内存，重构对象。

**2、序列化机制的重要性**

序列化是 RMI（Remote Method Invoke、远程方法调用）过程的参数和返回值都必须实现的机制，而 RMI 是 JavaEE 的基础。因此序列化机制是 JavaEE 平台的基础。

序列化的好处，在于可将任何实现了Serializable接口的对象转化为**字节数据**，使其在保存和传输时可被还原。

### 7.4 如何实现序列化机制

自定义类要想实现序列化机制，需要满足：

1. 自定义类需要实现接口`Serializable`。注意`Serializable` 是一个`标记接口`，不实现此接口的类将不会使任何状态序列化或反序列化，会抛出`NotSerializableException`
2. 自定义类需要声明一个全局常量：如`static final long serialVersionUID = 42234234L;` 用来唯一的标识当前的类。注意，如果不声明全局常量serialVersionUID，系统会自动声明生成一个针对于当前类的serialVersionUID，然而，如果修改此类的话，会导致serialVersionUID变化，进而导致反序列化时，出现InvalidClassException异常。
3. 自定义类的各个属性也必须是可序列化的。对于基本数据类型的属性，默认就是可以序列化的；而对于引用数据类型的属性，要求实现Serializable接口(比如String、ArrayList等就实现了该接口)

注1：如果有一个属性不需要可序列化的，则该属性必须注明是瞬态的，使用`transient` 关键字修饰
注2：`静态（static）变量`的值不会序列化。因为静态变量的值不属于某个对象。

**举例**：将一个对象写入文件，然后再读入内存，并输出到控制台(提示：如果有多个对象需要序列化，则可以将对象放到集合中，再序列化集合对象即可)

```java
public class MyTest {
    public static void main(String[] args) {
    }
    @Test
    public void test1() {
        File file = new File("IOtest/obj.txt");
        writeOp(file);
        readOp(file);
    }
    public void writeOp(File file) {
        ArrayList<Animal> list = new ArrayList<>();
        list.add(new Animal(1, "小猫"));
        list.add(new Animal(100, "小狗"));
        list.add(new Animal(666, "小猪"));
        try (
                FileOutputStream fos = new FileOutputStream(file);
                ObjectOutputStream oos = new ObjectOutputStream(fos);
        ) {
            oos.writeObject(list);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void readOp(File file) {
        try (
                FileInputStream fis = new FileInputStream(file);
                ObjectInputStream ois = new ObjectInputStream(fis);
        ) {
            ArrayList<Animal> list = (ArrayList<Animal>) ois.readObject();
            for (Animal animal : list)
                System.out.println(animal);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
class Animal implements Serializable {
    static final long serialVersionUID = 41424212566234L;
    private int id;
    private String name;
    public Animal() {
    }
    public Animal(int id, String name) {
        this.id = id;
        this.name = name;
    }
    @Override
    public String toString() {
        return "Animal{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
```

## 8. 其他流的使用

### 8.1 标准输入、输出流

System.in和System.out分别代表了系统标准的输入和输出设备，默认输入设备是：键盘，输出设备是：显示器。System.in的类型是InputStream，而System.out的类型是PrintStream。

**重定向**：通过System类的setIn，setOut方法对默认设备进行改变。
  - `public static void setIn(InputStream in)`
  - `public static void setOut(PrintStream out)`

注意：在System类中`public static final InputStream in = null; public static final PrintStream out = null; public static final PrintStream err = null;`都声明为全局常量null。final声明的常量，表示在Java的语法体系中它们的值是不能修改的。但这三个常量对象的值是由C/C++等系统函数进行初始化和修改值的，所以它们故意没有用大写，我们也可以用setIn()、setOut()等方法重定向。

**举例**：从键盘输入字符串，要求将读取到的整行字符串转成大写输出。然后继续进行输入操作，直至当输入“e”或者“exit”时，退出程序。

```java
@Test
public void test1() {
    try(
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
            ) {
        String str = null;
        while ((str = br.readLine()) != null) {
            if ("e".equalsIgnoreCase(str) || "exit".equalsIgnoreCase(str))
                break;
            System.out.println(str.toUpperCase());
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
```

### 8.2 打印流

打印流可以实现更方便、更高效的打印数据出去。打印流：`PrintStream`和`PrintWriter`功能类似，都提供了一系列重载的`print()`和`println()`方法，用于多种数据类型的输出。

- PrintStream和PrintWriter的输出不会抛出IOException异常
- PrintStream和PrintWriter有自动flush功能
- PrintStream 打印的所有字符都使用平台的默认字符编码转换为字节。在需要写入字符而不是写入字节的情况下，应该使用PrintWriter类。
- System.out返回的是PrintStream的实例

**构造器**

- `PrintStream(File file)`：创建具有指定文件且不带自动行刷新的新打印流。 
- `PrintStream(File file, String csn)`：创建具有指定文件名称和字符集且不带自动行刷新的新打印流。 
- `PrintStream(OutputStream out)`：创建新的打印流。 
- `PrintStream(OutputStream out, boolean autoFlush)`：创建新的打印流。autoFlush如果为true，则每当写入byte数组、调用其中一个println方法或写入换行符或字节(`'\n'`)时都会刷新输出缓冲区。
- `PrintStream(OutputStream out, boolean autoFlush, String encoding)`：创建新的打印流。 
- `PrintStream(String fileName)`：创建具有指定文件名称且不带自动行刷新的新打印流。 
- `PrintStream(String fileName, String csn)`：创建具有指定文件名称和字符集且不带自动行刷新的新打印流。

**举例**：使用打印流输出内容到文件

```java
public class MyTest {
    public static void main(String[] args) {
    }
    @Test
    public void test1() {
        File file = new File("IOtest/hello.txt");
        method1(file);
        method2(file);
    }
    // 方式1：直接创建打印流输出到目标文件
    public void method1(File file) {
        try (
                PrintStream ps = new PrintStream(file);
                ) {
            for (int i = 0; i < 10; i++)
                ps.println(i);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    // 方式2：将标准输出流重定向到目标文件
    public void method2(File file) {
        try (
                FileOutputStream fos = new FileOutputStream(file, true); // 可以设置追加
                PrintStream ps = new PrintStream(fos);
                ) {
            System.setOut(ps); // 重定向
            for (int i = 0; i < 10; i++)
                System.out.println(i);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

### 8.3 Scanner类

构造方法

* `Scanner(File source)`：构造一个新的 Scanner，它生成的值是从指定文件扫描的。 
* `Scanner(File source, String charsetName)`：构造一个新的 Scanner，它生成的值是从指定文件扫描的。 
* `Scanner(InputStream source)`：构造一个新的 Scanner，它生成的值是从指定的输入流扫描的。 
* `Scanner(InputStream source, String charsetName)`：构造一个新的 Scanner，它生成的值是从指定的输入流扫描的。

常用方法：

* `boolean hasNextXxx()`：如果通过使用nextXxx()方法，此扫描器输入信息中的下一个标记可以解释为默认基数中的一个 Xxx 值，则返回 true。
* `Xxx nextXxx()`：将输入信息的下一个标记扫描为一个Xxx

## 9. IO框架

### 9.1 介绍

框架：为了解决某类问题而编写的一套类、接口等。框架的形式：一般是把类、接口等编译成class形式，再压缩成一个.jar结尾的文件发行出去。好处：在框架的基础上开发，可以得到优秀的软件架构，并能提高开发效率。

**由apache开源基金组织提供了一组有关IO流小框架，可以提高IO流的开发效率**。这个框架的名字叫commons-io：其本质是别人写好的一些字节码文件（class文件），打包成了一个jar包。我们只需要把jar包引入到我们的项目中，就可以直接用了。 

### 9.2 导入框架

在写代码之前，先需要引入jar包，具体步骤如下：

1. 在模块的目录下，新建一个lib文件夹
2. 把commons-io-2.13.0.jar文件复制到lib文件夹下
3. 选择lib下的jar文件，右键点击Add As Library
4. 在类中导包使用

### 9.3 Commons-io的部分API

![](/zzimages/1667925627850.png)

```java
public class CommonsIOTest1 {
    public static void main(String[] args) throws Exception {
        //1.复制文件
        FileUtils.copyFile(new File("io-app2\\src\\itheima01.txt"), new File("io-app2/src/a.txt"));
        
        //2.复制文件夹
        FileUtils.copyDirectory(new File("D:\\resource\\私人珍藏"), new File("D:\\resource\\私人珍藏3"));
        
        //3.删除文件夹
        FileUtils.deleteDirectory(new File("D:\\resource\\私人珍藏3"));

        // Java提供的原生的一行代码搞定很多事情
         Files.copy(Path.of("io-app2\\src\\itheima01.txt"), Path.of("io-app2\\src\\b.txt"));
        System.out.println(Files.readString(Path.of("io-app2\\src\\itheima01.txt")));
    }
}
```

## 10. xml文件

### 10.1 XML文件概述

XML是可扩展的标记语言(全称EXtensible Markup Language)。本质上一种数据格式，可以用来表示复杂的数据关系。应用场景：xml文件经常用来做为系统的配置文件；或者作为一种特殊的数据结构，在网络中进行传输(现在以JSON为主)。

XML文件有如下的特点：

- XML中的`<标签名>` 称为一个标签或者一个元素，一般是成对出现的。
- XML中的标签名可以自己定义（可扩展），但是必须要正确的嵌套
- XML中只能有一个根标签。
- XML标签中可以有属性，属性的值必须使用 `""` 引起来
- XML必须第一行有一个文档声明，格式是固定的`<?xml version="1.0" encoding="UTF-8"?>`
- XML文件必须是以.xml为后缀结尾

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!-- 注释：以上抬头声明必须放在第一行，必须有 -->
<!--  根标签只能有一个 -->
<users>
    <user id="1" desc="第一个用户">
        <name>张无忌</name>
        <sex>男</sex>
        <地址>光明顶</地址>
        <password>minmin</password>
    </user>
    <people>很多人</people>
    <user id="2">
        <name>敏敏</name>
        <sex>女</sex>
        <地址>光明顶</地址>
        <password>wuji</password>
    </user>
</users>
```

说明：

- xml中的注释格式：`<!–- 注释内容 -->`
- 如果标签文本中有以下特殊字符，需要用一些占位符代替。

  ```txt
  &lt;  表示 <
  &gt;  表示 >
  &amp; 表示 &
  &apos; 表示 '
  &quot; 表示 "
  ```
- 如果在标签文本中，出现大量的特殊字符，不想使用特殊字符，此时可以用CDATA区，格式如下

  ```xml
  <data1>
      <![CDATA[
     		3 < 2 && 5 > 4
      ]]>
  </data1>
  ```

### 10.2 XML解析

使用程序读取XML文件中的数据，称之为XML解析。一般用第三方的XML解析框架DOM4J来进行XML解析。

首先引入jar包，具体步骤如下：

1. 在模块的目录下，新建一个lib文件夹
2. 把dom4j-2.1.3.jar文件复制到lib文件夹下
3. 选择lib下的jar文件，右键点击Add As Library
4. 在类中导包使用


DOM4J解析XML文件的思想：**文档对象模型**（意思是把整个XML文档、每一个标签、每一个属性都等都当做对象来看待）。Document对象表示真个XML文档、Element对象表示标签（元素）、Attribute对象表示属性、标签中的内容就是文本

**XML解析的过程，是从根元素开始，从外层往里层解析**。

**1、SAXReader**

SAXReader是Dom4j提供的解析器，可以认为是代表整个Dom4j框架，它提供以下构造器/方法：

- `public SAXReader()`：构建Dom4j的解析器对象
- `public Document read(String url)`：把XML文件读成Document对象
- `public Document read(InputStream is)`：通过字节输入流读取XML文件

**2、Document**

Document提供以下方法获取根元素对象：

- `Element getRootElement()`

**3、Element**

通过Element就可以获取一些属性或者文本：

- `public String getName()`：得到元素名字
- `public List<Element> elements()`：得到当前元素下的所有子元素
- `public List<Element> elements(String name)`：得到当前元素下指定名字的子元素
- `public Element element(String name)`：得到当前元素下指定名字的子元素(有多个同名子元素，默认返回第一个)
- `public String attributeValue(String name)`：通过属性名直接得到属性值
- `public String elementText(String name)`：得到指定名称的子元素的文本内容
- `public String getText()`：得到文本内容

```java
public class Dom4JTest1 {
    public static void main(String[] args) throws Exception {
        // 1、创建一个Dom4J框架提供的解析器对象
        SAXReader saxReader = new SAXReader();

        // 2、使用saxReader对象把需要解析的XML文件读成一个Document对象。
        Document document =
                saxReader.read("properties-xml-log-app\\src\\helloworld.xml");

        // 3、从文档对象中解析XML文件的全部数据了
        Element root = document.getRootElement();
        System.out.println(root.getName());

        // 4、获取根元素下的全部一级子元素。
        // List<Element> elements = root.elements();
        List<Element> elements = root.elements("user");
        for (Element element : elements) {
            System.out.println(element.getName());
        }

        // 5、获取当前元素下的某个子元素。
        Element people = root.element("people");
        System.out.println(people.getText());

        // 如果下面有很多子元素user，默认获取第一个。
        Element user = root.element("user");
        System.out.println(user.elementText("name"));

        // 6、获取元素的属性信息呢？
        System.out.println(user.attributeValue("id"));
        Attribute id = user.attribute("id");
        System.out.println(id.getName());
        System.out.println(id.getValue());

        List<Attribute> attributes = user.attributes();
        for (Attribute attribute : attributes) {
            System.out.println(attribute.getName() + "=" + attribute.getValue());
        }

        // 7、如何获取全部的文本内容:获取当前元素下的子元素文本值
        System.out.println(user.elementText("name"));
        System.out.println(user.elementText("地址"));
        System.out.println(user.elementTextTrim("地址")); // 取出文本去除前后空格
        System.out.println(user.elementText("password"));

        Element data = user.element("data");
        System.out.println(data.getText());
        System.out.println(data.getTextTrim()); // 取出文本去除前后空格
    }
}
```

### 10.3 XML文件写入（了解）

事实上现在很少用程序去写入XML文件。如果一定要通过程序的方式写XML文件，建议不要使用DOM4J(因为很繁琐)，而是使用StringBuilder按照标签的格式拼接，然后再使用BufferedWriter写到XML文件中去就可以了。

### 10.4 XML约束

XML约束指的是限制XML文件中的标签或者属性，只能按照规定的格式写。

约束文档：专门用来限制xml书写格式的文档，比如：限制标签、属性应该怎么写。约束文档分为两类：DTD文档、Schema文档。

#### 1、DTD文档

将来在IDEA中有代码提示的协助，在DTD文档的约束下进行配置非常简单。

#### 2、Schema文档

我们将来使用SSM框架中的Spring、SpringMVC框架时，会涉及到一点点对Schema约束的设置。

首先我们要理解一个概念：名称空间(name space)。Schema约束要求我们一个XML文档中，所有标签，所有属性都必须在约束中有明确的定义。

下面我们以web.xml的约束声明为例来做个说明：

```xml
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
```

|属性名|	作用|
|---|---|
|xmlns|	指出当前XML文档约束规则的名称空间在哪里，我们就是通过这个属性来引用一个具体的名称空间|
|xmlns:xsi|	指出xmlns这个属性是在哪个约束文档中被定义的|
|xsi:schemaLocation|	语法格式：在xsi名称空间下引用schemaLocation属性。配置含义：指定当前XML文档中所用到的约束文档本身的文件的地址|

## 11. 日志技术

### 11.1 日志概述

程序中的日志，通常就是一个文件，里面记录了程序运行过程中产生的各种数据。日志技术有如下好处：

1. 日志可以将系统执行的信息，方便的记录到指定位置，可以是控制台、可以是文件、可以是数据库中。
2. 日志可以随时以开关的形式控制启停，无需侵入到源代码中去修改。

### 11.2 日志的体系

日志框架：第三方公司已经做好的实现代码，后来者直接可以拿去使用。常见的日志框架有JUL（java.util.logging）、Log4j、Logback等。

日志接口：设计日志框架的一套标准，日志框架需要实现这些接口。日志接口有JCL和SLF4J。

我们用的最多的是Logback日志框架，它是基于SLF4J的日志接口实现的框架。

**Logback日志分为哪几个模块**

1. logback-core: 基础模块，是其他两个模块依赖的基础(必须有)
2. logback-classic: 完整实现了slf4j API的模块(必须有)
3. logback-access: 与Tomcat和Jetty等Servlet容器集成，以提供HTTP访问日志的功能(可选)

所以，想要使用Logback日志框架，至少需要在项目中整合如下三个jar包：

- slf4j-api-1.7.26.jar(日志接口)
- logback-core-1.2.3.jar
- logback-classic-1.2.3.jar

除此之外，还需要将`logback.xml`配置文件添加到src目录下(必须是src目录下)

### 11.3 Logback快速入门

```java
public class LogBackTest {
    // 创建一个Logger日志对象
    public static final Logger LOGGER = LoggerFactory.getLogger("LogBackTest");
    public static void main(String[] args) {
        try {
            LOGGER.info("chu方法开始执行");
            chu(10, 0);
            LOGGER.info("chu方法执行成功");
        } catch (Exception e) {
            LOGGER.error("chu方法执行失败，出现了BUG");
        }
    }
    public static void chu(int a, int b) {
        LOGGER.debug("参数a：" + a);
        LOGGER.debug("参数b：" + b);
        int c = a / b;
        LOGGER.info("结果是c：" + c);
    }
}
```

当我们运行程序时，就可以看到控制台记录的日志

```
2023-07-30 11:41:39.965 [INFO ]  LogBackTest [main] : chu方法开始执行
2023-07-30 11:41:39.970 [DEBUG]  LogBackTest [main] : 参数a：10
2023-07-30 11:41:39.971 [DEBUG]  LogBackTest [main] : 参数b：0
2023-07-30 11:41:39.971 [ERROR]  LogBackTest [main] : chu方法执行失败，出现了BUG
```

同时在`D盘的log文件夹下`也有一个日志文件来保存这些日志信息。

### 11.4 日志配置文件

Logback提供了一个核心配置文件logback.xml，日志框架在记录日志时会读取配置文件中的配置信息，从而记录日志的形式。具体可以做以下配置：

```java
1. 可以配置日志输出的位置是文件、还是控制台
2. 可以配置日志输出的格式
3. 还可以配置日志关闭和开启、以及哪些日志输出哪些日志不输出。
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <!--
        CONSOLE ：表示当前的日志信息是可以输出到控制台的。
    -->
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <!--输出流对象 默认 System.out 改为 System.err-->
        <target>System.out</target>
        <encoder>
            <!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度
                %msg：日志消息，%n是换行符-->
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%-5level]  %c [%thread] : %msg%n</pattern>
        </encoder>
    </appender>

    <!-- File是输出的方向通向文件的 -->
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
            <charset>utf-8</charset>
        </encoder>
        <!--日志输出路径-->
        <file>D:/log/thuwsy-data.log</file>
        <!--指定日志文件拆分和压缩规则-->
        <rollingPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <!--通过指定压缩文件名称，来确定分割文件方式-->
            <fileNamePattern>D:/log/thuwsy-data-%i-%d{yyyy-MM-dd}-.log.gz</fileNamePattern>
            <!--文件拆分大小-->
            <maxFileSize>1MB</maxFileSize>
        </rollingPolicy>
    </appender>

    <!--
        1、控制日志的输出情况：如，开启日志，取消日志
    -->
    <root level="debug">
        <appender-ref ref="CONSOLE"/>
        <appender-ref ref="FILE" />
    </root>
</configuration>
```

### 11.5 配置日志级别

![](/zzimages/1668046420402.png)

我们可以在logback.xml文件中的`<root level="xxx">`中配置日志级别level

- Logback只输出大于或者等于核心配置文件配置的日志级别信息。小于配置级别的日志信息，不被记录。

```java
配置的是debug，则debug、info、warn、error级别的日志被输出
配置的是info，则info、warn、error级别的日志被输出
```


# 第16章_网络编程

## 1. 网络编程概述

Java是 Internet 上的语言，它从语言级上提供了对网络应用程序的支持，程序员能够很容易开发常见的网络应用程序。

Java提供的网络类库，可以实现无痛的网络连接，联网的底层细节被隐藏在 Java 的本机安装系统里，由 JVM 进行控制。并且 Java 实现了一个跨平台的网络库，`程序员面对的是一个统一的网络编程环境`。

### 1.1 软件架构

**C/S架构** ：全称为Client/Server结构，是指客户端和服务器结构。常见程序有QQ、美团app、360安全卫士等软件。

**B/S架构** ：全称为Browser/Server结构，是指浏览器和服务器结构。常见浏览器有IE、谷歌、火狐等。

两种架构各有优势，但是无论哪种架构，都离不开网络的支持。**网络编程**，就是在一定的协议下，实现两台计算机的通信的程序。

### 1.2 网络基础

#### 1.2.1 IP地址

**常用命令：**

- 查看本机IP地址，在控制台输入：

```shell
ipconfig
```

- 检查网络是否连通，在控制台输入：

```shell
ping 空格 IP地址
ping 220.181.57.216
```

**特殊的IP地址：**

- 本地回环地址(hostAddress)：`127.0.0.1`  
- 主机名(hostName)：`localhost`

#### 1.2.2 端口号

如果说**IP地址**可以唯一标识网络中的设备，那么**端口号**就可以唯一标识设备中的进程（应用程序）。

不同的进程，设置不同的端口号。**端口号：用两个字节表示的整数，它的取值范围是0~65535**。
- 公认端口：0~1023。被预先定义的服务通信占用，如：HTTP（80），FTP（21），Telnet（23）
- 注册端口：1024~49151。分配给用户进程或应用程序。如：Tomcat（8080），MySQL（3306），Oracle（1521）。
- 动态/ 私有端口：49152~65535。

如果端口号被另外一个服务或应用所占用，会导致当前程序启动失败。

#### 1.2.3 TCP协议与UDP协议

通信的协议还是比较复杂的，`java.net` 包中包含的类和接口，它们提供低层次的通信细节。我们可以直接使用这些类和接口，来专注于网络程序开发，而不用考虑通信的细节。

`java.net` 包中提供了两种常见的网络协议的支持：

- **UDP**：用户数据报协议(User Datagram Protocol)。
- **TCP**：传输控制协议 (Transmission Control Protocol)。

**TCP协议：**

- TCP协议进行通信的两个应用进程：客户端、服务端。
- 使用TCP协议前，须先`建立TCP连接`，形成基于字节流的传输数据通道
- 传输前，采用“三次握手”方式，点对点通信，是`可靠的`
  - TCP协议使用`重发机制`，当一个通信实体发送一个消息给另一个通信实体后，需要收到另一个通信实体确认信息，如果没有收到另一个通信实体确认信息，则会再次重复刚才发送的消息。
- 在连接中可进行`大数据量的传输`
- 传输完毕，需`释放已建立的连接，效率低`

**UDP协议：**

- UDP协议进行通信的两个应用进程：发送端、接收端。
- 将数据、源、目的封装成数据包（传输的基本单位），`不需要建立连接`
- 发送不管对方是否准备好，接收方收到也不确认，不能保证数据的完整性，故是`不可靠的`
- 每个数据报的大小限制在`64K`内
- 发送数据结束时`无需释放资源，开销小，通信效率高`
- 适用场景：音频、视频和普通数据的传输。例如视频会议


## 2. 网络编程API

### 2.1 InetAddress类

InetAddress类主要表示IP地址，有两个子类：Inet4Address、Inet6Address。

InetAddress 类没有提供公共的构造器，而是提供了如下几个静态方法来获取InetAddress实例

* `public static InetAddress getLocalHost()`
* `public static InetAddress getByName(String host)`：参数传递的字符串可以是IP地址，也可以是域名
* `public static InetAddress getByAddress(byte[] addr)`

InetAddress 提供了如下几个常用的方法

* `public String getHostAddress()`：返回 IP 地址字符串（以文本表现形式）
* `public String getHostName()`：获取此 IP 地址的主机名
* `public boolean isReachable(int timeout)`：测试是否可以达到该地址

### 2.2 Socket类

-  网络上具有唯一标识的IP地址和端口号组合在一起构成唯一能识别的标识符套接字（Socket）。
-  利用套接字(Socket)开发网络应用程序早已被广泛的采用，以至于成为事实上的标准。网络通信其实就是Socket间的通信。
- 通信的两端都要有Socket，是两台机器间通信的端点。
- Socket允许程序把网络连接当成一个流，数据在两个Socket间通过IO传输。
- 一般主动发起通信的应用程序属客户端，等待通信请求的为服务端。
- Socket分类：
  - 流套接字（stream socket）：使用TCP提供可依赖的字节流服务
    - ServerSocket：此类实现TCP服务器套接字。服务器套接字等待请求通过网络传入。
    - Socket：此类实现客户端套接字（也可以就叫“套接字”）。套接字是两台机器间通信的端点。
  - 数据报套接字（datagram socket）：使用UDP提供“尽力而为”的数据报服务
    - DatagramSocket：此类表示用来发送和接收UDP数据报包的套接字。 

### 2.3 Socket相关类API

#### 2.3.1 ServerSocket类

**ServerSocket类的构造方法：**

* ServerSocket(int port) ：创建绑定到特定端口的服务器套接字。

**ServerSocket类的常用方法：**

* Socket accept()：侦听并接受到此套接字的连接。 

#### 2.3.2 Socket类

**Socket类的常用构造方法**：

* public Socket(InetAddress address,int port)：创建一个流套接字并将其连接到指定 IP 地址的指定端口号。
* public Socket(String host,int port)：创建一个流套接字并将其连接到指定主机上的指定端口号。

**Socket类的常用方法**：

* public InputStream getInputStream()：返回此套接字的输入流，可以用于接收消息
* public OutputStream getOutputStream()：返回此套接字的输出流，可以用于发送消息
* public InetAddress getInetAddress()：此套接字连接到的远程 IP 地址；如果套接字是未连接的，则返回 null。
* public InetAddress getLocalAddress()：获取套接字绑定的本地地址。
* public int getPort()：此套接字连接到的远程端口号；如果尚未连接套接字，则返回 0。
* public int getLocalPort()：返回此套接字绑定到的本地端口。如果尚未绑定套接字，则返回 -1。
* public void close()：关闭此套接字。套接字被关闭后，便不可在以后的网络连接中使用（即无法重新连接或重新绑定）。需要创建新的套接字对象。 关闭此套接字也将会关闭该套接字的 InputStream 和 OutputStream。 
* public void shutdownInput()：如果在套接字上调用 shutdownInput() 后从套接字输入流读取内容，则流将返回 EOF（文件结束符）。 即不能在从此套接字的输入流中接收任何数据。
* public void shutdownOutput()：禁用此套接字的输出流。对于 TCP 套接字，任何以前写入的数据都将被发送，并且后跟 TCP 的正常连接终止序列。 如果在套接字上调用 shutdownOutput() 后写入套接字输出流，则该流将抛出 IOException。 即不能通过此套接字的输出流发送任何数据。

**注意：**先后调用Socket的shutdownInput()和shutdownOutput()方法，仅仅关闭了输入流和输出流，并不等于调用Socket的close()方法。在通信结束后，仍然要调用Scoket的close()方法，因为只有该方法才会释放Socket占用的资源，比如占用的本地端口号等。

#### 2.3.3 DatagramSocket类

**DatagramSocket 类的常用方法：**

* public DatagramSocket(int port)创建数据报套接字并将其绑定到本地主机上的指定端口。套接字将被绑定到通配符地址，IP 地址由内核来选择。
* public DatagramSocket(int port,InetAddress laddr)创建数据报套接字，将其绑定到指定的本地地址。本地端口必须在 0 到 65535 之间（包括两者）。如果 IP 地址为 0.0.0.0，套接字将被绑定到通配符地址，IP 地址由内核选择。 
* public void close()关闭此数据报套接字。 
* public void send(DatagramPacket p)从此套接字发送数据报包。DatagramPacket 包含的信息指示：将要发送的数据、其长度、远程主机的 IP 地址和远程主机的端口号。 
* public void receive(DatagramPacket p)从此套接字接收数据报包。当此方法返回时，DatagramPacket 的缓冲区填充了接收的数据。数据报包也包含发送方的 IP 地址和发送方机器上的端口号。 此方法在接收到数据报前一直阻塞。数据报包对象的 length 字段包含所接收信息的长度。如果信息比包的长度长，该信息将被截短。 
* public InetAddress getLocalAddress()获取套接字绑定的本地地址。
* public int getLocalPort()返回此套接字绑定的本地主机上的端口号。 
* public InetAddress getInetAddress()返回此套接字连接的地址。如果套接字未连接，则返回 null。
* public int getPort()返回此套接字的端口。如果套接字未连接，则返回 -1。

#### 2.3.4 DatagramPacket类

**DatagramPacket类的常用方法：**

* public DatagramPacket(byte[] buf,int length)构造 DatagramPacket，用来接收长度为 length 的数据包。 length 参数必须小于等于 buf.length。
* public DatagramPacket(byte[] buf,int length,InetAddress address,int port)构造数据报包，用来将长度为 length 的包发送到指定主机上的指定端口号。length 参数必须小于等于 buf.length。
* public InetAddress getAddress()返回某台机器的 IP 地址，此数据报将要发往该机器或者是从该机器接收到的。
* public int getPort()返回某台远程主机的端口号，此数据报将要发往该主机或者是从该主机接收到的。
* `public byte[] getData()`返回数据缓冲区。接收到的或将要发送的数据从缓冲区中的偏移量 offset 处开始，持续 length 长度。
* `public int getLength()`返回将要发送或接收到的数据的长度。

## 3. TCP网络编程

### 3.1 通信模型

Java语言的基于套接字TCP编程分为服务端编程和客户端编程，其通信模型如图所示：

![](/zzimages/image-20220514172833216.png)

### 3.2 开发步骤

**客户端程序包含以下四个基本的步骤 ：**

* 创建 Socket ：根据指定服务端的 IP 地址或端口号构造 Socket 类对象。若服务器端响应，则建立客户端到服务器的通信线路。若连接失败，会出现异常。
* 打开连接到 Socket  的输入/ 出流： 使用 getInputStream()方法获得输入流，使用getOutputStream()方法获得输出流，进行数据传输
* 按照一定的协议对 Socket 进行读/ 写操作：通过输入流读取服务器放入线路的信息（但不能读取自己放入线路的信息），通过输出流将信息写入线路。
* 关闭 Socket ：断开客户端到服务器的连接，释放线路

**服务器端程序包含以下四个基本的步骤：**

* 调用 ServerSocket(int port) ：创建一个服务器端套接字，并绑定到指定端口上。用于监听客户端的请求。
* 调用 accept() ：监听连接请求，如果客户端请求连接，则接受连接，返回通信套接字对象。
* 调用该Socket类对象的getOutputStream()和getInputStream ()：获取输出流和输入流，开始网络数据的发送和接收。
* 关闭Socket 对象：客户端访问结束，关闭通信套接字。

### 3.3 例题

例题1：客户端发送内容给服务端，服务端将内容打印到控制台上。

```java
@Test
public void client() {
    // 1. 创建一个Socket
    InetAddress inetAddress = null; // 服务端的ip地址
    int port = 8989; // 客户端的端口号
    try {
        inetAddress = InetAddress.getByName("192.168.0.10");
    } catch (UnknownHostException e) {
        e.printStackTrace();
    }

    try (
            Socket socket = new Socket(inetAddress, port);
            ) {
        OutputStream os = socket.getOutputStream();
        // 2. 发送数据
        os.write("你好，我是客户端".getBytes());
    } catch (IOException e) {
        e.printStackTrace();
    }

    // 3. 关闭Socket、关闭流，由try-with-resource自动调用close()
}

@Test
public void server() {
    // 1. 创建一个ServerSocket
    int port = 8989;
    try (
            ServerSocket serverSocket = new ServerSocket(port);
            // 为防止乱码，将读到的字节全部存放到一个字节数组流中
            ByteArrayOutputStream baos = new ByteArrayOutputStream(); // 内部维护了一个byte[]数组
            ) {
        // 2. 调用accept()，接收客户端的Socket
        Socket socket = serverSocket.accept(); // 阻塞式的方法
        System.out.println("服务器端收到了来自" +
                socket.getInetAddress().getHostAddress() + "的连接");

        // 3. 接收数据
        InputStream is = socket.getInputStream();
        byte[] buffer = new byte[5];
        int len = 0;
        while ((len = is.read(buffer)) != -1) {
            baos.write(buffer, 0, len);
        }
        System.out.println(baos);
    } catch (IOException e) {
        e.printStackTrace();
    }
    // 4. 关闭Socket、ServerSocket、流
}
```

例题2：客户端发送文件给服务端，服务端将文件存到本地，并返回"发送成功"给客户端。

```java
@Test
public void client() throws IOException {
    // 1. 创建一个Socket
    InetAddress inetAddress = InetAddress.getByName("192.168.0.10"); // 服务端的ip地址
    int port = 9989; // 客户端的端口号
    Socket socket = new Socket(inetAddress, port);

    // 2. 发送数据
    FileInputStream fis = new FileInputStream("IOtest/picture.png");
    OutputStream os = socket.getOutputStream();

    byte[] buffer = new byte[1024];
    int len = 0;
    while ((len = fis.read(buffer)) != -1) {
        os.write(buffer, 0, len);
    }
    // 客户端表明自己不再发送数据
    socket.shutdownOutput();

    // 3. 接收数据
    InputStream is = socket.getInputStream();
    ByteArrayOutputStream baos = new ByteArrayOutputStream();

    while ((len = is.read(buffer)) != -1) {
        baos.write(buffer, 0, len);
    }
    System.out.println(baos);

    // 4. 关闭Socket、关闭流
    baos.close();
    is.close();
    os.close();
    fis.close();
    socket.close();
}

@Test
public void server() throws IOException {
    // 1. 创建一个ServerSocket
    int port = 9989;
    ServerSocket serverSocket = new ServerSocket(port);

    // 2. 调用accept()，接收客户端的Socket
    Socket socket = serverSocket.accept(); // 阻塞式的方法
    System.out.println("服务器端收到了来自" +
            socket.getInetAddress().getHostAddress() + "的连接");

    // 3. 接收数据
    FileOutputStream fos = new FileOutputStream("IOtest/pic_server.png");
    InputStream is = socket.getInputStream();
    byte[] buffer = new byte[5];
    int len = 0;
    while ((len = is.read(buffer)) != -1) {
        fos.write(buffer, 0, len);
    }

    // 4. 发送数据
    OutputStream os = socket.getOutputStream();
    os.write("发送成功".getBytes());

    // 5. 关闭Socket、ServerSocket、流
    os.close();
    is.close();
    fos.close();
    socket.close();
    serverSocket.close();
}
```






## 4. UDP网络编程

UDP(User Datagram Protocol，用户数据报协议)：是一个无连接的传输层协议、提供面向事务的简单不可靠的信息传送服务，类似于短信。

### 4.1 通信模型

UDP协议是一种**面向非连接**的协议，面向非连接指的是在正式通信前不必与对方先建立连接，不管对方状态就直接发送，至于对方是否可以接收到这些数据内容，UDP协议无法控制，因此说，UDP协议是一种**不可靠的**协议。无连接的好处就是快，省内存空间和流量，因为维护连接需要创建大量的数据结构。UDP会尽最大努力交付数据，但不保证可靠交付，没有TCP的确认机制、重传机制，如果因为网络原因没有传送到对端，UDP也不会给应用层返回错误信息。

UDP协议是面向数据报文的信息传送服务。UDP在发送端没有缓冲区，对于应用层交付下来的报文在添加了首部之后就直接交付于ip层，不会进行合并，也不会进行拆分，而是一次交付一个完整的报文。比如我们要发送100个字节的报文，我们调用一次send()方法就会发送100字节，接收方也需要用receive()方法一次性接收100字节，不能使用循环每次获取10个字节，获取十次这样的做法。

UDP协议没有拥塞控制，所以当网络出现的拥塞不会导致主机发送数据的速率降低。虽然UDP的接收端有缓冲区，但是这个缓冲区只负责接收，并不会保证UDP报文的到达顺序是否和发送的顺序一致。因为网络传输的时候，由于网络拥塞的存在是很大的可能导致先发的报文比后发的报文晚到达。如果此时缓冲区满了，后面到达的报文将直接被丢弃。这个对实时应用来说很重要，比如：视频通话、直播等应用。

因此UDP适用于一次只传送少量数据、对可靠性要求不高的应用环境，数据报大小限制在64K以下。

类 DatagramSocket 和 DatagramPacket 实现了基于 UDP 协议网络程序。

UDP数据报通过数据报套接字 DatagramSocket 发送和接收，系统不保证  UDP数据报一定能够安全送到目的地，也不能确定什么时候可以抵达。

DatagramPacket 对象封装了UDP数据报，在数据报中包含了发送端的IP地址和端口号以及接收端的IP地址和端口号。

UDP协议中每个数据报都给出了完整的地址信息，因此无须建立发送方和接收方的连接。如同发快递包裹一样。

### 4.2 开发步骤

**发送端程序包含以下四个基本的步骤：**

* 创建DatagramSocket ：默认使用系统随机分配端口号。
* 创建DatagramPacket：将要发送的数据用字节数组表示，并指定要发送的数据长度，接收方的IP地址和端口号。
* 调用该DatagramSocket 类对象的 send方法 ：发送数据报DatagramPacket对象。
* 关闭DatagramSocket 对象：发送端程序结束，关闭通信套接字。

**接收端程序包含以下四个基本的步骤 ：**

* 创建DatagramSocket ：指定监听的端口号。
* 创建DatagramPacket：指定接收数据用的字节数组，起到临时数据缓冲区的效果，并指定最大可以接收的数据长度。
* 调用该DatagramSocket 类对象的receive方法 ：接收数据报DatagramPacket对象。。
* 关闭DatagramSocket ：接收端程序结束，关闭通信套接字。

### 4.3 演示发送和接收消息

基于UDP协议的网络编程仍然需要在通信实例的两端各建立一个Socket，但这两个Socket之间并没有虚拟链路，这两个Socket只是发送、接收数据报的对象，Java提供了DatagramSocket对象作为基于UDP协议的Socket，使用DatagramPacket代表DatagramSocket发送、接收的数据报。

举例：UDP通信示例

```java
@Test
public void sender() throws IOException{
    // 1. 创建DatagramSocket实例
    DatagramSocket ds = new DatagramSocket();

    // 2. 将数据、目的ip、目的端口号都封装在DatagramPacket数据报中
    InetAddress inetAddress = InetAddress.getByName("127.0.0.1");
    int port = 9090;
    byte[] bytes = "我是发送端".getBytes("utf-8");
    DatagramPacket packet = new DatagramPacket(bytes, 0, bytes.length, inetAddress, port);

    // 3. 发送数据
    ds.send(packet);
    // 4. 关闭socket
    ds.close();
}
@Test
public void receiver() throws IOException{
    // 1. 创建DatagramSocket实例
    int port = 9090;
    DatagramSocket ds = new DatagramSocket(port);

    // 2. 创建数据报的对象，用于接收发送端发送过来的数据
    byte[] buffer = new byte[1024 * 64];
    DatagramPacket packet = new DatagramPacket(buffer, 0, buffer.length);

    // 3. 接收数据
    ds.receive(packet);

    // 4. 获取数据，并打印到控制台上
    String str = new String(packet.getData(), 0, packet.getLength());
    System.out.println(str);

    // 5. 关闭socket
    ds.close();
}
```



## 5. URL编程

### 5.1 URL类

URL(Uniform Resource Locator)：统一资源定位符，它表示 Internet 上某一资源的地址。

URL的基本结构由5部分组成：

```http
<传输协议>://<主机名>:<端口号>/<文件名>#片段名?参数列表
```


为了表示URL，`java.net` 中实现了类 URL。我们可以通过下面的构造器来初始化一个 URL 对象：

  - `public URL (String spec)`：通过一个表示URL地址的字符串可以构造一个URL对象。例如：

    ```http
    URL url = new URL("http://www. atguigu.com/"); 
    ```

  - `public URL(URL context, String spec)`：通过基 URL 和相对 URL 构造一个 URL 对象。例如：

    ```http
    URL downloadUrl = new URL(url, “download.html")
    ```

  - `public URL(String protocol, String host, String file);` 例如：

    ```http
    URL url = new URL("http", "www.atguigu.com", “download. html");
    ```

  - `public URL(String protocol, String host, int port, String file);` 例如: 

    ```java
    URL gamelan = new URL("http", "www.atguigu.com", 80, "download.html");
    ```

URL类的构造器都声明抛出非运行时异常，必须要对这一异常进行处理，通常是用 try-catch 语句进行捕获。

### 5.2 URL类常用方法

一个URL对象生成后，其属性是不能被改变的，但可以通过它给定的方法来获取这些属性：

- public String getProtocol( )   获取该URL的协议名

- public String getHost( )      获取该URL的主机名

- public String getPort( )      获取该URL的端口号

- public String getPath( )      获取该URL的文件路径

- public String getFile( )       获取该URL的文件名

- public String getQuery(  )    获取该URL的查询名

```java
String str = "http://localhost:8080/demo/测试.html?name=Tom";

try {
    URL url = new URL(str);
    System.out.println(url.getProtocol());
    System.out.println(url.getHost());
    System.out.println(url.getPort());
    System.out.println(url.getPath());
    System.out.println(url.getFile());
    System.out.println(url.getQuery());
} catch (MalformedURLException e) {
    e.printStackTrace();
}
```

### 5.3 针对HTTP协议的URLConnection类

- URL的方法 openStream()：能从网络上读取数据
- 若希望输出数据，例如向服务器端的 CGI （公共网关接口-Common Gateway Interface-的简称，是用户浏览器和服务器端的应用程序进行连接的接口）程序发送一些数据，则必须先与URL建立连接，然后才能对其进行读写，此时需要使用 URLConnection 。
- URLConnection：表示到URL所引用的远程对象的连接。当与一个URL建立连接时，首先要在一个 URL 对象上通过方法 openConnection() 生成对应的 URLConnection 对象。如果连接过程失败，将产生IOException. 
  - `URL netchinaren = new URL ("http://www.atguigu.com/index.shtml");`
  - `URLConnectonn u = netchinaren.openConnection( );`

- 通过URLConnection对象获取的输入流和输出流，即可以与现有的CGI程序进行交互。
  - public Object getContent( ) throws IOException

  - public int getContentLength( )
  - public String getContentType( )
  - public long getDate( )
  - public long getLastModified( )
  - **public InputStream getInputStream ( ) throws IOException**
  - public OutputSteram getOutputStream( )throws IOException

举例：URL编程下载资源

```java
@Test
public void testUrl() throws IOException {
    // 1. 获取URL实例
    URL url = new URL("http://localhost:8080/demo/%E6%B5%8B%E8%AF%95.html");

    // 2. 建立与服务端的连接
    HttpURLConnection urlConnection = (HttpURLConnection)url.openConnection();

    // 3. 获取输入流，创建输出流
    InputStream is = urlConnection.getInputStream();
    File file = new File("IOtest/copy.html");
    FileOutputStream fos = new FileOutputStream(file);

    // 4. 读写数据
    byte[] buffer = new byte[1024];
    int len = 0;
    while ((len = is.read(buffer)) != -1) {
        fos.write(buffer, 0, len);
    }
    // 5. 关闭资源
    fos.close();
    is.close();
    urlConnection.disconnect();
}
```



#  第17章_反射机制

## 1. 反射(Reflection)的概念

### 1.1 反射的出现背景

Java程序中，所有的对象都有两种类型：`编译时类型`和`运行时类型`，而很多时候对象的编译时类型和运行时类型`不一致`。 `Object obj = new String("hello"); obj.getClass();`

例如：某些变量或形参的声明类型是Object类型，但是程序却需要调用该对象运行时类型的方法，该方法不是Object中的方法，那么如何解决呢？

解决这个问题，有两种方案：

方案1：在编译和运行时都完全知道类型的具体信息，在这种情况下，我们可以直接先使用`instanceof`运算符进行判断，再利用强制类型转换符将其转换成运行时类型的变量即可。

方案2：编译时根本无法预知该对象和类的真实信息，程序只能依靠`运行时信息`来发现该对象和类的真实信息，这就必须使用反射。

### 1.2 反射概述

Reflection（反射）是被视为`动态语言`的关键，反射机制允许程序在`运行期间`借助于Reflection API取得任何类的内部信息，并能直接操作任意对象的内部属性及方法。

加载完类之后，在堆内存的方法区中就产生了一个Class类型的对象（一个类只有一个Class对象），这个对象就包含了完整的类的结构信息。我们可以通过这个对象看到类的结构。`这个对象就像一面镜子，透过这个镜子看到类的结构，所以，我们形象的称之为：反射。`

简单来说，**反射技术，指的是加载类的字节码到内存，并以编程的方法解刨出类中的各个成分（成员变量、方法、构造器等）。**

因为反射获取的是类的信息，那么反射的第一步首先获取到类才行。由于Java的设计原则是万物皆对象，获取到的类其实也是以对象的形式体现的，**叫字节码对象**，用Class类来表示。获取到字节码对象之后，再通过字节码对象就可以获取到类的组成成分了，这些组成成分其实也是对象，其中**每一个成员变量用Field类的对象来表示**、**每一个成员方法用Method类的对象来表示**，**每一个构造器用Constructor类的对象来表示**。

**反射相关的主要API**：

- `java.lang.Class`：代表一个类
- `java.lang.reflect.Method`：代表类的方法
- `java.lang.reflect.Field`：代表类的成员变量
- `java.lang.reflect.Constructor`：代表类的构造器

### 1.3  Java反射机制研究及应用

Java反射机制提供的功能：

- 在运行时判断任意一个对象所属的类
- 在运行时构造任意一个类的对象
- 在运行时判断任意一个类所具有的成员变量和方法
- 在运行时获取泛型信息
- 在运行时调用任意一个对象的成员变量和方法
- 在运行时处理注解
- 生成动态代理

### 1.4 反射的优缺点

**优点：**

- 提高了Java程序的灵活性和扩展性，`降低了耦合性`，提高`自适应`能力

- 允许程序创建和控制任何类的对象，无需提前`硬编码`目标类

**缺点：**

- 反射的`性能较低`。所以反射机制主要应用在对灵活性和扩展性要求很高的系统框架上。
- 反射会`模糊`程序内部逻辑，`可读性较差`。

### 1.5 反射的相关问题

**Q1**：面向对象中创建对象，调用指定结构（属性、方法）等功能，可以不使用反射，也可以使用反射。请问有什么区别？

**A**：不使用反射，我们需要考虑封装性。比如：出了Person类之后，就不能调用Person类中私有的结构。而使用反射，我们可以调用运行时类中任意的构造器、属性、方法(包括私有的)。

**Q2**：以前创建对象并调用方法的方式，与现在通过反射创建对象并调用方法的方式对比的话，哪种用的多？场景是什么？

**A**：从我们作为程序员开发者的角度来讲，我们开发中主要是完成业务代码，对于相关的对象、方法的调用都是确定的。所以，我们使用非反射的方式多一些。

因为反射体现了动态性（可以在运行时动态的获取对象所属的类，动态的调用相关的方法），所以我们在设计框架的时候，会大量的使用反射。意味着，如果大家需要学习框架源码，那么就需要学习反射。(框架 = 注解 + 反射 + 设计模式)

**Q3**：单例模式的饿汉式和懒汉式中，私有化类的构造器了！ 此时通过反射，可以创建单例模式中类的多个对象吗？

**A**：是的！

**Q4**：通过反射，可以调用类中私有的结构，是否与面向对象的封装性有冲突？是不是Java语言设计存在Bug？

**A**：不存在bug! 封装性：体现的是是否建议我们调用内部api的问题，比如，private声明的结构，意味着不建议调用。反射：体现的是我们能否调用的问题，因为类的完整结构都加载到了内存中，所有我们就有能力进行调用。


## 2. 理解Class类并获取Class实例

### 2.1 理解Class

要想`解剖`一个类，必须先要获取到该类的Class对象。所以，Class对象是反射的根源。

- Class本身也是一个类
- Class对象只能由系统建立对象
- 一个加载的类在 JVM 中只会有一个Class实例 
- 一个Class对象对应的是一个加载到JVM中的一个.class文件
- 每个类的实例都会记得自己是由哪个Class实例所生成
- 通过Class可以完整地得到一个类中的所有被加载的结构 
- Class类是Reflection的根源，针对任何你想动态加载、运行的类，唯有先获得相应的Class对象

如下以Java类的加载为例说明：

针对于编写好的.java源文件进行编译(使用javac.exe)，会生成一个或多个.class字节码文件。接着，我们使用java.exe命令对指定的.class文件进行解释运行。这个解释运行的过程中，我们需要将.class字节码文件加载(使用类的加载器)到内存中(存放在方法区)。加载到内存中的.class文件对应的结构即为Class的一个实例。

说明：一般情况下，运行时类在内存中会缓存起来，在整个执行期间，只会加载一次。


### 2.2 获取Class类的实例(四种方法)

**方式1：要求编译期间已知类型**

前提：若已知具体的类，通过类的class属性获取，该方法最为安全可靠，程序性能最高

```java
Class clazz1 = Person.class;
```

**方式2：获取对象的运行时类型**

前提：已知某个类的实例，调用该实例的getClass()方法获取Class对象

```java
Person p1 = new Person();
Class clazz2 = p1.getClass();
```

**方式3：可以获取编译期间未知的类型**

前提：已知一个类的全类名，且该类在类路径下，可通过Class类的静态方法forName()获取，可能抛出ClassNotFoundException

```java
Class clazz3 = Class.forName("com.thuwsy.reflection.Person");
```

**方式4：其他方式(不做要求)**

前提：可以用系统类加载对象或自定义加载器对象加载指定路径下的类型

```java
Class clazz4 = ClassLoader.getSystemClassLoader().loadClass("com.thuwsy.reflection.Person");
```

举例：
```java
@Test
public void test1() throws ClassNotFoundException {
    // 1. 调用运行时类的静态属性：class
    Class clazz1 = Person.class;
    System.out.println(clazz1); // class com.thuwsy.reflection.Person

    // 2. 调用运行时类的对象的getClass()
    Person p1 = new Person();
    Class clazz2 = p1.getClass();
    System.out.println(clazz1 == clazz2); // true

    // 3. 调用Class的静态方法forName(String className)
    String className = "com.thuwsy.reflection.Person"; // 全类名
    Class clazz3 = Class.forName(className);
    System.out.println(clazz1 == clazz3); // true

    // 4. 使用类的加载器的方式(了解)
    Class clazz4 = ClassLoader.getSystemClassLoader().loadClass(className);
    System.out.println(clazz1 == clazz4); // true
}
```

### 2.3 哪些类型可以有Class对象

简言之，所有Java类型！

（1）class：外部类，成员(成员内部类，静态内部类)，局部内部类，匿名内部类
（2）interface：接口
（3）[]：数组
（4）enum：枚举
（5）annotation：注解@interface
（6）primitive type：基本数据类型
（7）void

举例：

```java
Class c1 = Object.class;
Class c2 = Comparable.class;
Class c3 = String[].class;
Class c4 = int[][].class;
Class c5 = ElementType.class;
Class c6 = Override.class;
Class c7 = int.class;
Class c8 = void.class;
Class c9 = Class.class;

int[] a = new int[10];
int[] b = new int[100];
Class c10 = a.getClass();
Class c11 = b.getClass();
// 只要元素类型与维度一样，就是同一个Class
System.out.println(c10 == c11); // true，都是一维int数组
```

### 2.4 Class类的常用方法

- `static Class forName(String name)`：返回指定全类名name的Class对象
- `Object newInstance()`：调用缺省构造函数，返回该Class对象的一个实例
- `getName()`：返回此Class对象的全类名
- `getSimpleName()`：返回此Class对象的简名
- `Class getSuperclass()`：返回当前Class对象的父类的Class对象
- `Class[] getInterfaces()`：获取当前Class对象的接口
- `ClassLoader getClassLoader()`：返回该类的类加载器


## 3. 类的加载与ClassLoader的理解

### 3.1 类的生命周期

类在内存中完整的生命周期：加载-->使用-->卸载。其中加载过程又分为：装载、链接、初始化三个阶段。

### 3.2 类的加载过程

当程序主动使用某个类时，如果该类还未被加载到内存中，系统会通过加载、链接、初始化三个步骤来对该类进行初始化。如果没有意外，JVM将会连续完成这三个步骤，所以有时也把这三个步骤统称为类加载。

![](/zzimages/image-20220417171411631.png)

类的加载又分为三个阶段：

（1）装载（Loading）

将类的class文件读入内存，并为之创建一个java.lang.Class对象。此过程由类加载器完成

（2）链接（Linking）

- 验证Verify：确保加载的类信息符合JVM规范，例如：以cafebabe开头，没有安全方面的问题。

- 准备Prepare：正式为类变量（static）分配内存并`设置类变量默认初始值`的阶段，这些内存都将在方法区中进行分配。

- 解析Resolve：虚拟机常量池内的符号引用（常量名）替换为直接引用（地址）的过程。

（3）初始化（Initialization）

- 执行`类构造器<clinit>()方法`的过程。`类构造器<clinit>()方法`是由编译期自动收集类中所有类变量的赋值动作和静态代码块中的语句合并产生的。（类构造器是构造类信息的，不是构造该类对象的构造器）。

- 当初始化一个类的时候，如果发现其父类还没有进行初始化，则需要先触发其父类的初始化。

- 虚拟机会保证一个`类的<clinit>()方法`在多线程环境中被正确加锁和同步。

### 3.3 类加载器(classloader)

#### 3.3.1 类加载器的作用

将class文件字节码内容加载到内存中，并将这些静态数据转换成方法区的运行时数据结构，然后在堆中生成一个代表这个类的java.lang.Class对象，作为方法区中类数据的访问入口。

类缓存：标准的JavaSE类加载器可以按要求查找类，但一旦某个类被加载到类加载器中，它将维持加载（缓存）一段时间。不过JVM垃圾回收机制可以回收这些Class对象。

#### 3.3.2 类加载器的分类(JDK8为例)

JVM支持两种类型的类加载器，分别为`引导类加载器（Bootstrap ClassLoader）`和`自定义类加载器（User-Defined ClassLoader）`。

从概念上来讲，自定义类加载器一般指的是程序中由开发人员自定义的一类类加载器，但是Java虚拟机规范却没有这么定义，而是将所有派生于抽象类ClassLoader的类加载器都划分为自定义类加载器。无论类加载器的类型如何划分，在程序中我们最常见的类加载器结构主要是如下情况：

![](/zzimages/image-20220417173819953.png)

**（1）启动类加载器（引导类加载器，Bootstrap ClassLoader）**

- 这个类加载使用`C/C++语言`实现的，嵌套在JVM内部。获取它的对象时往往返回null
- 它用来加载Java的核心库（JAVA_HOME/jre/lib/rt.jar或sun.boot.class.path路径下的内容）。用于提供JVM自身需要的类。
- 并不继承自java.lang.ClassLoader，没有父加载器。
- 出于安全考虑，Bootstrap启动类加载器只加载包名为java、javax、sun等开头的类
- 加载扩展类和应用程序类加载器，并指定为他们的父类加载器。

**（2）扩展类加载器（Extension ClassLoader）**

- Java语言编写，由sun.misc.Launcher$ExtClassLoader实现。
- 继承于ClassLoader类
- 父类加载器为启动类加载器
- 从java.ext.dirs系统属性所指定的目录中加载类库，或从JDK的安装目录的jre/lib/ext子目录下加载类库。如果用户创建的JAR放在此目录下，也会自动由扩展类加载器加载。

![](/zzimages/image-20220417174032702.png)

**（3）应用程序类加载器（系统类加载器，AppClassLoader）**

- java语言编写，由sun.misc.Launcher$AppClassLoader实现
- 继承于ClassLoader类
- 父类加载器为扩展类加载器
- 它负责加载环境变量classpath或系统属性 java.class.path 指定路径下的类库。我们自定义的类，默认使用该加载器。
- 应用程序中的类加载器默认是系统类加载器。
- 它是用户自定义类加载器的默认父加载器
- 通过ClassLoader的getSystemClassLoader()方法可以获取到该类加载器

**（4）用户自定义类加载器（了解）**

- 在Java的日常应用程序开发中，类的加载几乎是由上述3种类加载器相互配合执行的。在必要时，我们还可以自定义类加载器，来定制类的加载方式。
- 体现Java语言强大生命力和巨大魅力的关键因素之一便是，Java开发者可以自定义类加载器来实现类库的动态加载，加载源可以是本地的JAR包，也可以是网络上的远程资源。
- 同时，自定义加载器能够实现`应用隔离`，例如 Tomcat，Spring等中间件和组件框架都在内部实现了自定义的加载器，并通过自定义加载器隔离不同的组件模块。这种机制比C/C++程序要好太多，想不修改C/C++程序就能为其新增功能，几乎是不可能的，仅仅一个兼容性便能阻挡住所有美好的设想。
- 自定义类加载器通常需要继承于ClassLoader。

#### 3.3.3 查看某个类的类加载器对象

（1）获取默认的系统类加载器

```java
ClassLoader classloader = ClassLoader.getSystemClassLoader();
```

（2）查看某个类是哪个类加载器加载的

```java
ClassLoader classloader = Class.forName("exer2.ClassloaderDemo").getClassLoader();

//如果是根加载器加载的类，则会得到null
ClassLoader classloader1 = Class.forName("java.lang.Object").getClassLoader();
```

（3）获取某个类加载器的父加载器

```java
ClassLoader parentClassloader = classloader.getParent();
```

示例代码：

```java
package com.atguigu.loader;

import org.junit.Test;

public class TestClassLoader {
    @Test
    public void test01(){
        ClassLoader systemClassLoader = ClassLoader.getSystemClassLoader();
        System.out.println("systemClassLoader = " + systemClassLoader);
    }

    @Test
    public void test02()throws Exception{
        ClassLoader c1 = String.class.getClassLoader();
        System.out.println("加载String类的类加载器：" + c1);

        ClassLoader c2 = Class.forName("sun.util.resources.cldr.zh.TimeZoneNames_zh").getClassLoader();
        System.out.println("加载sun.util.resources.cldr.zh.TimeZoneNames_zh类的类加载器：" + c2);

        ClassLoader c3 = TestClassLoader.class.getClassLoader();
        System.out.println("加载当前类的类加载器：" + c3);
    }

    @Test
    public void test03(){
        ClassLoader c1 = TestClassLoader.class.getClassLoader();
        System.out.println("加载当前类的类加载器c1=" + c1);

        ClassLoader c2 = c1.getParent();
        System.out.println("c1.parent = " + c2);

        ClassLoader c3 = c2.getParent();
        System.out.println("c2.parent = " + c3);

    }
}
```

#### 3.3.4 使用ClassLoader获取流（掌握）

关于类加载器的一个主要方法：getResourceAsStream(String str):获取类路径下的指定文件的输入流

举例：使用类的加载器获取流，并读取配置文件信息

```java
@Test
public void test3() throws IOException {
    Properties pros = new Properties();

    //通过类的加载器读取的文件的默认的路径为：当前module下的src下
    InputStream is = ClassLoader.getSystemClassLoader().getResourceAsStream("info1.properties");

    pros.load(is);

    String name = pros.getProperty("name");
    String pwd = pros.getProperty("password");
    System.out.println(name + ":" +pwd);
}
```

## 4. 反射的基本应用

### 4.1 获取构造器对象并使用

这是反射机制应用最多的地方。创建运行时类的对象有两种方式：

**方式1：直接调用Class对象的newInstance()方法**

要求：1）类必须有一个无参数的构造器。2）该构造器的访问权限需要足够。

```java
Class c1 = Student.class;
Student student = (Student) c1.newInstance();
```

**方式2：通过获取构造器对象来进行实例化**

Class类中用于获取构造器的API：

- `Constructor<?>[] getConstructors()`：返回所有public修饰的构造器对象的数组
- `Constructor<?>[] getDeclaredConstructors()`：返回所有构造器对象的数组
- `Constructor<T> getConstructor(Class<?>... parameterTypes)`：返回某个public修饰的构造器对象(要指定参数的类型)
- `Constructor<T> getDeclaredConstructor(Class<?>... parameterTypes)`：返回某个构造器对象(要指定参数的类型)

Constructor类中的API：

- `T newInstance(Object... initargs)`：根据指定的构造器创建对象
- `void setAccessible(boolean flag)`：设置为true，表示取消访问检查，进行暴力反射
- `String getName()`：返回构造器的名字
- `int getParameterCount()`：返回构造器的参数个数

```java
@Test
public void test3() throws Exception {
    Class c = Student.class;
    // 获取某个构造器
    // 无参构造器
    Constructor cons1 = c.getDeclaredConstructor();
    cons1.setAccessible(true);
    Student s1 = (Student) cons1.newInstance();
    System.out.println(s1);
    // 有参构造器
    Constructor cons2 = c.getDeclaredConstructor(Integer.class, String.class, Integer.class, String.class);
    cons2.setAccessible(true);
    Student s2 = (Student) cons2.newInstance(1, "张三", 22, "男");
    System.out.println(s2);
}
```

### 4.2 获取成员变量并使用

Class类中用于获取成员变量的API：

- `Field[] getFields()`：返回所有public修饰的成员变量对象的数组
- `Field[] getDeclaredFields()`：返回所有成员变量对象的数组
- `Field getField(String name)`：返回某个public修饰的成员变量对象
- `Field getDeclaredField(String name)`：返回某个成员变量对象

Field类中的API：

- `void set(Object obj, Object value)`：赋值
- `Object get(Object obj)`：取值
- `void setAccessible(boolean flag)`：设置为true，表示取消访问检查，进行暴力反射
- `String getName()`：返回该成员变量的名字
- `Class<?> getType()`：返回该成员变量的类型

```java
@Test
public void test4() throws Exception {
    Student student = new Student();
    Class c = student.getClass();
    // 获取成员变量
    Field field = c.getDeclaredField("sname");
    System.out.println(field.getName() + "-->" + field.getType());
    // 赋值
    field.setAccessible(true);
    field.set(student, "张三");
    // 取值
    String name = (String) field.get(student);
    System.out.println(name);
}
```

### 4.3 获取方法并使用

Class类中用于获取方法的API：

- `Method[] getMethods()`：返回所有public修饰的成员方法对象的数组
- `Method[] getDeclaredMethods()`：返回所有成员方法对象的数组
- `Method getMethod(String name, Class<?>... parameterTypes)`：返回某个public修饰的成员方法对象(要指定方法名，以及参数的类型)
- `Method getDeclaredMethod(String name, Class<?>... parameterTypes)`：返回某个成员方法对象(要指定方法名，以及参数的类型)

Method类中的API：

- `Object invoke(Object obj, Object... args)`：调用该方法，第一个参数表示用obj对象调用该方法(静态方法传入null即可)，第二个参数表示调用该方法传递的参数，返回值就是方法的返回值(如果是void则返回null)
- `void setAccessible(boolean flag)`：设置为true，表示取消访问检查，进行暴力反射
- `String getName()`：返回方法名
- `int getParameterCount()`：返回方法的参数个数
- `Class<?> getReturnType()`：返回方法的返回值类型

```java
@Test
public void test5() throws Exception {
    Student student = new Student();
    Class c = student.getClass();
    // 获取方法
    Method method = c.getDeclaredMethod("printMessage", String.class);
    System.out.println(method.getName()+"-->"+ method.getParameterCount()+"-->"+ method.getReturnType());
    // 调用方法
    method.setAccessible(true);
    Object res = method.invoke(student, "HelloWorld");
    System.out.println(res); // null
}
```

### 4.4 获取类的其他结构

可以获取：包、修饰符、类型名、父类（包括泛型父类）、父接口（包括泛型父接口）、成员（属性、构造器、方法）、注解（类上的、方法上的、属性上的）。

#### 4.4.1 相关API

```java
//1.实现的全部接口
public Class<?>[] getInterfaces()   
//确定此对象所表示的类或接口实现的接口。 

//2.所继承的父类
public Class<? Super T> getSuperclass()
//返回表示此 Class 所表示的实体（类、接口、基本类型）的父类的 Class。

//3.全部的构造器
public Constructor<T>[] getConstructors()
//返回此 Class 对象所表示的类的所有public构造方法。
public Constructor<T>[] getDeclaredConstructors()
//返回此 Class 对象表示的类声明的所有构造方法。

//Constructor类中：
//取得修饰符: 
public int getModifiers();
//取得方法名称: 
public String getName();
//取得参数的类型：
public Class<?>[] getParameterTypes();

//4.全部的方法
public Method[] getDeclaredMethods()
//返回此Class对象所表示的类或接口的全部方法
public Method[] getMethods()  
//返回此Class对象所表示的类或接口的public的方法

//Method类中：
public Class<?> getReturnType()
//取得全部的返回值
public Class<?>[] getParameterTypes()
//取得全部的参数
public int getModifiers()
//取得修饰符
public Class<?>[] getExceptionTypes()
//取得异常信息

//5.全部的Field
public Field[] getFields() 
//返回此Class对象所表示的类或接口的public的Field。
public Field[] getDeclaredFields() 
//返回此Class对象所表示的类或接口的全部Field。

//Field方法中：
public int getModifiers()
//以整数形式返回此Field的修饰符
public Class<?> getType()  
//得到Field的属性类型
public String getName()  
//返回Field的名称。

//6. Annotation相关
get Annotation(Class<T> annotationClass) 
getDeclaredAnnotations() 

//7.泛型相关
//获取父类泛型类型：
Type getGenericSuperclass()
//泛型类型：ParameterizedType
//获取实际的泛型类型参数数组：
getActualTypeArguments()

//8.类所在的包
Package getPackage() 
```

#### 4.4.2 获取其他结构(父类、接口、包、注解等)

```java
public class OtherTest {

    /*
    	获取运行时类的父类
     */
    @Test
    public void test2(){
        Class clazz = Person.class;
        Class superclass = clazz.getSuperclass();
        System.out.println(superclass);//class com.atguigu.java1.Creature
    }
    /*
    	获取运行时类的所在的包
     */
    @Test
    public void test3(){
        Class clazz = Person.class;
        Package pack = clazz.getPackage();
        System.out.println(pack);

    }
    /*
    	获取运行时类的注解
     */
    @Test
    public void test4(){
        Class clazz = Person.class;
        Annotation[] annos = clazz.getAnnotations();
        for (Annotation anno : annos) {
            System.out.println(anno);
        }
    }

    /*
    	获取运行时类所实现的接口
     */
    @Test
    public void test5(){
        Class clazz = Person.class;
        Class[] interfaces = clazz.getInterfaces();
        for (Class anInterface : interfaces) {

            System.out.println(anInterface);
        }

    }
    /*
    	获取运行时类的带泛型的父类
     */
    @Test
    public void test6(){
        Class clazz = Person.class;
        Type genericSuperclass = clazz.getGenericSuperclass();
        System.out.println(genericSuperclass);//com.atguigu.java1.Creature<java.lang.String>
    }
}

```

#### 4.4.3 获取泛型父类信息

示例代码获取泛型父类信息：

```java
/* Type：
 * （1）Class
 * （2）ParameterizedType   
 * 		例如：Father<String,Integer>
 * 			ArrayList<String>
 * （3）TypeVariable
 * 		例如：T，U,E,K,V
 * （4）WildcardType
 * 		例如：
 * 		ArrayList<?>
 * 		ArrayList<? super 下限>
 * 		ArrayList<? extends 上限>
 * （5）GenericArrayType
 * 		例如：T[]
 * 	
 */
public class TestGeneric {
	public static void main(String[] args) {
		//需求：在运行时，获取Son类型的泛型父类的泛型实参<String,Integer>
		
		//（1）还是先获取Class对象
		Class clazz = Son.class;//四种形式任意一种都可以
		
		//（2）获取泛型父类
//		Class sc = clazz.getSuperclass();
//		System.out.println(sc);
		/*
		 * getSuperclass()只能得到父类名，无法得到父类的泛型实参列表
		 */
		Type type = clazz.getGenericSuperclass();
		
		// Father<String,Integer>属于ParameterizedType
		ParameterizedType pt = (ParameterizedType) type;
		
		//（3）获取泛型父类的泛型实参列表
		Type[] typeArray = pt.getActualTypeArguments();
		for (Type type2 : typeArray) {
			System.out.println(type2);
		}
	}
}
//泛型形参：<T,U>
class Father<T,U>{
	
}
//泛型实参：<String,Integer>
class Son extends Father<String,Integer>{
	
}
```

#### 4.4.4 获取内部类或外部类信息

`public Class<?>[] getClasses()`：返回所有公共内部类和内部接口。包括从超类继承的公共类和接口成员以及该类声明的公共类和接口成员。

`public Class<?>[] getDeclaredClasses()`：返回 Class 对象的一个数组，这些对象反映声明为此 Class 对象所表示的类的成员的所有类和接口。包括该类所声明的公共、保护、默认（包）访问及私有类和接口，但不包括继承的类和接口。

`public Class<?> getDeclaringClass()`：如果此 Class 对象所表示的类或接口是一个内部类或内部接口，则返回它的外部类或外部接口，否则返回null。

`Class<?> getEnclosingClass()`：返回某个内部类的外部类

```java
	@Test
	public void test5(){
		Class<?> clazz = Map.class;
		Class<?>[] inners = clazz.getDeclaredClasses();
		for (Class<?> inner : inners) {
			System.out.println(inner);
		}
		
		Class<?> ec = Map.Entry.class;
		Class<?> outer = ec.getDeclaringClass();
		System.out.println(outer);
	}
```

### 4.5 读取注解信息

详见第10章

## 5. 体会反射的动态性

**体会1：**

```java
public class ReflectionTest {

    //体会反射的动态性：动态的创建给定字符串对应的类的对象
    public <T> T getInstance(String className) throws Exception {

        Class clazz = Class.forName(className);

        Constructor constructor = clazz.getDeclaredConstructor();
        constructor.setAccessible(true);
        return (T) constructor.newInstance();

    }

    @Test
    public void test1() throws Exception {
        String className = "com.atguigu.java1.Person";
        Person p1 = getInstance(className);
        System.out.println(p1);
    }
}
```

**体会2：**

```java
public class ReflectionTest {
    //体会反射的动态性：动态的创建指定字符串对应类的对象，并调用指定的方法
    public Object  invoke(String className,String methodName) throws Exception {
        Class clazz = Class.forName(className);
        Constructor constructor = clazz.getDeclaredConstructor();
        constructor.setAccessible(true);
        //动态的创建指定字符串对应类的对象
        Object obj = constructor.newInstance();

        Method method = clazz.getDeclaredMethod(methodName);
        method.setAccessible(true);
        return method.invoke(obj);
    }

    @Test
    public void test2() throws Exception {
        String info = (String) invoke("com.atguigu.java1.Person", "show");

        System.out.println("返回值为：" + info);

    }
}
```

**体会3：**

```java
public class ReflectionTest {
	@Test
    public void test1() throws Exception {
        //1.加载配置文件，并获取指定的fruitName值
        Properties pros = new Properties();
        InputStream is = ClassLoader.getSystemClassLoader().getResourceAsStream("config.properties");
        pros.load(is);
        String fruitStr = pros.getProperty("fruitName");
        //2.创建指定全类名对应类的实例
        Class clazz = Class.forName(fruitStr);
        Constructor constructor = clazz.getDeclaredConstructor();
        constructor.setAccessible(true);
        Fruit fruit = (Fruit) constructor.newInstance();
        //3. 调用相关方法，进行测试
        Juicer juicer = new Juicer();
        juicer.run(fruit);

    }

}

interface Fruit {
	public void squeeze();
}

class Apple implements Fruit {
	public void squeeze() {
		System.out.println("榨出一杯苹果汁儿");
	}
}

class Orange implements Fruit {
	public void squeeze() {
		System.out.println("榨出一杯桔子汁儿");
	}
}

class Juicer {
	public void run(Fruit f) {
		f.squeeze();
	}
}

```

## 6. 动态代理设计模式

### 6.1 动态代理的基本概念

代理，就是被代理者没有能力，或者不愿意去完成某件事情，需要找个人（代理）代替自己去完成这件事。

动态代理主要是对被代理对象的行为进行代理。

**动态代理的开发步骤**：

1. 必须定义接口，里面定义一些行为，用来约束被代理对象和代理对象都要完成的事情。
2. 定义一个实现类实现接口，这个实现类的对象代表被代理的对象。
3. 定义一个测试类，在里面创建被代理对象，然后为其创建一个代理对象返回。（重点）
4. 代理对象中，需要模拟收首付款，真正触发被代理对象的行为，然后接收尾款操作。
5. 通过返回的代理对象进行方法的调用，观察动态代理的执行流程。

**动态代理的优点**：

1. 可以在不改变方法源码的情况下，实现对方法功能的增强，提高了代码的复用。
2. 简化了编程工作、提高了开发效率，同时提高了软件系统的可扩展性。
3. 可以为被代理对象的所有方法做代理。
4. 非常的灵活，支持任意接口类型的实现类对象做代理，也可以直接为接口本身做代理。


### 6.2 动态代理的示例

创建一个类BigStar作为被代理对象，需要实现代理接口：

```java
public class BigStar implements Star{
    private String name;
    public BigStar(String name) {
        this.name = name;
    }
    @Override
    public String sing(String message) {
        System.out.println(name + "正在唱" + message);
        return "谢谢";
    }
    @Override
    public void dance() {
        System.out.println(name + "正在跳舞");
    }
}
```

创建代理接口：

```java
public interface Star {
    String sing(String message);
    void dance();
}
```

定义一个工具类用于创建代理对象，即根据实现类对象，来创建一个用于代理的接口对象：

```java
public class ProxyUtil {
    public static Star createProxy(BigStar bigStar) {
//        public static Object newProxyInstance(ClassLoader loader,
//                Class<?>[] interfaces,
//                InvocationHandler h)
        // 第1个参数：指定一个类加载器
        // 第2个参数：指定生成的代理是哪些接口类型
        // 第3个参数：用来指定生成的代理对象要做什么事情
        Star star = (Star) Proxy.newProxyInstance(ProxyUtil.class.getClassLoader(),
                new Class[]{Star.class}, new InvocationHandler() {
                    /* 这是一个回调方法，如果在主程序中创建一个代理对象
                    * Star starProxy = ProxyUtil.createProxy(bigStar);
                    * 当调用接口Star中的方法，如starProxy.sing("666");
                    * 实际上会调用这里的invoke()方法：
                    * 代理对象starProxy传递给参数proxy
                    * sing方法作为一个Method对象传递给参数method
                    * sing方法中的参数传递给参数args
                    * */
                    @Override
                    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                        if (method.getName().equals("sing")) {
                            System.out.println("准备唱歌！");
                        } else if (method.getName().equals("dance")) {
                            System.out.println("准备跳舞！");
                        }
                        // 调用具体实现类BigStar中的对应方法
                        return method.invoke(bigStar, args);
                    }
                });
        return star;
    }
}
```

测试：

```java
public class ProxyTest {
    @Test
    public void test1() {
        BigStar bigStar = new BigStar("杨超越");
        Star starProxy = ProxyUtil.createProxy(bigStar);

        String str = starProxy.sing("666");
        System.out.println(str);

        starProxy.dance();
    }
}
```



# 第18章_JDK8-17新特性

## 1. Java8新特性：Lambda表达式

Lambda表达式的作用是：**简化匿名内部类代码的书写**。本质上Lambda表达式就是一个接口的匿名实现类的匿名对象。

### 1.1 Lambda表达式基本使用

Lamdba表达式的格式：

```java
(被重写方法的形参列表) -> {
    被重写方法的方法体;
}
```

**注意：Lambda表达式只能简化函数式接口的匿名内部类。函数式接口指的是只有一个抽象方法的接口(当然该接口可以包含其他非抽象方法)**。将来我们见到的大部分函数式接口，上面都可能会有一个`@FunctionalInterface`的注解，有该注解的接口就必定是函数式接口。

举例：

```java
public class Test {
    public static void main(String[] args) {
        Swim student = () -> {
            System.out.println("学生在游泳~~~");
        };
        student.swimming();
    }
}
@FunctionalInterface
interface Swim {
    void swimming();
}
```

### 1.2 Lambda表达式省略规则

```java
  Lambda的标准格式：
	(参数类型1 参数名1, 参数类型2 参数名2) -> {
		...方法体的代码...
		return 返回值;
	}

1. 参数类型可以省略不写
	(参数名1, 参数名2)->{
		...方法体的代码...
		return 返回值;
	}
	
2. 如果只有一个参数，()也可以省略。
    参数名1 -> { ... }

3. 如果方法体代码只有一行代码，可以省略大括号不写，同时要省略分号。
此时，如果这行代码是return语句，就必须去掉return。
	(a, b) -> a - b
```

### 1.3 补充：常见的函数式接口

jdk8中声明的函数式接口都在java.util.function包下。

四大核心函数式接口：


| 函数式接口         | 称谓       | 参数类型 | 用途                                                         |
| ------------------ | ---------- | -------- | ------------------------------------------------------------ |
| `Consumer<T>  `    | 消费型接口 | T        | 对类型为T的对象应用操作，包含方法：  `void accept(T t)  `    |
| `Supplier<T>  `    | 供给型接口 | 无       | 返回类型为T的对象，包含方法：`T get()  `                     |
| `Function<T, R>  ` | 函数型接口 | T        | 对类型为T的对象应用操作，并返回结果。结果是R类型的对象。包含方法：`R apply(T t)  ` |
| `Predicate<T>  `   | 判断型接口 | T        | 确定类型为T的对象是否满足某约束，并返回 boolean 值。包含方法：`boolean test(T t)  ` |


**类型1：消费型接口**

消费型接口的抽象方法特点：有形参，但是返回值类型是void

| 接口名               | 抽象方法                       | 描述                       |
| -------------------- | ------------------------------ | -------------------------- |
| BiConsumer\<T,U\>      | void accept(T t, U u)          | 接收两个对象用于完成功能   |
| DoubleConsumer       | void accept(double value)      | 接收一个double值           |
| IntConsumer          | void accept(int value)         | 接收一个int值              |
| LongConsumer         | void accept(long value)        | 接收一个long值             |
| ObjDoubleConsumer\<T\> | void accept(T t, double value) | 接收一个对象和一个double值 |
| ObjIntConsumer\<T\>    | void accept(T t, int value)    | 接收一个对象和一个int值    |
| ObjLongConsumer\<T\>   | void accept(T t, long value)   | 接收一个对象和一个long值   |

**类型2：供给型接口**

这类接口的抽象方法特点：无参，但是有返回值

| 接口名          | 抽象方法               | 描述              |
| --------------- | ---------------------- | ----------------- |
| BooleanSupplier | boolean getAsBoolean() | 返回一个boolean值 |
| DoubleSupplier  | double getAsDouble()   | 返回一个double值  |
| IntSupplier     | int getAsInt()         | 返回一个int值     |
| LongSupplier    | long getAsLong()       | 返回一个long值    |

**类型3：函数型接口**

这类接口的抽象方法特点：既有参数又有返回值

| 接口名                  | 抽象方法                                        | 描述                                                |
| ----------------------- | ----------------------------------------------- | --------------------------------------------------- |
| UnaryOperator\<T\>        | T apply(T t)                                    | 接收一个T类型对象，返回一个T类型对象结果            |
| DoubleFunction\<R\>       | R apply(double value)                           | 接收一个double值，返回一个R类型对象                 |
| IntFunction\<R\>          | R apply(int value)                              | 接收一个int值，返回一个R类型对象                    |
| LongFunction\<R\>         | R apply(long value)                             | 接收一个long值，返回一个R类型对象                   |
| ToDoubleFunction\<T\>     | double applyAsDouble(T value)                   | 接收一个T类型对象，返回一个double                   |
| ToIntFunction\<T\>        | int applyAsInt(T value)                         | 接收一个T类型对象，返回一个int                      |
| ToLongFunction\<T\>       | long applyAsLong(T value)                       | 接收一个T类型对象，返回一个long                     |
| DoubleToIntFunction     | int applyAsInt(double value)                    | 接收一个double值，返回一个int结果                   |
| DoubleToLongFunction    | long applyAsLong(double value)                  | 接收一个double值，返回一个long结果                  |
| IntToDoubleFunction     | double applyAsDouble(int value)                 | 接收一个int值，返回一个double结果                   |
| IntToLongFunction       | long applyAsLong(int value)                     | 接收一个int值，返回一个long结果                     |
| LongToDoubleFunction    | double applyAsDouble(long value)                | 接收一个long值，返回一个double结果                  |
| LongToIntFunction       | int applyAsInt(long value)                      | 接收一个long值，返回一个int结果                     |
| DoubleUnaryOperator     | double applyAsDouble(double operand)            | 接收一个double值，返回一个double                    |
| IntUnaryOperator        | int applyAsInt(int operand)                     | 接收一个int值，返回一个int结果                      |
| LongUnaryOperator       | long applyAsLong(long operand)                  | 接收一个long值，返回一个long结果                    |
| BiFunction\<T,U,R\>       | R apply(T t, U u)                               | 接收一个T类型和一个U类型对象，返回一个R类型对象结果 |
| BinaryOperator\<T\>       | T apply(T t, T u)                               | 接收两个T类型对象，返回一个T类型对象结果            |
| ToDoubleBiFunction\<T,U\> | double applyAsDouble(T t, U u)                  | 接收一个T类型和一个U类型对象，返回一个double        |
| ToIntBiFunction\<T,U\>    | int applyAsInt(T t, U u)                        | 接收一个T类型和一个U类型对象，返回一个int           |
| ToLongBiFunction\<T,U\>   | long applyAsLong(T t, U u)                      | 接收一个T类型和一个U类型对象，返回一个long          |
| DoubleBinaryOperator    | double applyAsDouble(double left, double right) | 接收两个double值，返回一个double结果                |
| IntBinaryOperator       | int applyAsInt(int left, int right)             | 接收两个int值，返回一个int结果                      |
| LongBinaryOperator      | long applyAsLong(long left, long right)         | 接收两个long值，返回一个long结果                    |

**类型4：判断型接口**

这类接口的抽象方法特点：有参，但是返回值类型是boolean结果。

| 接口名           | 抽象方法                   | 描述             |
| ---------------- | -------------------------- | ---------------- |
| BiPredicate\<T,U\> | boolean test(T t, U u)     | 接收两个对象     |
| DoublePredicate  | boolean test(double value) | 接收一个double值 |
| IntPredicate     | boolean test(int value)    | 接收一个int值    |
| LongPredicate    | boolean test(long value)   | 接收一个long值   |





## 2. Java8新特性：方法引用

方法引用是用来进一步简化Lambda表达式的。**方法引用的前提**：Lambda体只有一句语句，并且是通过调用一个对象/类的现有方法或构造器来完成的。

### 2.1 静态方法的引用

使用场景：如果某个Lambda表达式里只是调用一个静态方法，并且Lambda表达式的参数和所调方法的参数一致，就可以使用静态方法引用。

语法：`类名::静态方法`

举例：

```java
public class MyTest {
    public static void main(String[] args) {
        Student[] students = new Student[4];
        students[0] = new Student("蜘蛛精", 169.5, 23);
        students[1] = new Student("紫霞", 163.8, 26);
        students[2] = new Student("紫霞", 163.8, 26);
        students[3] = new Student("至尊宝", 167.5, 24);

        // 原始写法：对数组中的学生对象，按照年龄升序排序
        Arrays.sort(students, new Comparator<Student>() {
            @Override
            public int compare(Student o1, Student o2) {
                return CompareByData.compareByAge(o1, o2);
            }
        });
        // 使用Lambda简化后的形式
        Arrays.sort(students, (o1, o2) -> CompareByData.compareByAge(o1, o2));
        // 使用静态方法引用
        Arrays.sort(students, CompareByData::compareByAge);
        
        System.out.println(Arrays.toString(students));
    }
}
class CompareByData {
    public static int compareByAge(Student o1, Student o2){
        return o1.getAge() - o2.getAge();
    }
}
```

### 2.2 实例方法的引用

使用场景：如果某个Lambda表达式里只是调用一个实例方法，并且Lambda表达式的参数和所调方法的参数一致，就可以使用实例方法引用。

语法：`对象名::实例方法`

举例：

```java
public class MyTest {
    public static void main(String[] args) {
        Student[] students = new Student[4];
        students[0] = new Student("蜘蛛精", 169.5, 23);
        students[1] = new Student("紫霞", 163.8, 26);
        students[2] = new Student("紫霞", 163.8, 26);
        students[3] = new Student("至尊宝", 167.5, 24);

        CompareByData cmp = new CompareByData();
        // 原始写法：对数组中的学生对象，按照年龄升序排序
        Arrays.sort(students, new Comparator<Student>() {
            @Override
            public int compare(Student o1, Student o2) {
                return cmp.compareByAgeObj(o1, o2);
            }
        });
        // 使用Lambda简化后的形式
        Arrays.sort(students, (o1, o2) -> cmp.compareByAgeObj(o1, o2));
        // 使用实例方法引用
        Arrays.sort(students, cmp::compareByAgeObj);

        System.out.println(Arrays.toString(students));
    }
}
class CompareByData {
    public int compareByAgeObj(Student o1, Student o2) {
        return o1.getAge() - o2.getAge();
    }
}
```

### 2.3 特定类型方法的引用

使用场景：如果某个Lambda表达式里只是调用一个实例方法，并且Lambda参数列表中的第一个参数是作为该实例方法的主调，后面的所有参数都是作为该实例方法的入参的，则此时就可以使用特定类型的方法引用。

语法：`类名::实例方法`

举例：

```java
public class MyTest {
    public static void main(String[] args) {
        String[] names = {"boby", "angela", "Andy" ,"dlei", "caocao", "Babo", "jack", "Cici"};
        // 原始写法：要求忽略首字符大小写进行排序
        Arrays.sort(names, new Comparator<String>() {
            @Override
            public int compare(String o1, String o2) {
                return o1.compareToIgnoreCase(o2);
            }
        });
        // lambda表达式写法
        Arrays.sort(names, (o1, o2) -> o1.compareToIgnoreCase(o2));
        // 特定类型方法的引用
        Arrays.sort(names, String::compareToIgnoreCase);
        
        System.out.println(Arrays.toString(names));
    }
}
```

### 2.4 构造器引用

使用场景：如果某个Lambda表达式里只是在调用构造器创建对象，并且Lambda表达式的参数和构造器中的参数一致，就可以使用构造器引用。

语法：`类名::new`

举例：

```java
public class MyTest {
    public static void main(String[] args) {
        // 原始写法
        Function<String, Student> func1 = new Function<String, Student>() {
            @Override
            public Student apply(String s) {
                return new Student(s); // 调用Student中一个参数的构造器
            }
        };
        // lambda表达式写法
        Function<String, Student> func2 = s -> new Student(s);
        // 构造器引用
        Function<String, Student> func3 = Student::new;

        System.out.println(func3.apply("张三"));
    }
}
```

### 2.5 数组构造引用

使用场景：如果某个Lambda表达式里只是在调用数组构造器创建数组，并且Lambda表达式的参数和数组构造器中的参数一致，就可以使用数组构造引用。

语法：`数据类型[]::new`

举例：

```java
public class MyTest {
    public static void main(String[] args) {
        // 原始写法
        Function<Integer, int[]> func1 = new Function<Integer, int[]>() {
            @Override
            public int[] apply(Integer length) {
                return new int[length];
            }
        };
        // lambda表达式写法
        Function<Integer, int[]> func2 = length -> new int[length];
        // 数组构造引用
        Function<Integer, int[]> func3 = int[]::new;

        System.out.println(Arrays.toString(func3.apply(5)));
    }
}
```


## 3. Java8新特性：强大的Stream API

JDK8中有两大最为重要的改变。第一个是Lambda表达式；另外一个则是Stream API(java.util.stream)。

### 3.1 Stream流概述

Stream是数据渠道，用于操作数据源（集合、数组等）所生成的元素序列。

Stream和集合的区别：**集合是一种静态的内存数据结构，讲的是数据，而Stream是有关计算的，讲的是计算**。前者是主要面向内存，存储在内存中，后者主要是面向CPU，通过CPU实现计算。Stream API 它大量地结合了Lambda的语法风格来编程，代码更简洁，可读性更好

**注意**：

1. Stream 自己不会存储元素。
2. **Stream 不会改变源对象。相反，他们会返回一个持有结果的新Stream**。
3. Stream 操作是延迟执行的。这意味着他们会等到需要结果的时候才执行。即一旦执行终止操作，就执行中间操作链，并产生结果。
4. Stream一旦执行了终止操作，就不能再调用其它中间操作或终止操作了。

**Stream操作三个步骤**：

1. 创建Stream：通过一个数据源（如集合、数组），获取一个流
2. 中间操作：每次处理都会返回一个持有结果的新Stream，即中间操作的方法返回值仍然是Stream类型的对象。因此中间操作可以是个`操作链`，可对数据源的数据进行n次处理，但是在终结操作前，并不会真正执行。
3. 终止操作：终止操作的方法返回值类型就不再是Stream了，因此一旦执行终止操作，就结束整个Stream操作了。一旦执行终止操作，就执行中间操作链，最终产生结果并结束Stream。

### 3.2 Stream流的创建

#### 3.2.1 创建集合的Stream流

JDK8 中的 Collection 接口被扩展，提供了两个获取流的方法：

- `default Stream<E> stream()`: 返回一个顺序流

- `default Stream<E> parallelStream()`: 返回一个并行流


```java
public static void main(String[] args) {
    // 1、获取List集合的Stream流
    List<String> names = new ArrayList<>();
    Stream<String> stream1 = names.stream();
    // 2、获取Set集合的Stream流
    Set<String> set = new HashSet<>();
    Stream<String> stream2 = set.stream();

    // 3、获取Map集合的Stream流(无法直接获取)
    Map<String, Double> map = new HashMap<>();
    // 获取key集合对应的Stream流
    Set<String> keys = map.keySet();
    Stream<String> ks = keys.stream();
    // 获取value集合对应的Stream流
    Collection<Double> values = map.values();
    Stream<Double> vs = values.stream();
    // 获取Entry对象集合对应的Stream流
    Set<Map.Entry<String, Double>> entries = map.entrySet();
    Stream<Map.Entry<String, Double>> kvs = entries.stream();
}
```

#### 3.2.2 创建数组的Stream流

JDK8 中的 Arrays 的静态方法 stream() 可以获取数组流：


- `static <T> Stream<T> stream(T[] array)`
- `public static IntStream stream(int[] array)`
- `public static LongStream stream(long[] array)`
- `public static DoubleStream stream(double[] array)`


```java
// 获取数组的Stream流
String[] names2 = {"张翠山", "东方不败", "唐大山", "独孤求败"};
Stream<String> s1 = Arrays.stream(names2); // 方式1
int[] arr = {1, 2, 3};
IntStream s2 = Arrays.stream(arr);
```

#### 3.2.3 通过Stream的of()方法创建Stream流

可以调用Stream类静态方法of()，通过显式值创建一个流。

- `public static<T> Stream<T> of(T... values)`

```java
Stream<Integer> stream = Stream.of(1,2,3,4,5);
```

#### 3.2.4 创建无限流(了解)

可以使用静态方法 Stream.iterate() 和 Stream.generate(), 创建无限流。

- 迭代
  `public static<T> Stream<T> iterate(final T seed, final UnaryOperator<T> f)`

- 生成
  `public static<T> Stream<T> generate(Supplier<T> s)`

```java
// 创建无限流
@Test
public void test05() {
	// 迭代
	// public static<T> Stream<T> iterate(final T seed, final
	// UnaryOperator<T> f)
	Stream<Integer> stream = Stream.iterate(0, x -> x + 2);
	stream.limit(10).forEach(System.out::println);

	// 生成
	// public static<T> Stream<T> generate(Supplier<T> s)
	Stream<Double> stream1 = Stream.generate(Math::random);
	stream1.limit(10).forEach(System.out::println);
}
```


### 3.3 Stream的中间操作

多个中间操作可以连接起来形成一个流水线，除非流水线上触发终止操作，否则中间操作不会执行任何的处理！而在终止操作时一次性全部处理，称为**惰性求值**。

**1、筛选与切片**

（1）`Stream<T> filter(Predicate<? super T> predicate)`：接收Lambda，从流中筛选某些元素(保留返回true的元素)。其中Predicate是函数式接口，它的抽象方法是boolean test(T t);
（2）`Stream<T> distinct()`：去除重复元素，hashCode()相等且equals()返回true则认为重复
（3）`Stream<T> limit(long maxSize)`：保留流前面的maxSize个元素
（4）`Stream<T> skip(long n)`：返回一个扔掉了前n个元素的流。若流中元素不足n个，则返回一个空流。

```java
public static void main(String[] args) {
    List<Integer> list = new ArrayList<>();
    Collections.addAll(list, 1, 2, 3, 4, 5, 6, 2, 4, 8, 4);

    list.stream().filter(i -> i % 2 == 0)
            .limit(4)
            .forEach(System.out::print); // 2462
    System.out.println("---------------");

    list.stream().skip(5)
            .distinct()
            .forEach(System.out::print); // 6248
}
```

**2、映射**

（5）`<R> Stream<R> map(Function<? super T, ? extends R> mapper)`：接收一个函数作为参数，该函数会被应用到每个元素上，并将其映射成一个新的元素。其中Function是一个函数式接口，它的抽象方法是R apply(T t);

其他一些类似的映射方法(不常用)：

`mapToDouble(ToDoubleFunction f)`：接收一个函数作为参数，该函数会被应用到每个元素上，产生一个新的DoubleStream
`mapToInt(ToIntFunction f)`：接收一个函数作为参数，该函数会被应用到每个元素上，产生一个新的IntStream
`mapToLong(ToLongFunction f)`：接收一个函数作为参数，该函数会被应用到每个元素上，产生一个新的LongStream
`flatMap(Function f)`：接收一个函数作为参数，将流中的每个值都换成另一个流，然后把所有流连接成一个流

```java
public static void main(String[] args) {
    List<String> list = new ArrayList<>();
    Collections.addAll(list, "aa", "bB", "CC");

    list.stream().map(s -> s.toUpperCase())
            .forEach(System.out::print); // AABBCC
}
```

**3、排序**

（6）`Stream<T> sorted()`：按自然顺序排序
（7）`Stream<T> sorted(Comparator<? super T> comparator)`：按比较器顺序排序
（8）补充：`static <T> Stream<T> concat(Stream a, Stream b)`：合并两个流成为一个流

```java
public static void main(String[] args) {
    List<Integer> list = new ArrayList<>();
    Collections.addAll(list, 1, 2, 3, 4, 5, 6, 2, 4, 8, 4);

    list.stream().sorted()
            .forEach(System.out::print); // 1223444568
    System.out.println("-----------");

    list.stream().sorted((o1, o2) -> -Integer.compare(o1, o2))
            .forEach(System.out::print); // 8654443221
    System.out.println("-----------");

    Stream<String> st1 = Stream.of("张三", "李四");
    Stream<String> st2 = Stream.of("张三2", "李四2", "王五");
    Stream<String> allSt = Stream.concat(st1, st2);
    allSt.forEach(System.out::println);
}
```

### 3.4 Stream的终止操作

终端操作会从流的流水线生成结果。其结果可以是任何不是流的值，例如：List、Integer，甚至是void。流进行了终止操作后，不能再次使用。

**1、匹配与查找**

（1）`boolean allMatch(Predicate<? super T> predicate)`：检查是否匹配所有元素
（2）`boolean anyMatch(Predicate<? super T> predicate)`：检查是否至少匹配一个元素
（3）`boolean noneMatch(Predicate<? super T> predicate)`：检查是否不匹配所有元素
（4）`Optional<T> findFirst()`：返回第一个元素
（5）`Optional<T> findAny()`：返回当前流中的任意元素
（6）`long count()`：返回流中元素总数
（7）`Optional<T> max(Comparator<? super T> comparator)`：返回流中最大值
（8）`Optional<T> min(Comparator<? super T> comparator)`：返回流中最小值
（9）`void forEach(Consumer<? super T> action)`：遍历操作。集合的forEach遍历称为外部迭代，集合对应Stream流的forEach遍历称为内部迭代。

```java
public static void main(String[] args) {
    List<Integer> list = new ArrayList<>();
    Collections.addAll(list, 1, 2, 3, 4, 5, 6, 2, 4, 8, 4);

    System.out.println(list.stream().anyMatch(i -> i < 2)); // true
    System.out.println(list.stream().count()); // 10
    System.out.println(list.stream()
            .max(Integer::compare).get()); // 8
    // 注意max返回的是一个Optional类型的对象，调用get()方法后得到其值
}
```

**2、归约**

（10）`T reduce(T identity, BinaryOperator<T> accumulator)`：可以将流中元素反复结合起来，得到一个值。返回T
（11）`Optional<T> reduce(BinaryOperator<T> accumulator)`：可以将流中元素反复结合起来，得到一个值。返回 Optional\<T\>

备注：map 和 reduce 的连接通常称为 map-reduce 模式，因 Google 用它来进行网络搜索而出名。

```java
public static void main(String[] args) {
    List<Integer> list = new ArrayList<>();
    Collections.addAll(list, 1, 2, 3, 4, 5, 6, 2, 4, 8, 4);

    // 计算元素总和
    System.out.println(list.stream()
            .reduce(0, (i1, i2) -> i1 + i2)); // 39
    // identity相当于指定初始值
}
```

**3、收集**

收集Stream流，就是把Stream流操作后的结果转回到集合或者数组中取返回。

（12）`<R, A> R collect(Collector<? super T, A, R> collector)`：将流收集到一个指定的集合中去。参数接收一个Collector接口的实现，用于给Stream中元素做汇总的方法。
（13）`Object[] toArray()`：将流收集到一个数组中去
（14）`<A> A[] toArray(IntFunction<A[]> generator)`：将流收集到一个数组中去


Collector接口中方法的实现决定了如何对流执行收集的操作(如收集到List、Set、Map)。而工具类Collectors提供了很多静态方法，可以方便地创建常见收集器实例，工具类的具体方法如下：

- `public static <T> Collector<T, ?, List<T>> toList()`：把元素收集到List集合中
- `public static <T> Collector<T, ?, Set<T>> toSet()`：把元素收集到Set集合中
- `public static <T, K, U> Collector<T, ?, Map<K,U>> toMap(Function<? super T, ? extends K> keyMapper, Function<? super T, ? extends U> valueMapper)`：把元素收集到Map集合中
- `public static <T, C extends Collection<T>> Collector<T, ?, C> toCollection(Supplier<C> collectionFactory)`：把元素收集到创建的集合中


```java
public static void main(String[] args) {
    List<Integer> list = new ArrayList<>();
    Collections.addAll(list, 1, 2, 3, 4, 5, 6, 2, 4, 8, 4);

    // 去重后排序，得到一个新的list
    List<Integer> list1 = list.stream().distinct().sorted()
            .collect(Collectors.toList());
    list1.forEach(System.out::print); // 1234568
    System.out.println("-----------");

    // 将流收集到数组中
    Object[] arr1 = list1.stream().toArray(); // 方式1
    System.out.println(Arrays.toString(arr1));
    Integer[] arr2 = list1.stream()
            .toArray(len -> new Integer[len]); // 方式2
    System.out.println(Arrays.toString(arr2));

    // 挑选年龄大于20的学生，将(姓名，年龄)键值对收集到Map中
    List<Student> list2 = new ArrayList<>();
    list2.add(new Student("张三", 19));
    list2.add(new Student("李四", 20));
    list2.add(new Student("王五", 21));
    Map<String, Integer> ans = list2.stream()
            .filter(o -> o.getAge() > 20)
            .collect(Collectors.toMap(
                    a -> a.getName(), a -> a.getAge()
            ));
    System.out.println(ans); // {王五=21}
}
```



## 4. 其他新特性

### 4.1 Java的REPL工具：jShell命令

**JDK9的新特性**

Java 终于拥有了像Python之类的REPL工具（交互式编程环境，read-evaluate-print-loop）：`jShell`。以交互式的方式对语句和表达式进行求值。`即写即得`、`快速运行`。利用jShell在没有创建类的情况下，在命令行里直接声明变量，计算表达式，执行语句。

### 4.2 局部变量类型推断

**JDK 10的新特性**

```java
//1.局部变量的实例化
var list = new ArrayList<String>();

var set = new LinkedHashSet<Integer>();

//2.增强for循环中的索引
for (var v : list) {
    System.out.println(v);
}

//3.传统for循环中
for (var i = 0; i < 100; i++) {
    System.out.println(i);
}

//4. 返回值类型含复杂泛型结构
var iterator = set.iterator();
//Iterator<Map.Entry<Integer, Student>> iterator = set.iterator();
```

**注意：**

- 注意，在很多不明确的情况下，是不能使用var的
- var不是一个关键字，而是一个类型名，将它作为变量的类型。不能使用var作为类名。
- 这不是JavaScript。var并不会改变Java是一门静态类型语言的事实。编译器负责推断出类型，并把结果写入字节码文件，就好像是开发人员自己敲入类型一样。



### 4.3 文本块

**JDK13的新特性**

使用`"""作为文本块的开始符和结束符，在其中就可以放置多行的字符串，不需要进行任何转义。因此，文本块将提高Java程序的可读性和可写性。


举例：JSON字符串

原有方式：

```java
String myJson = "{\n" +
                "    \"name\":\"Song Hongkang\",\n" +
                "     \"address\":\"www.atguigu.com\",\n" +
                "    \"email\":\"shkstart@126.com\"\n" +
                "}";
System.out.println(myJson);
```

使用新特性：

```java
String myJson1 = """
                {
                    "name":"Song Hongkang",
                    "address":"www.atguigu.com",
                    "email":"shkstart@126.com"
                }""";
System.out.println(myJson1);
```

### 4.4 Optional类

**JDK8的新特性**

到目前为止，臭名昭著的空指针异常是导致Java应用程序失败的最常见原因。以前，为了解决空指针异常，Google在著名的Guava项目引入了Optional类，通过检查空值的方式避免空指针异常。受到Google的启发，Optional类已经成为Java 8类库的一部分。

`Optional<T>` 类(java.util.Optional) 是一个容器类，它可以保存类型T的值，代表这个值存在。或者仅仅保存null，表示这个值不存在。如果值存在，则isPresent()方法会返回true，调用get()方法会返回该对象。

Optional提供很多有用的方法，这样我们就不用显式进行空值检测。

**创建Optional类对象的方法**：
- `static <T> Optional<T> empty()`：用来创建一个空的Optional实例
- `static <T> Optional<T> of(T value)`：用来创建一个Optional实例，value必须非空
- `static <T> Optional<T> ofNullable(T value)` ：用来创建一个Optional实例，value可能是空，也可能非空
  
**判断Optional容器中是否包含对象**：

- `boolean isPresent()`: 判断Optional容器中的值是否存在
- `void ifPresent(Consumer<? super T> consumer)`：判断Optional容器中的值是否存在，如果存在，就对它进行Consumer指定的操作，如果不存在就不做

**获取Optional容器的对象**：
- `T get()`: 如果调用对象包含值，返回该值。否则抛异常。T get()与of(T value)配合使用
- `T orElse(T other) `：orElse(T other) 与ofNullable(T value)配合使用，如果Optional容器中非空，就返回所包装值，如果为空，就用orElse(T other)other指定的默认值（备胎）代替
- `T orElseGet(Supplier<? extends T> other)`：如果Optional容器中非空，就返回所包装值，如果为空，就用Supplier接口的Lambda表达式提供的值代替
- `T orElseThrow(Supplier<? extends X> exceptionSupplier)`：如果Optional容器中非空，就返回所包装值，如果为空，就抛出你指定的异常类型代替原来的NoSuchElementException
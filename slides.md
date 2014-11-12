% Rust Workshop

HackEPFL

Dimiter Petrov & Romain Ruetschi

November 12, 2014

# Hello, Rust

```rust
fn main() {
    println!("Hello, world!");
}
```

```
> Hello, world!
```

# History

* Started as a personal project in 2006 by Graydon Hoare
* First compiler written in OCaml
* Mozilla took over the project 3 years later
* Compiler rewritten in Rust itself in 2010

# Why Rust at Mozilla?

* New experimental, highly parallel browser engine: Servo
* Browsers evolve in a hostile, highly concurrent environment
* Most security problems arise from memory safetey and concurrency issues
* Thus a safer, saner systems language is needed, with built-in concurrency

# Why Rust, for you?

* High-level features
* Low-level control
* Powerful Foreign Function Interface (FFI)
* Direct memory control
* Guaranteed memory safety
* Concurrency without data races
* Zero cost abstractions

# High-level features

* Type inference
* Lambdas
* Closures
* Iterators
* Algebraic data types
* Pattern matching
* Traits (= type classes)
* Macros
* Modules

# But first, the basics

* Primitive types
* Variable bindings
* Functions
* Printing stuff
* Control structures
* Strings
* Arrays, vectors and slices
* Structs and methods

# Numeric types

<table>
    <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Example</th>
    </tr>
    <tr>
        <td>Signed integer</td>
        <td><code>int</code></td>
        <td><code>5i</code></td>
    </tr>
    <tr>
        <td>Unsigned integer</td>
        <td><code>uint</code></td>
        <td><code>5u</code></td>
    </tr>
    <tr>
        <td>8-bit uint</td>
        <td><code>u8</code></td>
        <td><code>5u8</code></td>
    </tr>
    <tr>
        <td>16-bit uint</td>
        <td><code>u16</code></td>
        <td><code>5i</code></td>
    </tr>
    <tr>
        <td>etc.</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>32-bit float</td>
        <td><code>f32</code></td>
        <td><code>3.14f32</code></td>
    </tr>
    <tr>
        <td>64-bit float</td>
        <td><code>f64</code></td>
        <td><code>3.14_f64</code></td>
    </tr>
</table>

# Primitive types

<table>
    <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Example</th>
        <th></th>
    </tr>
    <tr>
        <td>Unit</td>
        <td><code>()</code></td>
        <td><code>()</code></td>
        <td></td>
    </tr>
    <tr>
        <td>Boolean</td>
        <td><code>bool</code></td>
        <td><code>true | false</code></td>
        <td></td>
    </tr>
    <tr>
        <td>Array</td>
        <td><code>[T]</code></td>
        <td><code>[1, 2, 3]</code>
        <td>fixed size, can be allocated on either the stack or the heap</td>
    </tr>
    <tr>
        <td>Slice</td>
        <td><code>&[T]</code></td>
        <td><code>&[1, 2, 3]</code>
        <td>'view' into an array, doesn't own the data it points to, but borrows it</td>
    </tr>
    <tr>
        <td>Tuple</td>
        <td><code>(A, B, C...)</code></td>
        <td><code>("Rust", 2006i, 'r')</code></td>
        <td>32-bit unsigned word</td>
    </tr>
 
</table>

# Textual types

<table>
    <tr>
        <th>Name</th>
        <th>Type</th>
        <th>Example</th>
        <th></th>
    </tr>
    <tr>
        <td>Unicode scalar value</td>
        <td><code>char</code></td>
        <td><code>'a'</code></td>
        <td>32-bit unsigned word</td>
    </tr>
    <tr>
        <td>Unicode scalar array</td>
        <td><code>[char]</code></td>
        <td><code>['a', 'b', 'c']</code></td>
        <td>~ UTF-32 string</td>
    </tr>
    <tr>
        <td>Unicode string</td>
        <td><code>str</code></td>
        <td><code>"rust is cool"</code></td>
        <td>array of 8-bit unsigned bytes<br>
            ~ sequence of UTF-8 codepoints</td>
    </tr>
</table>

# Variable bindings

```rust
let x: int = 5;

// type annotations are (usually) optional
let x = 5i;

let mut y = 2i;
y += 1;
```

# Mutability

```rust
let x = 5i;

x = x + 1; // error
```

# Mutability

```rust
let mut x = 5i;

x = x + 1; // ok
```

# Mutability

```rust
let x = 5i;
let mut y = x;

y = y + 1;
```

# Functions

```rust
fn main() {
    let res = do_stuff(2, 3);
    println!("result is {}", res);
}

fn do_stuff(a: int, b: int) -> int {
    let c = a + b;

    return c * 2;
}
```

# Functions

You can omit `return` if you want to return the last expression.

```rust
fn main() {
    let res = do_stuff(2, 3);
    println!("result is {}", res);
}

fn do_stuff(a: int, b: int) -> int {
    let c = a + b;

    c * 2 // ! no semicolon
}
```

But you also need to omit the last semicolon, otherwise the function will return `()`.

# Printing stuff

```rust
fn main() {
    let name = "John";
    let age = 42;
    
    println!("{} is {}", name, age);
}
```

> `println!()` is actually a macro, not a function.

# Printing stuff

You can re-order arguments by putting their index inside the braces.

```rust
fn main() {
    let name = "John";
    let age = 42;
    
    println!("{1} is {0}", age, name);
}
```

# Conditionals

```rust
if age > 16 {
    println!("Have a beer!");
}
else {
    println!("Sorry, no beer for you.");
}
```

> No parenthesis around the condition.

# Conditionals

`if/else` is an expression:

```rust
let message = if health > 0 {
    "Good job"
} else {
    "Game over"
};

println!("{}", message);
```

# While

```rust
while x < 10 {
    // do stuff
}
```

# Loop

Instead of

```rust
while true {
    // do stuff
}
```

use

```rust
loop {
    // do stuff
}
```

> Rust's control-flow analysis treats this construct differently than a `while true`, which leads to better generated code.

# For

```rust
for x in range(0i, 10i) {
    // do stuff
}
```

# For

```rust
for var in expression {
    code
}
```

> `expression` must be an `Iterator` (we'll talk about it later).

# Strings

* Guaranteed to be validly-encoded UTF-8 sequences
* Not null-terminated (can contain null bytes)
* Can be constant strings (`&str`) or growable strings (`String`)

# String slices (`&str`)

A pointer and a length.
String slices are a 'view' into already allocated strings like string literals:

```rust
let hello = "Hello, world!";
```

# Growable strings (`String`)

`String` can grow if defined as `mut`able.

```rust
let mut hello = "Hello".to_string();

hello.push_str(", world!");

// hello now contains "Hello, world!"
```

# Conversions between the two

* Call `as_slice()` on a `String` to convert it to a `&str`
* Call `to_string()` on a `&str` to convert it to a `String`

```rust
let s1: String = "Hello".to_string();
let s2: &str = s1.as_slice();
```

Converting `String` to `&str` is cheap, converting `&str` to `String` involves an allocation.

# Arrays, vectors and slices

* An array is a **fixed-sized** list of elements of the same type
* A vector is a **dynamic, growable** array
* A slice is a reference to an array.

# Arrays

An array is a **fixed-sized** list of elements of the same type.

```rust
// Only the first item needs a type suffix
let a = [1i, 2, 3];

// which you can omit if you specify the type
let a: [int, ..3] = [1, 2, 3];

println!("a has {} elements", a.len());
println!("the first element of a is {}", a[0]);
```

# Vectors

A vector is a **dynamic, growable** array

```rust
let mut participants = vec!["Bob", "Bill"];

participants.push("Joe");

// participants[2] == "Joe";
```

# Slices

A slice is a reference to an array.

A slice allows safe and efficient access to a portion of an array without copying.

```rust
let a: [int, ..5] = [0, 1, 2, 3, 4];
let middle: &[int] = a.slice(1, 4); // just the elements [1, 2, 3]

let a = [0i, 1, 2, 3, 4];
let middle = a.slice(1, 4); // just the elements [1, 2, 3]
```

# Structs and methods

# Structs

```rust
struct Rectangle {
    width: f32,
    height: f32
}
```

# Methods

Methods (static and members) are defined inside an `impl` block.

```rust
struct Rectangle {
    width: f32,
    height: f32
}

impl Rectangle {
    // Methods here.
}

```

# Static methods

Static methods are defined this way, and can be called with `Type::method_name()`.

```rust
struct Rectangle { width: f32, height: f32 }

impl Rectangle {
    fn new(width: f32, height: f32) -> Rectangle {
        Rectangle { width: width, height: height }
    }
}

fn main() {
    let rect = Rectangle::new(1.2, 4.9);
    println!("{}", react.area());
}
```

# Member methods

Member methods take a `&self` parameter, which is a reference to the `struct` the method is called on.

```rust
struct Rectangle { width: f32, height: f32 }

impl Rectangle {
    fn area(&self) -> f32 {
        self.width * self.height
    }
}

fn main() {
    let rect = Rectangle::new(1.2, 4.9);
    let area = react.area();

    println!("{}", area);
}
```

# Putting everything together

TODO

# Low-level control

* Ability to trade compiler-enforced safety for lower-level control
* Eg. dereferencing raw pointer, pointer arithmetic, calling external code
* Such unsafe code must be surrounded by an `unsafe` block
* Thus easy to spot during code review or when debugging

# Powerful FFI

* Call Rust code from other languages (C, C++, or even GCed languages like Ruby)
* Create bindings for libraries exposing a C interface

# Direct memory control

* No garbage collector
* No runtime overhead
* No unpredictable pauses in execution
* Stack and heap allocations

# Stack and heap allocations

By default, values are allocated on the stack.

```rust
let rect = Rectangle {
    width: 1.0,
    height: 1.0
};
```

> `rect` is of type `Rectangle`

# Stack and heap allocations

You can allocate a value on the heap with the `box` keyword.

# Stack and heap allocations

```rust
{
    let x = box 5i;
    println!("{}", *x); // Prints 5
}
```

```
{
    int *x = (int *)malloc(sizeof(int));
    if (!x) abort();
    *x = 5;
    printf("%d\n", *x);
    free(x);
}
```

# Boxes

```rust
let rect = box Rectangle {
    width: 1.0,
    height: 1.0
};
```

> `rect` is now type `Box<Rectangle>`

# Boxes

Although it's of type `Box<Rectangle>`, you can still call `Rectangle` methods on `rect`.

```rust
let rect = box Rectangle::new(1.0, 1.0);
let area = rect.area();

println!("area = {}", area);
```

# Guaranteed memory safety

* No buffer overflows
* No dangling pointers

# Concurrency without data races

* Only immutable data can be shared
* Shared data must remain live as long as any task might access it

# Zero cost abstractions

Memory safety is enforced during compilation, there is no runtime overhead.

# But how?

Rust is built around 3 concepts:

* Lifetime
* Ownership
* Borrowing

# Lifetime

Time span during which a resource (value) is valid.

# Lifetime

![](http://cl.ly/image/343C1X3o3K1s/Screen%20Shot%202014-11-10%20at%2018.06.58.png)

* You can think of it as a scope.
* At the end of its lifetime, a value will be deallocated.

# Lifetime

```c
{
    int *x = malloc(sizeof(int));

    *x = 5;

    free(x);
}
```

# Lifetime

```rust
{
    let x = box 5i;
    
    // x gets deallocated here
}
```

# Move & Copy

When you pass data to a function (or even assign it to a variable), that data can be copied, moved, or borrowed (more about it soon).

# Copy

```rust
fn main() {
    let a = 5;
    let b = add_one(a);
    println!("{}", a);
}

fn add_one(x: int) -> int {
    x + 1
}
```

# Move

```rust
struct Person {
    name: String,
    age: uint
}

fn main() {
    let john = Person { name: "John".to_string(), age: 42 };
    show(john);
    
    // `john` has already been deallocated
}

fn show(person: Person) {
    println!("{} is {}", person.name, person.age);
    
    // `john` will be deallocated here
}
```

# Move

```rust
struct Person {
    name: String,
    age: uint
}

fn main() {
    let john = Person { name: "John".to_string(), age: 42 };
    show(john);
    show(john);
}

fn show(person: Person) {
    println!("{} is {}", person.name, person.age);
    
    // `john` will be deallocated here
}
```

# Move

```norust
error: use of moved value: `john`
     show(john);
          ^
note: `john` moved here because it has type `Person`, which is non-copyable
     show(john);
          ^
error: aborting due to previous error
```

# Move

```rust
struct Person { name: String, age: uint }

fn main() {
    let john = Person { name: "John".to_string(), age: 42 };
    
    // `john` moves into show here
    show(john);
    // `john` is deallocated by now
    // so the next line doesn't compile
    show(john);
}

fn show(person: Person) {
    println!("{} is {}", person.name, person.age);
    
    // `john` will be deallocated here
}
```

# Move (assignment)

Assigning a value to a variable is similar to passing it to a function.

```rust
struct Person { name: String, age: uint }

fn main() {
    let john = Person { name: "John".to_string(), age: 42 };
    
    // `john` moves into `john_bis` here
    let john_bis = john;
    
    // so the next line won't compile
    show(john);
}

fn show(person: Person) {
    println!("{} is {}", person.name, person.age);
    
    // `john` will be deallocated here
}
```

# Ownership & Borrowing

When you create a resource, you're the **owner** of that resource.

Being an owner gives you some privileges:

* You control when that resource is deallocated.
* You may lend that resource, **immutably**, to **as many** borrowers as you'd like.
* You may lend that resource, **mutably**, to a **single** borrower.

# Ownership & Borrowing

But it also comes with some restrictions:

* If someone is borrowing your resource (either mutably or immutably), you may not mutate the resource or mutably lend it to someone.
* If someone is mutably borrowing your resource, you may not lend it out at all (mutably or immutably) or access it in any way.

# Borrow

> You may lend that resource, **immutably**, to **as many** borrowers as you'd like.

```rust
struct Person { name: String, age: uint }

fn main() {
    let john = Person { name: "John".to_string(), age: 42 };
    
    // `john` moves into `show`.
    show(&john);
    
    // `show` hands us `john` back.
    show(&john);
    // the previous line will thus compile.
}

fn show(person: &Person) {
    println!("{} is {}", person.name, person.age);
}
```

# Borrow

```norust
John is 42
John is 42
```

# Mutable borrow

> You may lend that resource, **mutably**, to a **single** borrower.

```rust
struct Person { name: String, age: uint }

fn main() {
    let mut john = Person { name: "John".to_string(), age: 42 };
    
    grow_older(&mut john);
    
    show(&john); // John is 43
}

fn grow_older(person: &mut Person) {
    person.age += 1;
}
```

# Mutable borrow

The following will compile too, as `grow_older` gives us `john` back:

```rust
fn main() {
    let mut john = Person { name: "John".to_string(), age: 42 };
    show(&john); // John is 42
    grow_older(&mut john);
    grow_older(&mut john);
    show(&john); // John is 44
}
```

# Mutable borrow

But this won't:

```rust
fn main() {
    let mut john = Person { name: "John".to_string(), age: 42 };

    let mut john_bis = &mut john;

    grow_older(&mut john);
    
    show(&john);
}
```

# Mutable borrow

```norust
error: cannot borrow `john` as mutable more than once at a time
    grow_older(&mut john);
                    ^
note: previous borrow of `john` occurs here; the mutable borrow prevents subsequent moves, borrows, or modification of `p` until the borrow ends
    let mut john_bis = &mut john;
                         ^
note: previous borrow ends here
fn main() {
...
}
^
error: aborting due to previous error
```

# Mutable borrow

```rust
fn main() {
    let mut john = Person { name: "John".to_string(), age: 42 };

    // first borrow of `john` as mutable
    let mut john_bis = &mut john;

    // `john` cannot be mutably borrowed again, won't compile
    grow_older(&mut john);
    
    show(&john);
}
```

# Lifetime annotations

```rust
struct Point { x: f64, y: f64 }

fn get_x(point: &Point) -> &f64 {
    &point.x
}
```

# Lifetime annotations

Until a few weeks ago, `get_x()` had to be written this way:

```rust
fn get_x<'a>(point: &'a Point) -> &'a f64 {
    &point.x
}
```

But in that case, those annotations are now optional.

`'a` represents the lifetime of `point`. We hereby specify that the reference we return must have the same lifetime as `point`.

# Lifetime annotations

This means that code such as

```rust
let mut p = Point { x: 2.0, y: 3.0 };
let x = get_x(&p);

p = Point { x: 4.0, y: 6.0 };
```

will not compile, because `x` outlives the value it is reference from.

# Lifetime annotations

```rust
struct Line { start: &Point, end: &Point }

fn make_line(p1: &Point, p2: &Point) -> Line {
    Line { start: p1, end: p2 }
}

fn main() {
    let p1 = Point { x: 1.0, y: 2.3 };
    let p2 = Point { x: 2.0, y: 5.9 };

    let line = make_line(&p1, &p2);
}
```

> error: missing lifetime specifier

# Lifetime annotations

```rust
struct Line<'a> {
    start: &'a Point,
    end: &'a Point
}

fn make_line<'b>(p1: &'b Point, p2: &'b Point) -> Box<Line<'b>> {
    box Line { start: p1, end: p2 }
}

fn main() {
    let p1 = Point { x: 1.0, y: 2.3 };
    let p2 = Point { x: 2.0, y: 5.9 };

    let line = make_line(&p1, &p2);
}
```

# Net result

* You never have to malloc or free 
* You never have to retain or release 
* Rust will deallocate a value when the current owner is done with it 
* The compiler will guarantee that borrowed values are not stolen

# Net result

* In low-level languages, we allocate and free memory, close sockets, etc.
* In high-level languages, we never free memory, but we routinely close sockets and files, and release locks.
* In Rust we do neither :)

# High-level features

# Lambdas

```rust
    let xs = vec!(1i, 2i, 3i);
    let ys = xs.map(|x| x * 2);

    // ys == [2i, 4i, 6i]
```

# Lambdas

```rust
fn add_one(x: int) -> int {
    x + 1
}

fn apply(x: int, adder: |int| -> int) -> int {
    adder(x)
}
```

# Closures

```rust
    let factor = 8;
    let xs = vec!(1i, 2i, 3i);
    let ys = xs.map(|x| x * factor);
    
    // ys == [8i, 16i, 24i]
```

# Generics

TODO (add to TOC too)

# Traits

* No inheritance in Rust :)
* No interfaces either…
* Instead Rust provides a mechanism called `traits`.

# Traits

A trait is a sort of interface that defines some behavior.
If a type implements a trait, that means that it supports and implements the behavior the trait describes.

# Traits

You can think of them as (better) Java interfaces. They are in fact very similar to Haskell's typeclasses.

One of the main differences is that you can define a trait implementation separately from the struct definition, even in another module. This means that you can eg. implement a trait you defined yourself for a type provided by a library.

They're also much more powerful (but won't get into too much detail here).

# Traits

```rust
struct Rectangle { width: f32, height: f32 }

trait HasArea {
    fn area(&self) -> f32;
}

impl HasArea for Rectangle {
    fn area(&self) -> f32 {
        self.width * self.height
    }
}
```

# Traits

```rust
fn main() {
    let rect = Rectangle {
        width: 1.2,
        height: 4.9
    };
    println!("{}", react.area());
}
```

# Traits

```rust
struct Circle { radius: f32 }

impl HasArea for Circle {
    fn area(&self) -> f32 {
         std::f32::consts::PI * (self.radius * self.radius)
    }
}
```

# Traits

```rust
fn print_area<T>(shape: T) {
    println!("This shape has an area of {}", shape.area());
}
```

> error: type `T` does not implement any method in scope named `area`

# Traits

```rust
fn print_area<T: HasArea>(shape: T) {
    println!("This shape has an area of {}", shape.area());
}
```

# Traits

```rust
fn print_area<T: HasArea>(shape: T) {
    println!("This shape has an area of {}", shape.area());
}

fn main() {
    let c = Circle { radius: 1.0 }
    let r = Rectangle { width: 3.0, height: 2.0 }

    print_area(c);
    print_area(r);
}
```

> This shape has an area of 3.141592654  
> This shape has an area of 6.0

# Traits

```rust
print_area(10i);
```

> error: failed to find an implementation of trait `main::HasArea` for `int`

# Traits

We can implement traits for any type. So this would work, even if it makes no sense:

```rust
impl HasArea for int {
    fn area(&self) -> f64 {
        println!("this is silly");
        *self as f64
    }
}

fn main() {
    10i.area();
    print_area(10i);
}
```

Implementing traits for primitive types should generally be avoided.

# Traits

One restriction:

> Either the trait or the type you're writing the `impl` for must be inside your crate.

# A few built-in traits

```rust
trait ToString {
    fn to_string(&self) -> String;
}

trait ToJson {
    fn to_json(&self) -> Json;
}

trait Equiv<T> {
    fn equiv(&self, other: &T) -> bool;
}
```

# Enums

* Also called `sum types` in the litterature.
* Similar to Haskell's `data` and Scala's `case class`.

```rust
enum Boolean {
    True,
    False
}
```

> Rust's `bool` type is **not** implemented this way as it is a primitive.

# Enums

```rust
enum Boolean {
    True,
    False
}

let b: Boolean = True;
```

A value of type `Boolean` can be either `True` or `False`.

# Enum

From the standard library (almost):

```rust
enum Ordering { Less, Equal, Greater }

fn cmp(a: int, b: int) -> Ordering {
    if      a < b { Less }
    else if a > b { Greater }
    else          { Equal }
}

let ordering = cmp(x, y);

if ordering == Less {
    println!("less");
} else if ordering == Greater {
    println!("greater");
} else if ordering == Equal {
    println!("equal");
}
```

# Pattern matching

Rust provides pattern matching, which lets you rewrite this:

```rust
if ordering == Less {
    println!("less");
} else if ordering == Greater {
    println!("greater");
} else if ordering == Equal {
    println!("equal");
}
```

# Pattern matching

as this:

```rust
match ordering {
    Less    => println!("less"),
    Greater => println!("greater"),
    Equal   => println!("equal")
}
```

# Pattern matching

It also works with primitives:

```rust
let i = 5i;

match i {
    0 => println!("zero"),
    1 => println!("one"),
    _ => println!("> 1")
}
```

# Pattern matching

Patterns must be exhaustive:

```rust
match ordering {
    Less    => println!("less"),
    Greater => println!("greater")
}
```

> error: non-exhaustive patterns: `Equal` not covered [E0004]

# Pattern matching

There's a "catch-all" pattern: `_`.

```rust
match ordering {
    Less => println!("less"),
    _    => println!("not less") 
}
```

> error: non-exhaustive patterns: `Equal` not covered [E0004]

# Back to enums

Enums can also store data. One simple example is the built-in `Option` type. Here's how it is defined in the standard library:

```rust
enum Option<T> {
    None,
    Some(T),
}
```

The type `Option<T>` represents an optional value of type `T`.

An `Option` is either

* `Some`, and contains a value of type `T`
* `None`, and does not contain anything

# Option

```rust
let opt: Option<int> = Some(5);

let opt_plus_two = opt + 2;
```

> error: binary operation `+` cannot be applied to type `core::option::Option<int>`

# Option

To make use of the value inside an `Option`, we must pattern-match on it:

```rust
let opt: Option<int> = Some(5);

let opt_plus_two = match opt {
    Some(x) => x + 2,
    None    => -1
}
```

This forces us to handle the case where there might be no value.

# Option

Options have a number of uses in Rust:

* Initial values
* Return values for functions that are not defined over their entire input range (partial functions)
* Return value for otherwise reporting simple errors, where None is returned on error
* Optional struct fields
* Optional function arguments
* Nullable pointers

# Option

`Option` also provides a few convenience methods:

* `fn is_some(&self) -> bool`
* `fn is_none(&self) -> bool`
* `fn unwrap_or(self, def: T) -> T`
* `fn unwrap(self) -> T` **Use with caution**

# Option

A couple more:

* `fn map<U>(self, f: |T| -> U) -> Option<U>`
* `fn and_then<U>(self, f: |T| -> Option<U>) -> Option<U>`

# Option

```rust
fn get_name() -> Option<String> { /* ... */ }

let name: Option<String> = get_name();

let display_name = name.map(|n| format!("My name is {}", n))
                       .unwrap_or("I don't have a name");

println!(display_name);
```

If `get_name()` returns `Some("Marie")`, this will print `My name is Marie`, and if it returns `None`, this will print `I don't have a name`.

# Iterators


```rust
for x in range(0i, 10i) {
    // do stuff
}
```

This works because `range(0, 10)` returns an `Iterator<int>`.

`Iterator<T>` provides a `next()` function that we can call repeatedly to get a sequence of values, each wrapped in `Some`. When no more values are available, `next()` returns `None`.

# Iterators

The `for` loop on the previous slide can be written like this:

```rust
let mut range = range(0i, 10i);

loop {
    match range.next() {
        Some(x) => {
            println!("{}", x);
        },
        None => { break }
    }
}
```

# Iterators

Vectors can be iterated over too. `Vec<T>` provides an `iter()` method which returns an `Iterator<&T>` that we can use to iterate over the elements.

```rust
let nums = vec![1i, 2i, 3i];

for num in nums.iter() {
    println!("{}", num);
}
```

TODO

# Macros

You have already seen them. `println!()` is a macro. They're distinguishable by the `!` at the end of the function name.

We won't get into too much detail here for lack of time.

# Crates and modules

A "crate" in Rust is what you'd call a "package" or "library" in other languages. A crate contains modules (which can contain other modules).

If we have a `greetings` crate that contains a public module `english` that defines a public method `hello()`, we'd use it like this:

```rust
extern crate greetings;

fn main() {
  greetings::english::hello();
}
```
# Modules

The `use` keyword imports names in the local scope.

```rust
extern crate greetings;
use greetings::english;

fn main() {
  english::hello();
}
```

# Cargo

Cargo is Rust's package manager. It:

* gets and compiles external dependencies
* builds your projects
* runs your tests

Use Cargo for all your projects.

# Starting a project

```
$ cargo new hello_world --bin
```

The `--bin` flag indicates you're making a binary, not a library.

This generates a package description file, `Cargo.toml`, where you declare the project's dependencies and metadata.

```
[package]

name = "hello_world"
version = "0.0.1"
authors = ["Your Name <you@example.com>"]
```

# Compiling your project

`src/main.rs`:

```rust
fn main() {
    println!("Hello, world!")
}
```

`cargo build` to build or `cargo run` to build and run your project

```norust
$ cargo run
   Compiling hello_world v0.0.1 (file:///path/to/hello_world)
     Running `target/hello_world`
Hello, world!
```

# Thank you!

Questions?

# References

* http://doc.rust-lang.org/reference.html
* http://www.slideshare.net/saneyuki/rusts-ownership-and-move-semantics
* http://www.infoq.com/news/2012/08/Interview-Rust
* http://theincredibleholk.wordpress.com/2012/05/30/safe-parallelism-in-rust/
* http://blog.skylight.io/rust-means-never-having-to-close-a-socket/
* https://s3.amazonaws.com/f.cl.ly/items/351X3I3z0M1E251x3V1p/Hello%20Rust.pdf
* http://lea-linux.org/documentations/Rust

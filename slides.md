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
* Thus needed a safer, saner systems language, with built-in concurrency

# Why Rust, for you?

* High-level features
* Low-level control
* Powerful Foreign Function Interface
* Direct memory control
* Guaranteed memory safety
* Concurrency without data races
* Zero cost abstractions

# High-level features

* Algebraic data types
* Pattern matching
* Higher-order functions
* Closures
* Traits (= type classes)
* Type inference

# Low-level control

* Ability to trade compiler-enforced safety for lower-level control
* Eg. dereferencing raw pointer, pointer arithmetic, calling extern code
* Such unsafe code must be surrounded by an `unsafe` block
* Thus easy to spot during code review or when debugging

# Powerful FFI

* Call Rust code from other languages (C, C++, or even GCed languages like Ruby)
* Create bindings for libraries exposing a C interface

# Direct memory control

* No garbage collector
* No runtime overhead
* No unpredictable pauses in execution
* TODO: Stack VS Heap

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
    // the next line thus doesn't compile
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
    
    // the next line thus won't compile
    show(john);
}

fn show(person: Person) {
    println!("{} is {}", person.name, person.age);
    
    // `john` will be deallocated here
}
```

# Ownership & Borrowing

When you create a resource, you're the **owner** of that resource.

Being an owner affords you some privileges:

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

# Net result

* You never have to malloc or free 
* You never have to retain or release 
* Rust will deallocate a value when the current owner is done with it 
* The compiler will guarantee that borrowed values are not stolen

# Net result

* In low-level languages, we allocate and free memory, close sockets, etc.
* In high-level languages, we never free memory, but we routinely close sockets and files, and release locks.
* In Rust we do neither :)

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
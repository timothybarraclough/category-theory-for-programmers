//: [Previous](@previous)
//: ## Chapter 2: Types and Functions
//: ___
//: ### 1. Define a higher-order function (or a function object) memoize in your favorite language. This function takes a pure function f as an argument and returns a function that behaves almost exactly like f, except that it only calls the original function once for every argument, stores the result internally, and subsequently returns this stored result every time it’s called with the same argument. You can tell the memoized function from the original by watching its performance. For instance, try to memoize a function that takes a long time to evaluate. You’ll have to wait for the result the first time you call it, but on subsequent calls, with the same argument, you should get the result immediately.
//: ___

/// Writing this as a property wrapper, with the ability to call it as
/// a function gives us a super clean syntax for memozing functions.
/// The requirement here is that your Source object must be hashable
/// to fulfill the requirement that we can store it in a Dictionary.
class Memoized<A: Hashable,B> {

    let wrappedValue: (A) -> B
    var computedResults: Dictionary<A,B> = [:]

    init(_ wrappedValue: @escaping (A) -> B) {
        self.wrappedValue = wrappedValue
    }

    func callAsFunction(_ a: A) -> B {
        if let result = computedResults[a] { return result }
        let result = wrappedValue(a)
        computedResults[a] = result
        print(computedResults)
        return result
    }
}

/// Add two numbers together, while printing to std::out
/// - Parameters:
///   - x: 1st number
///   - y: 2nd number
/// - Returns: The result of adding the two numbers
func addFiveWithSideEffect(_ x: Int) -> Int {
    print("Adding 5 to \(x)")
    return 5 + x
}

var memoizedAdder = Memoized<Int,Int>(addFiveWithSideEffect)
// Calling these functions will only execute the side effect (printing to the console)
// once per argument.
memoizedAdder(10)
memoizedAdder(10)
memoizedAdder(10)
memoizedAdder(10)

//: ___
//: ### 2. Try to memoize a function from your standard library that you normally use to produce random numbers. Does it work?
//: ___

// var memoizedRandom = Memoized<(),Int>(Int.random(in: 0..<10))

// This code gives this warning:
// 🛑 Type '()' does not conform to protocol 'Hashable'

// This makes sense because code that produces side effects can't be reliably memoized.

//: ___
//: ### 3. Most random number generators can be initialized with a seed. Implement a function that takes a seed, calls the random number generator with that seed, and returns the result. Memoize that function. Does it work?
//: ___
func curriedRNG(range: ClosedRange<Int>) -> (SystemRandomNumberGenerator) -> Int {
    return { rng in
        var rng = rng
        return Int.random(in: range, using: &rng) }
}

let randomZeroToTen = curriedRNG(range: 0...10)



//Memoized(randomZeroToTen)

//: ___
//: ### 4. Which of these C++ functions are pure? Try to memoize them and observe what happens when you call them multiple times: memoized and not.

//: The factorial function from the example in the text:
//:```
//:int fact(int n) {
//:    int i;
//:    int result = 1;
//:    for (i = 2; i <= n; ++i)
//:        result *= i;
//:    return result;
//:}
//:```
func fact(_ n: Int) -> Int {
    var result = 1
    for i in 2..<n { result *= i }
    return result
}

let mem = Memoized<Int,Int>(fact)
mem(100)
mem(100)
//: ___
//:```
//:std::getchar()
//:```
//:This is impure because the type signature indicates it moves from IO -> Char. The only way for this to be pure was if it was a function that returned the same output every time.
//: ___
//:```
//:bool f() {
//:    std::cout << "Hello!" << std::endl;
//:    return true;
//:}
//:```
//: Writing to standard out is a side effect.  Memoizing this prevents the effect from running multiple times.  A way to solve this would be to do something like:
func f() -> (Bool, String) {
    return (true, "Hello!")
}
//: ___
//:```
//:int f(int x)
//:{
//:    static int y = 0;
//:    y += x;
//:    return y;
//:}
//:```

//: This is impure as storing the value into y is considered a side effect.  Running this value multiple times with the same input will result in different outputs.
//: ___
//: ### 5. How many different functions are there from Bool to Bool? Can you implement them all?
//: ___

// Flip the input
// T -> F
// F -> T
func flip(_ x: Bool) -> Bool { !x }
// Identity
// T -> T
// F -> F
func id(_ x: Bool) -> Bool { x }
// Always true
// T -> T
// F -> T
func `true` ( _ :Bool) -> Bool { true }
// Always false
// T -> F
// F -> F
func `false`( _ :Bool) -> Bool { false }

//: If `Bool` can be considered the set of 2 elements,
//: and the function can be expressed exponentially
//: then the totality is expressed as - Domain ^ Codomain
//: or 2 ^ 2 = 4 possible implementations.

//: ___
//: ### 6. Draw a picture of a category whose only objects are the types Void, () (unit), and Bool; with arrows corresponding to all possible functions between these types. Label the arrows with the names of the functions.
//: ___



// () -> Bool :: Const / True / False

// Bool -> () :: Unit
// generalized to
func unit<A>( _: A) -> () { }
// Never -> Bool :: Absurd
// Never -> () :: Absurd
// generalized to
func absurd<A>( _ n: Never) -> A { }

// () -> Never :: fatalError
// Bool -> Never :: fatalError

//: ___
//: [Next](@next)

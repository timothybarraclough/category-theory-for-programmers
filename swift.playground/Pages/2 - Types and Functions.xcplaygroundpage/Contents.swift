//: [Previous](@previous)
//: ## Chapter 2: Types and Functions
//: ___
//: ### 1. Define a higher-order function (or a function object) memoize in your favorite language. This function takes a pure function f as an argument and returns a function that behaves almost exactly like f, except that it only calls the original function once for every argument, stores the result internally, and subsequently returns this stored result every time it’s called with the same argument. You can tell the memoized function from the original by watching its performance. For instance, try to memoize a function that takes a long time to evaluate. You’ll have to wait for the result the first time you call it, but on subsequent calls, with the same argument, you should get the result immediately.
//: ___

//: ___
//: ### 2. Try to memoize a function from your standard library that you normally use to produce random numbers. Does it work?
//: ___

//: ___
//: ### 3. Most random number generators can be initialized with a seed. Implement a function that takes a seed, calls the random number generator with that seed, and returns the result. Memoize that function. Does it work?
//: ___

//: ___
//: ### 4. Which of these C++ functions are pure? Try to memoize them and observe what happens when you call them multiple times: memoized and not.
/*:
The factorial function from the example in the text.
```
std::getchar()
bool f() {
    std::cout << "Hello!" << std::endl;
    return true;
}
int f(int x)
{
    static int y = 0;
    y += x;
    return y;
}
```
 */

//: ___
//: ### 5. How many different functions are there from Bool to Bool? Can you implement them all?
//: ___

//: ___
//: ### 6. Draw a picture of a category whose only objects are the types Void, () (unit), and Bool; with arrows corresponding to all possible functions between these types. Label the arrows with the names of the functions.
//: ___

//: ___
//: [Next](@next)

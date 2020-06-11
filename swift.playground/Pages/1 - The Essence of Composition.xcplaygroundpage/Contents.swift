//: ## Chapter 1: Category - The Essence of Composability
//: 1. Implement, as best as you can, the identity function in your favorite language (or the second favorite, if your favorite language happens to be Haskell).
//: ___

import Foundation

/// The identity function, generic over A, using implicit returns
/// - Parameter element: An element of Set of A
/// - Returns The same element from the Set of A
func id<A>( _ element: A) -> A { element }
//: ___
//: 2. Implement the composition function in your favorite language. It takes two functions as arguments and returns a function that is their composition.
//: ___

/// The higher order function that takes two functions and returns their composition.
/// Each parameter requires the escaping modifier as the closures are not executed within the function body
/// This would be read as "the composition of g after f"
/// - Parameters:
///   - f: The first function
///   - g: The second function
func compose<A,B,C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
    return { a in g(f(a)) }
}

/*:
 We can go further and define this as an operator, "•",  that relies on the above function under the hood.
 Take note that the order of arguments has been flipped though - this makes it read mathematically correct.
 e.g.
 g • f = "the composition of g after f"
 */

infix operator •

/// Function composition defined as an operator
/// - Parameters:
///   - g: The function to be applied second
///   - f: The function to be applied first
func •<A,B,C>(_ g: @escaping (B) -> C, _ f: @escaping (A) -> B) -> (A) -> C {
    return compose(f,g)
}

//: ___
//: ### 3. Write a program that tries to test that your composition function respects identity.
//: ___

/// A curried version of an adder
/// - Parameter x: the amount you would like to add
/// - Returns a function that will add that amount to the argument
func add( _ x: Int) -> (Int) -> Int {
    return { y in x + y }
}

let addFive = add(5)
let fAfterId = addFive • id
let idAfterF = id • addFive

// Identity law
assert(
    /// f • id = id • f
    fAfterId(3) == idAfterF(3)
)

assert(
    /// f • id = f
    fAfterId(10) == addFive(10)
)

// Associativity law

let addThree = add(3)
let addTwo = add(2)
let leftAssociative = (addFive • addThree) • addTwo
let rightAssociative = addFive • (addThree • addTwo)

assert(
    // (h • g) • f == h • (g • f)
    leftAssociative(400) == rightAssociative(400)
)

// This one is trivially true:
// In the future we should use a precedence group to make sure that the compiler
// is able to understand how these things compose when we don't have parens
//: ### 4. Is the world-wide web a category in any sense? Are links morphisms?
//:The world wide web is kind of a category.  However links cannot be defined as morphisms because they don't really compose.  For example, a link from one webpage to another cannot be composed with another link in order to build a link from the first to the third webpage, however the outcome of clicking these links is functionally identical.
//: ### 5. Is Facebook a category, with people as objects and friendships as morphisms?
//:I am not sure that friends via Facebook compose.  For example, a friend of a friend isn't necessarily a friend of mine.
//: ### 6. When is a directed graph a category?
//:A directed graph forms a category if each node has an arrow to itself, and if the arrows themselves are able to be composed.

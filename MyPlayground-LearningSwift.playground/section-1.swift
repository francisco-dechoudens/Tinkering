// Playground - noun: a place where people can play

import UIKit

var numbers = [2, 1, 7, 9]

numbers.map(
    {
        (number: Int) -> Int in
        let result = 3 * number
        return result
    }
)
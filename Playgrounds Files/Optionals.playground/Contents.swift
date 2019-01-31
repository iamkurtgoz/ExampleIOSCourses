//: Playground - noun: a place where people can play

import UIKit

var myName : String?


myName?.uppercased()

// optionals: ? vs !


var myAge = "10"
var kati = Int(myAge)! * 5;


if let number = Int(myAge) {
    let myResult = number * 5
    print(myResult)
}








import Foundation

func squareRootNewtonMethod(_ temp: Double)->Double {
    var epsilon:Double
    var t:Double
    var c:Double
    
    epsilon=8.854*pow(10.00,-12.00)
    c=temp//given number
    t=c
    while abs(t-(c/t)) > epsilon*t {
        t=((c/t)+t)/2.00
    }
    return t
}

var number:Double
print("Enter the number")
var tempA=readLine()
number=Double(tempA!)!
var squareRoot=squareRootNewtonMethod(number)
print("Square root of \(number) is \(squareRoot)")





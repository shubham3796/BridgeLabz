import Foundation

func monthlyPayment()->Double {
var payment:Double
var n:Double//number of months
var r:Double//equivalent rate monthwise
var Y:Double//number of years
var R:Double//interest rate
var P:Double//principal amount
    
    print("Enter 'P', the Principal amount")
    var tempA=readLine()
    P=Double(tempA!)!
    
    print("Enter 'Y', the number of years")
     tempA=readLine()
    Y=Double(tempA!)!
    
    print("Enter 'R', the interest rate")
     tempA=readLine()
    R=Double(tempA!)!
    
    n=12.00*Y
    r=R/1200.00
    var tempB=1.00-pow((1.00+r),(-1.00*n))
    payment = (P*r)/tempB
    
    return payment
}

var pay=monthlyPayment()
print("Monthly Payment=\(pay)")

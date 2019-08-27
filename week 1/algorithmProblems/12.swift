import Foundation

class Temperature{
    var tempF:Float = 0.0 //Tempertaure in degree Farenheit
    var tempC:Float = 0.0//Tempertaure in degree Celcius
    static func fToC(_ temp:inout Float) -> Float{//Converts Farenheit to celcius, takes fahrenheit temperature as input, returns Celcius temperature
    var temperatureF=temp
    var temperatureC = ((temperatureF-32)*5)/9
    return temperatureC
}
    
    static func cToF(_ temp:inout Float) -> Float{//Converts Farenheit to celcius, takes fahrenheit temperature as input, returns Celcius temperature
        var temperatureC=temp
        var temperatureF = 32.00 + (temperatureC*(9/5))
        return temperatureF
    }
    
}

print("Enter the Farenheit temperature to be changed to celcius:")
var tempA=readLine()
var temperatureF=Float(tempA!)!
var temperatureC=Temperature.fToC(&temperatureF)
print("This is equavalent to \(temperatureC) degree celcius")

print("Enter the celcius temperature to be changed to Frenheit:")
 tempA=readLine()
 temperatureC=Float(tempA!)!
 temperatureF=Temperature.cToF(&temperatureC)
print("This is equavalent to \(temperatureF) degree Farenheit")

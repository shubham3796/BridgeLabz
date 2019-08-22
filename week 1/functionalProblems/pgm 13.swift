import Foundation

class Time{
    var min=0
    var sec=0
    var msec=0
}

let start=Time()
let end=Time()

print("Enter starting time of stopwatch in Min,Sec,Millisec")
var temp=readLine()
start.min=Int(temp!)!
 temp=readLine()
start.sec=Int(temp!)!
temp=readLine()
start.msec=Int(temp!)!

print("Enter ending time of stopwatch in Min,Sec,Millisec")
 temp=readLine()
end.min=Int(temp!)!
temp=readLine()
end.sec=Int(temp!)!
temp=readLine()
end.msec=Int(temp!)!

var noMin=0
var noSec=0
var noMsec=0

noMin=end.min-start.min-1
if end.sec<start.sec{
    noSec=60+(end.sec-start.sec)
}
else {
    if(end.msec>start.msec)
    {
        noSec=end.sec-start.sec-1
    }
    else{
        noSec=end.sec-start.sec+599
        
    }
}
if end.msec<start.msec{
    noMsec=60+(end.msec-start.msec)
}
else {
    noMsec=end.msec-start.msec-1
}

print("\(noMin) MINUTES   \(noSec) SECONDS   \(noMsec) MILLI SECONDS PASSED")

//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

var negInf = Int.max

var test = -1 * negInf


//func scrub(val: Int) -> Int
//{
//    var val = val
//    var size = 0
//    var t = 0
//    while (val > 0)
//    {
//        if(t == 0)
//        {
//            t = val % 10
//        }
//        val = val / 10
//        size += 1
//    }
//    
//    t
//    size
//    t + size // cutoff 4?
//    return val
//}


func scrub(correct: Int, extra: Int) -> Int
{
    if(correct + extra < 4)
    {
        return 0
    }
    else
    {
        
        return Int(pow(Double(10), Double(correct - 1))) + extra
    }
}


scrub(correct: 4, extra: 3)





var arr = [Int?]()
for i in 0..<7
{
    arr.append(nil)
}

let order = [5,3,1,0,2,4,6]

for i in 0..<7
{
    let orderi = order[i]
    arr[orderi] = i
}

arr



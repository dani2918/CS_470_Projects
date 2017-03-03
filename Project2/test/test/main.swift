////
////  main.swift
////  test
////
////  Created by Matt Daniel on 2/28/17.
////  Copyright © 2017 Matthew Daniel. All rights reserved.
////
//
import Foundation
//
//
func queues() -> (Int, Int)
{
    var queue = Array(repeatElement(DispatchQueue(label: "test", qos: DispatchQoS.utility), count: 7))
    
    let queue1 = DispatchQueue(label: "test", qos: DispatchQoS.utility)
    let queue2 = DispatchQueue(label: "test", qos: DispatchQoS.userInteractive)
    
    var sem1 = true
    var sem2 = true
    var j = 0
    var k = 0
//    queue1.async
//        {
//            
//            for i in 0..<10000
//            {
//                j += i
//            }
//            print("🛑",j)
//            sem1 = false
//    }
//    
//    queue2.async
//        {
//            for i in 100..<300
//            {
//                k += i
//            }
//            print("❎",k)
//            sem2 = false
//    }
    for i in 0..<7
    {
        queue[i].async {
            for i in 0..<10000
            {
                j += i
            }
            print("🛑",j)
            

        }
    }
    while(sem1)
    {
        
    }
    return(j,k)
}

let l = queues()
print ("l is ", l)





let block = DispatchWorkItem
{
    
}



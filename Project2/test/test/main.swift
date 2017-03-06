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
func queues() -> (Int, [Int])
{
    let queue = DispatchQueue(label: "test", qos: .userInitiated, attributes: .concurrent)
    let group = DispatchGroup()
//    let queue2 = DispatchQueue(label: "test", qos: DispatchQoS.userInteractive)
    
    
    
    var sem1 = true
    var sem2 = true
    var j = 0
    var k = Array(repeatElement(0, count: 7))
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
//    for i in 0..<7
//    {
//        queue1.async {
//            for i in 0..<10000
//            {
//                j += i
//            }
//            print(i)
//            print("🛑",j)
//            
//
//        }
//        
//    }
//    
//    while(sem1)
//    {
//        
//    }
    
    for i in 0..<7
    {
        queue.async(group: group)
        {
            for index in 0..<10000
            {
                k[i] += index * i
            }
//            print("🛑",j)
//            k.append(j)
        }
    }
    
    group.notify(queue: queue)
    {
        print("done")
        sem1 = false
    }
//    while(sem1)
//    {
//        
//    }
    let _ = group.wait()
    return(j,k)
    
}

let l = queues()
print ("l is ", l)





let block = DispatchWorkItem
{
    
}

let v = Double(Int.max)
print(v)



//: Playground - noun: a place where people can play

import Cocoa
var size = 3
let modSize = 100000
var closedList = Array(repeating: Array(repeating: [[Int]](), count: 0), count: modSize)
//print("done")
var gameBoard = [[1,2,4], [3,5,6], [7,8,0], []]
gameBoard = [[3,1,2],[0,4,5],[6,7,8]]

//var closedList = [[[Int]]]()

//closedList[0] = [[1,2],[3,4]]
//closedList[0].append([[1,2],[3,4]])
//closedList[0].append([[5,6],[7,8]])
closedList[40213].append([[3,1,2],[0,4,5],[6,7,8]])
print(closedList[0])
print(closedList.count)



func checkBoardsEqual(cl: [[[Int]]]) -> Bool
{
    print(cl)
    if(cl.count == 0)
    {
        return false
    }
    
    var flag = true
    for i in 0..<cl.count
    {
        flag = true
        for j in 0..<size
        {
            for k in 0..<size
            {
//                print("\(gameBoard[j][k]), \(closedList[i][j][k])")
                if(gameBoard[j][k] != cl[i][j][k])
                {
                    flag = false
                }
            }
            
        }
        if(flag == true)
        {
            //                print("***********")
            //                print("Equal Boards")
            //                printBoard()
            //                print("***********")
            return true
        }
    }
    if(flag == true)
    {
        print("Equal Boards")
    }
    return flag
    
}





func hash(hashVals: [[[[Int]]]], modSize: Int) -> Bool
{
    var hashVal = 0
    var count = 0
    for i in 0..<size
    {
        for j in 0..<size
        {
            hashVal += gameBoard[i][j] * Int(pow(Double(10), Double(count)))
            count += 1
        }
    }
    hashVal = hashVal % modSize
    //        printBoard()
//            print(hashVal)
    //        if(hashVals.contains(hashVal))
    //        {
    //            return true
    //        }
    //        else
    //        {
    //            return false
    //        }
    if(checkBoardsEqual(cl: hashVals[hashVal]))
    {
        return true
    }
    else
    {
        return false
    }
    
}


hash(hashVals: closedList, modSize: 100000)


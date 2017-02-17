//////: Playground - noun: a place where people can play
////
import Cocoa
import Foundation
////var size = 3
////let modSize = 100000
////var closedList = Array(repeating: Array(repeating: [[Int]](), count: 0), count: modSize)
//////print("done")
////var gameBoard = [[1,2,4], [3,5,6], [7,8,0], []]
////gameBoard = [[3,1,2],[0,4,5],[6,7,8]]
////
//////var closedList = [[[Int]]]()
////
//////closedList[0] = [[1,2],[3,4]]
//////closedList[0].append([[1,2],[3,4]])
//////closedList[0].append([[5,6],[7,8]])
////closedList[40213].append([[3,1,2],[0,4,5],[6,7,8]])
////print(closedList[0])
////print(closedList.count)
////
////
////
////func checkBoardsEqual(cl: [[[Int]]]) -> Bool
////{
////    print(cl)
////    if(cl.count == 0)
////    {
////        return false
////    }
////    
////    var flag = true
////    for i in 0..<cl.count
////    {
////        flag = true
////        for j in 0..<size
////        {
////            for k in 0..<size
////            {
//////                print("\(gameBoard[j][k]), \(closedList[i][j][k])")
////                if(gameBoard[j][k] != cl[i][j][k])
////                {
////                    flag = false
////                }
////            }
////            
////        }
////        if(flag == true)
////        {
////            //                print("***********")
////            //                print("Equal Boards")
////            //                printBoard()
////            //                print("***********")
////            return true
////        }
////    }
////    if(flag == true)
////    {
////        print("Equal Boards")
////    }
////    return flag
////    
////}
////
////
////
////
////
////func hash(hashVals: [[[[Int]]]], modSize: Int) -> Bool
////{
////    var hashVal = 0
////    var count = 0
////    for i in 0..<size
////    {
////        for j in 0..<size
////        {
////            hashVal += gameBoard[i][j] * Int(pow(Double(10), Double(count)))
////            count += 1
////        }
////    }
////    hashVal = hashVal % modSize
////    //        printBoard()
//////            print(hashVal)
////    //        if(hashVals.contains(hashVal))
////    //        {
////    //            return true
////    //        }
////    //        else
////    //        {
////    //            return false
////    //        }
////    if(checkBoardsEqual(cl: hashVals[hashVal]))
////    {
////        return true
////    }
////    else
////    {
////        return false
////    }
////    
////}
////
////
////hash(hashVals: closedList, modSize: 100000)
//
//
//var list = [Int]()
//var x: Int
//list.append(1)
//list.append(2)
//
//
//
//x = list.first!
//list.removeFirst()
//list
//
//list.append(3)
//list.append(4)
//
//x = list.first!
//list.removeFirst()
//list
//
//
//
//
//
//
//







// A STAR CUT OUT FOR LOOP



//
//            if(board.moveDirection(dir: "north"))
//            {
//                if(!board.checkEqualToParent())
//                {
//                    let northBoard = Board(gb: board.tmpBoard, p: board)
//                    //print("north calc cost is: \(northBoard.calcCost(herusticNo: hn))")
//                    northBoard.cost = northBoard.calcCost(herusticNo: hn) + depth //+ board.cost!
//                    let newCost = northBoard.cost
//                    if openList.count == 0
//                    {
//                        openList.append(northBoard)
//                    }
//                    else
//                    {
//                        for i in 0...openList.count
//                        {
//                            if(i == openList.count)
//                            {
//                                openList.insert(northBoard, at: i)
//                            }
//                            else if(openList[i].cost! > newCost!)
//                            {
//                                if (i == 0)
//                                {
//                                    openList.insert(northBoard, at: i)
//                                }
//                                else
//                                {
//                                    openList.insert(northBoard, at: i-1)
//                                }
//                                break
//                            }
//
//                        }
//                    }
//                }
//            }
//            if(board.moveDirection(dir: "east"))
//            {
//                if(!board.checkEqualToParent())
//                {
//                    let eastBoard = Board(gb: board.tmpBoard, p: board)
//                    //print("east calc cost is: \(eastBoard.calcCost(herusticNo: hn))")
//                    eastBoard.cost = eastBoard.calcCost(herusticNo: hn) + depth //board.cost!
//                    let newCost = eastBoard.cost
//                    if openList.count == 0
//                    {
//                        openList.append(eastBoard)
//                    }
//                    else
//                    {
//                        for i in 0...openList.count
//                        {
//                            if(i == openList.count)
//                            {
//                                openList.insert(eastBoard, at: i)
//                            }
//                            else if(openList[i].cost! > newCost!)
//                            {
//                                if (i == 0)
//                                {
//                                    openList.insert(eastBoard, at: i)
//                                }
//                                else
//                                {
//                                    openList.insert(eastBoard, at: i-1)
//                                }
//                                break
//                            }
//                        }
//                    }
//                }
//            }
//            if(board.moveDirection(dir: "south"))
//            {
//                if(!board.checkEqualToParent())
//                {
//                    let southBoard = Board(gb: board.tmpBoard, p: board)
//                    //print("south calc cost is: \(southBoard.calcCost(herusticNo: hn))")
//                    southBoard.cost = southBoard.calcCost(herusticNo: hn) + depth //board.cost!
//                    let newCost = southBoard.cost
//                    if openList.count == 0
//                    {
//                        openList.append(southBoard)
//                    }
//                    else
//                    {
//                        for i in 0...openList.count
//                        {
//                            if(i == openList.count)
//                            {
//                                openList.insert(southBoard, at: i)
//                            }
//                            else if(openList[i].cost! > newCost!)
//                            {
//                                if(i == 0)
//                                {
//                                   openList.insert(southBoard, at: i)
//                                }
//                                else
//                                {
//                                    openList.insert(southBoard, at: i-1)
//                                }
//                                break
//                            }
//
//                        }
//                    }
//                }
//            }
//            if(board.moveDirection(dir: "west"))
//            {
//                if(!board.checkEqualToParent())
//                {
//                    let westBoard = Board(gb: board.tmpBoard, p: board)
//                    //print("west calc cost is: \(westBoard.calcCost(herusticNo: hn))")
//                    westBoard.cost = westBoard.calcCost(herusticNo: hn) + depth //board.cost!
//                    let newCost = westBoard.cost
//                    if openList.count == 0
//                    {
//                        openList.append(westBoard)
//                    }
//                    else
//                    {
//                        for i in 0...openList.count
//                        {
//                            if(i == openList.count)
//                            {
//                                openList.insert(westBoard, at: i)
//                            }
//                            else if(openList[i].cost! > newCost!)
//                            {
//                                if (i == 0)
//                                {
//                                   openList.insert(westBoard, at: i)
//                                }
//                                else
//                                {
//                                    openList.insert(westBoard, at: i-1)
//                                }
//                                break
//                            }
//                        }
//                    }
//                }
//            }











// DFS CUT OUT FOR LOOP

//                if(board.moveDirection(dir: "north"))
//                {
//                    if(!board.checkEqualToParent())
//                    {
//                        let northBoard = Board(gb: board.tmpBoard, p: board)
//                        openList.append(northBoard)
//                    }
//                }
//                if(board.moveDirection(dir: "east"))
//                {
//
//                    if(!board.checkEqualToParent())
//                    {
//                        let eastBoard = Board(gb: board.tmpBoard, p: board)
//                        openList.append(eastBoard)
//                    }
//                }
//                if(board.moveDirection(dir: "south"))
//                {
//
//                    if(!board.checkEqualToParent())
//                    {
//                        let southBoard = Board(gb: board.tmpBoard, p: board)
//                        openList.append(southBoard)
//                    }
//                }
//                if(board.moveDirection(dir: "west"))
//                {
//
//                    if(!board.checkEqualToParent())
//                    {
//                        let westBoard = Board(gb: board.tmpBoard, p: board)
//                        openList.append(westBoard)
//                    }
//                }






/// DFS REMOVED
//            if(board.moveDirection(dir: "north"))
//            {
//                if(!board.checkEqualToParent())
//                {
//                    let northBoard = Board(gb: board.tmpBoard, p: board)
//                    openList.insert(northBoard, at: openList.startIndex)
//                }
//            }
//            if(board.moveDirection(dir: "east"))
//            {
//
//                if(!board.checkEqualToParent())
//                {
//                    let eastBoard = Board(gb: board.tmpBoard, p: board)
//                    openList.insert(eastBoard, at: openList.startIndex)
//                }
//            }
//            if(board.moveDirection(dir: "south"))
//            {
//
//                if(!board.checkEqualToParent())
//                {
//                    let southBoard = Board(gb: board.tmpBoard, p: board)
//                    openList.insert(southBoard, at: openList.startIndex)
////                    openList.append(southBoard)
//                }
//            }
//            if(board.moveDirection(dir: "west"))
//            {
//
//                if(!board.checkEqualToParent())
//                {
//                    let westBoard = Board(gb: board.tmpBoard, p: board)
//                    openList.insert(westBoard, at: openList.startIndex)
////                    openList.append(westBoard)
//                }
//            }

var x = [1]

//print(x.count)


var val = 3

var found = false
var min = 0
var max = x.count - 1
var avg = (max-min)/2

while(true)
{
    var avg = Int((max+min)/2)
    if(x[avg] == val)
    {
        print( avg)
        break
    }
    else if (min > max)
    {
        print(min)
        print(max)
        print(avg)
        break
    }
    else
    {
        if(x[avg] > val)
        {
            max = avg - 1
        }
        else
        {
            min = avg + 1
        }
    }
}

x





//
//  astar.swift
//  Project1Graphical
//
//  Created by Matt Daniel on 2/16/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Foundation

class AStar
{
    var openList = [Board]()
    var movesList = [Board]()
    var solvedBoard: Board
    var head: Board
    var board: Board
    var parent: Board?
    var modSize: Int
    var heruisticNo: Int
    let direction = ["north", "east", "south", "west"]
    var closedListBool = [Int]()
    
    
    init(start: Board, hn: Int)
    {
        head = start
        board = head
        modSize = 5000 * Int(pow(Double(10), Double(board.size)))
        solvedBoard = start
        openList = []
        closedListBool = []
        movesList = []
        start.cost = start.calcCost(herusticNo: hn)
        openList.append(start)
        heruisticNo = 1
    }
    
    func solve(hn: Int) -> [Board]
    {
        print("modsize is: \(modSize)")
        heruisticNo = hn
        var closedList = Array(repeating: Array(repeating: [[Int]](), count: 0), count: modSize)
        
        movesList = []
        var closedListCount = 0
        let start = NSDate()
        
        // Swift construct for do-while
        repeat
        {
            // Pop the boards off the open list until we find
            // one NOT on the closed list
            repeat
            {
                board = openList.first!
                openList.removeFirst()
                
                // If we're not using a closed list, only pop first elt
            }while(board.hash(hashVals: closedList, modSize: modSize))
            
            closedList[board.hashVal].append(board.gameBoard)
            closedListCount += 1
            let depth = board.depth

            // Add moves for N,S,E,W to the list, if they're legal
            for dir in direction
            {
                if(board.moveDirection(dir: dir))
                {
                    if(!board.checkEqualToParent())
                    {
                        let newBoard = Board(gb: board.tmpBoard, p: board)
                        newBoard.cost = newBoard.calcCost(herusticNo: hn) + depth + 1 //+ board.cost!
                        let newCost = newBoard.cost
                        if openList.count == 0
                        {
                            openList.append(newBoard)
                        }
//                            openList.sort(by: { $0.cost! > $1.cost! })
                         // TODO: Write a function that finds the index to insert faster
                        else
                        {
                            var index = findInsertion(ol: openList, val: newCost!) - 1
                            if(index < 0)
                            {
                                index = 0
                            }
                            for i in index...openList.count
                            {
                                if(i == openList.count)
                                {
                                    openList.insert(newBoard, at: i)
                                }
                                else if(openList[i].cost! >= newCost!)
                                {
                                    
                                    if (i == 0)
                                    {
                                        openList.insert(newBoard, at: i)
                                    }
                                    else
                                    {
                                        openList.insert(newBoard, at: i-1)
                                    }
                                    break
                                }
                            }
                        }
                    }
                }
            }
            
            // Information that prints to console to let you see the progress of the algorithm.
            // Mostly useful for debugging purposes, but also interesting
            if(closedListCount % 250 == 0)
            {
                print("\nExamined list size: \(closedListCount)")
                
                // Prints time since search started
                let end = NSDate()
                let timeSince: Double = end.timeIntervalSince(start as Date)
                let time = String(format: "%.02f", timeSince)
                print("Est cost left: \(board.calcCost(herusticNo: hn))")
                print("\(time) seconds\n")
                
            }
            if(openList.count % 10000 == 0)
            {
                print("Open list size: \(openList.count)")
            }
            // Keep going until we find a solved board
        } while(!board.checkBoard())
        solvedBoard = board
        
        // Insert the parents of the solution to the list of
        // moves that solve the initial state
        var count = 0
        while (board.parent != nil)
        {
            movesList.insert(board, at: movesList.startIndex)
            board = board.parent!
            count += 1
        }
        
        // Print some final statistics
        print("Closed List Size: \(closedListCount)")
        let end = NSDate()
        let timeSince: Double = end.timeIntervalSince(start as Date)
        let time = String(format: "%.02f", timeSince)
        print("\(time) seconds\n")
        print("Moves: \(count)")
        
        closedList.removeAll()
        return movesList
    }
    func getBoard() -> Board
    {
        return board
    }
    func getSolvedBoard() -> Board
    {
        return solvedBoard
    }
    
    // Unfinished
    func findInsertion(ol: [Board], val: Int) -> Int
    {
        var found = false
        var min = 0
        var max = openList.count - 1
        while(true)
        {
            var avg = Int((max+min)/2)
            if(ol[avg].cost! == val)
            {
                return avg
//                break
            }
            else if (min > max)
            {
//                print(min)
//                print(max)
//                print(avg)
//                break
                return avg
            }
            else
            {
                if(ol[avg].cost! > val)
                {
                    max = avg - 1
                }
                else
                {
                    min = avg + 1
                }
            }
        }
    }
}

//
//  dfs.swift
//  Project1Graphical
//
//  Created by Matt Daniel on 2/16/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Foundation

class DFS
{
    var openList = [Board]()
    var closedList = [[[[Int]]]]()
    var movesList = [Board]()
    var solvedBoard: Board
    var savedBoard: Board
    var parent: Board?
    var modSize: Int
    var numMoves: Int
    var startTime: NSDate
    var solved: Bool
    let direction = ["north", "east", "south", "west"]
    //    var closedListHashed = [Int]()
    
    
    
    init(start: Board)
    {
        savedBoard = start
        modSize = 5000 * Int(pow(Double(10), Double(board.size)))
        solvedBoard = start
        openList = []
        movesList = []
        openList.append(start)
        closedList = Array(repeating: Array(repeating: [[Int]](), count: 0), count: modSize)
        numMoves = 0
        startTime = NSDate()
        solved = false
        
    }
    
    // Helper for inital call from ViewController
    func startSolve()
    {
        openList.append(savedBoard)
        _ = solve()
    }
    
    func solve() -> [Board]
    {
        //        let maxInt = 999999999
        //        closedListBool = Array(repeating: 0, count: maxInt)
        print("modsize is: \(modSize)")
        //        print("use closed list is: \(useClosedList)")
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
                //                    board.printBoard()
                
                
                // If we're not using a closed list, only pop first elt
            }while(board.hash(hashVals: closedList, modSize: modSize))
            
            if(true)
            {
                closedList[board.hashVal].append(board.gameBoard)
            }
            
            closedListCount += 1
            //            board.printBoard()
            
            // Add moves for N,S,E,W to the list, if they're legal
            for dir in direction
            {
                if(board.moveDirection(dir: dir))
                {
                    if(!board.checkEqualToParent())
                    {
                        let newBoard = Board(gb: board.tmpBoard, p: board)
                        openList.insert(newBoard, at: openList.startIndex)
                    }
                }
            }
            
            
            
            // Information that prints to console to let you see the progress of the algorithm.
            // Mostly useful for debugging purposes, but also interesting
            if(closedListCount % 250 == 0)
            {
                print("\nExamined list size: \(closedListCount)")
                print("Depth: \(board.depth)")
                
                // Prints time since search started
                let end = NSDate()
                let timeSince: Double = end.timeIntervalSince(start as Date)
                let time = String(format: "%.02f", timeSince)
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
        let depth = board.depth
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
        print("Depth: \(depth)")
        
        //        closedListBool.removeAll()
        closedList.removeAll()
        return movesList
    }
    
    func getMovesList() -> [Board]
    {
        return movesList
    }
    
}

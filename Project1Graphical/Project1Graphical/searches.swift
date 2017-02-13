//
//  searches.swift
//  Project1Graphical
//
//  Created by Matt Daniel on 2/6/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Foundation




class DFS
{
    var openList = [Board]()
    var closedList = [[[[Int]]]]()
    var movesList = [Board]()
    var solvedBoard: Board
    var head: Board
    var board: Board
    var parent: Board?
    var modSize: Int
    //    var closedListHashed = [Int]()
    
    
    
    init(start: Board)
    {
        head = start
        board = head
        modSize = 5000 * Int(pow(Double(10), Double(board.size)))
        
        solvedBoard = start
        openList = []
        movesList = []
        openList.append(start)
        closedList = Array(repeating: Array(repeating: [[Int]](), count: 0), count: modSize)
    }
    
    // Helper for inital call from ViewController
    func startSolve()
    {
        startSolve(passedBoard: board)
    }
    
    func startSolve(passedBoard: Board)
    {
        board = passedBoard
        if(board.checkBoard())
        {
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
//            print("Closed List Size: \(closedListCount)")
//            let end = NSDate()
//            let timeSince: Double = end.timeIntervalSince(start as Date)
//            let time = String(format: "%.02f", timeSince)
//            print("\(time) seconds\n")
//            print("Moves: \(count)")
//            
//            //        closedListBool.removeAll()
//            closedList.removeAll()
//            return movesList

        }
        else
        {
            
        }
    }
    
    func solveR()
    {
        
    }
}



class BFS
{
    var openList = [Board]()
//    var closedList = [[[Int]]]()
    var movesList = [Board]()
    var solvedBoard: Board
    var head: Board
    var board: Board
    var parent: Board?
    var modSize: Int
//    var closedListHashed = [Int]()
    
    var closedListBool = [Int]()
    
    
    init(start: Board)
    {
        head = start
        board = head
        modSize = 5000 * Int(pow(Double(10), Double(board.size)))
        
        solvedBoard = start
        openList = []
        closedListBool = []
        movesList = []
        //board.gameBoard = [[3,1,2],[0,4,5],[6,7,8]]
        //  board.boardList.append(board.gameBoard)
        
        openList.append(start)
//        closedList = [[[]]]
        
    }
    
    func solve(useClosedList: Bool) -> [Board]
    {
//        let maxInt = 999999999
//        closedListBool = Array(repeating: 0, count: maxInt)
        print("modsize is: \(modSize)")
        print("use closed list is: \(useClosedList)")
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
                }while(useClosedList && board.hash(hashVals: closedList, modSize: modSize))
                
                if(useClosedList)
                {
                    closedList[board.hashVal].append(board.gameBoard)
                }
                
            closedListCount += 1
            
            // Add moves for N,S,E,W to the list, if they're legal
            if(board.moveDirection(dir: "north"))
            {
                if(!board.checkEqualToParent())
                {
                    let northBoard = Board(gb: board.tmpBoard, p: board)
                    openList.append(northBoard)
                }
            }
            if(board.moveDirection(dir: "east"))
            {
                
                if(!board.checkEqualToParent())
                {
                    let eastBoard = Board(gb: board.tmpBoard, p: board)
                    openList.append(eastBoard)
                }
            }
            if(board.moveDirection(dir: "south"))
            {
                
                if(!board.checkEqualToParent())
                {
                    let southBoard = Board(gb: board.tmpBoard, p: board)
                    openList.append(southBoard)
                }
            }
            if(board.moveDirection(dir: "west"))
            {
                
                if(!board.checkEqualToParent())
                {
                    let westBoard = Board(gb: board.tmpBoard, p: board)
                    openList.append(westBoard)
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

//        closedListBool.removeAll()
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
}

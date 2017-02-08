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
    
}

class BFS
{
    var openList = [Board]()
    var closedList = [Board]()
    var movesList = [Board]()
    var solvedBoard: Board
    var head: Board
    var board: Board
    var parent: Board?
    
    var closedListHashed = [Int]()
    
    init(start: Board)
    {
        head = start
        board = head
        //board.gameBoard = [[3,1,2],[0,4,5],[6,7,8]]
//        board.boardList.append(board.gameBoard)
        
        openList.append(start)
        closedList = []
        closedListHashed = []
        solvedBoard = start
    }
    
    func solve() -> [Board]
    {
        let start = NSDate()
        board.printBoard()
        repeat
        {
            repeat
            {
//                board.gameBoard = board.boardList.first!
                
                board = openList.first!
                
//              board.boardList.removeFirst()
                
                openList.removeFirst()
                
                //        print("Game Board \(board.gameBoard)")
                //        print("Open List \(board.boardList)")
                //        print("Closed List \(board.closedList)")
                
            }while (board.hashThree(hashVals: closedListHashed))
//                while (board.checkBoardsEqual(cl: closedList))
            
            
            closedList.append(board)
            closedListHashed.append(board.hashVal)
            
            if(board.moveDirection(dir: "north"))
            {
                let northBoard = Board(gb: board.tmpBoard, p: board)
                openList.append(northBoard)
            }
            if(board.moveDirection(dir: "east"))
            {
                let eastBoard = Board(gb: board.tmpBoard, p: board)
                openList.append(eastBoard)
            }
            if(board.moveDirection(dir: "south"))
            {
                let southBoard = Board(gb: board.tmpBoard, p: board)
                openList.append(southBoard)
            }
            if(board.moveDirection(dir: "west"))
            {
                let westBoard = Board(gb: board.tmpBoard, p: board)
                openList.append(westBoard)
            }
            
            if(closedList.count % 250 == 0)
            {
                print("\nClosed list size: \(closedList.count)")
                let end = NSDate()
                let timeSince: Double = end.timeIntervalSince(start as Date)
                let time = String(format: "%.01f", timeSince/60.0)
                print("\(time) minutes\n")
            }
            if(openList.count % 500 == 0)
            {
                print("Open list size: \(openList.count)")
            }
            
            
            //        print("\n\n\n")
//        board.printBoard()
        } while(!board.checkBoard())
        solvedBoard = board
        
        while (board.parent != nil)
        {
//            movesList.append(board)
            movesList.insert(board, at: movesList.startIndex)
            board = board.parent!
           
        }
        print("Closed List Size: \(closedList.count)")
//        print("MOVES\n\n")
//        for i in 0..<movesList.count
//        {
//            
//            movesList[i].printBoard()
//        }
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

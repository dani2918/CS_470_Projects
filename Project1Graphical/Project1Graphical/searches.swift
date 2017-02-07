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
    var board: Board
    
    init(start: Board)
    {
        board = start
        //board.gameBoard = [[3,1,2],[0,4,5],[6,7,8]]
        board.boardList.append(board.gameBoard)
    }
    
    func solve()
    {
        board.printBoard()
        repeat
        {
            repeat
            {
                
                
                board.gameBoard = board.boardList.first!
                //            board.checkBoardsEqual()
                
                board.boardList.removeFirst()
                
                
                //        print("Game Board \(board.gameBoard)")
                //        print("Open List \(board.boardList)")
                //        print("Closed List \(board.closedList)")
                
            } while (board.checkBoardsEqual())
            
            
            board.closedList.append(board.gameBoard)
            
            board.moveDirection(dir: "north")
            board.moveDirection(dir: "east")
            board.moveDirection(dir: "south")
            board.moveDirection(dir: "west")
            
            
            //        print("\n\n\n")
        board.printBoard()
        } while(!board.checkBoard())
    
    }
    func getBoard() -> Board
    {
        return board
    }
}

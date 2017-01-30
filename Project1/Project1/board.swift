//
//  board.swift
//  Project1
//
//  Created by Matt Daniel on 1/30/17.
//

import Foundation

class Board
{
    var gameBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    var blankLoc = (0,0)
    
    public init()
    {
        var num = 0
        let randMoves = 4
        for i in 0..<3
        {
            for j in 0..<3
            {
                gameBoard[i][j] = num
                num += 1
            }
        }
        setupBoard(moves: randMoves)
        while (checkBoard())
        {
            print("Reconfiguring Board...")
            setupBoard(moves: randMoves)

        }
    }
    
    
    func printBoard()
    {
        for i in 0..<3
        {
            for j in 0..<3
            {
                if(gameBoard[i][j] == 0)
                {
                    print("_", terminator: " ")
                }
                else
                {
                    print(gameBoard[i][j], terminator: " ")
                }
                
            }
            print()
        }
        print()
    }

    
    func setupBoard(moves: Int)
    {
        for _ in 0..<moves
        {
            randMove()
        }
    }
    
    func randMove()
    {
        move(loc: (Int(arc4random_uniform(3)),Int(arc4random_uniform(3))), entryMode: "random")
    }
    
    
    func move(loc: (Int,Int), entryMode: String)
    {
        if(legalMove(loc: loc))
        {
            let tmp = gameBoard[blankLoc.0][blankLoc.1]
            gameBoard[blankLoc.0][blankLoc.1] = gameBoard[loc.0][loc.1]
            gameBoard[loc.0][loc.1] = tmp
            blankLoc = loc
            
            if(entryMode == "user")
            {
                print()
                printBoard()
            }
            if(entryMode == "user" || entryMode == "search")
            {
                if(checkBoard())
                {
                    print("BOARD SOLVED!")
                    exit(1)
                }
            }
            
        }
        else
        {
            if(entryMode == "user")
            {
                print()
                print("Not a valid move!")
                print()
                printBoard()
            }
        }
        
        
    }
    
    private func legalMove(loc: (Int, Int)) -> Bool
    {
        var legal = false
        if(abs(loc.0 - blankLoc.0) == 1 && abs(loc.1 - blankLoc.1) == 0)
        {
            legal = true
        }
        else if(abs(loc.1 - blankLoc.1) == 1 && abs(loc.0 - blankLoc.0) == 0)
        {
            legal = true
        }
        
        if(legal)
        {
           // print(gameBoard[loc.0][loc.1])
            return true
        }
        else
        {
           // print(gameBoard[loc.0][loc.1])
            return false
        }
        
    }
    
    func checkBoard() -> Bool
    {
        var checkNum = 0
        
        for i in 0..<3
        {
            for j in 0..<3
            {
                // Case where the blank is at the end
                // 1 is first
                if(i == 0 && j == 0)
                {
                    if(gameBoard[i][j] == 1)
                    {
                        checkNum += 1
                    }
                }
                if(gameBoard[i][j] != checkNum)
                {
                    // if not in the last spot with the blank
                    if(i != 2 && j != 2 && gameBoard[i][j] != 0)
                    {
                        return false
                    }
                }
                    checkNum += 1
                
                
            }
        }
        
//        print("BOARD SOLVED")
        return true
    }
    
    func getLoc(value: Int) -> (Int, Int)
    {
        for i in 0..<3
        {
            for j in 0..<3
            {
                if(gameBoard[i][j] == value)
                {
                    return(i,j)
                }
            }
        }
        
        //Handles case of numbers outside of 1..8 range
        //Will return blank location and not make a move
        return blankLoc
    }
    
}

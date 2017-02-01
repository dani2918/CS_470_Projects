//
//  board.swift
//  Project1
//
//  Created by Matt Daniel on 1/30/17.
//

import Foundation

class Board
{
    var size = 3
    var gameBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 5), count: 5)
    var blankLoc = (0,0)
    
    public init(givenSize: Int)
    {
        var num = 0
        size = givenSize
        let randMoves = 1000*size
        for i in 0..<size
        {
            for j in 0..<size
            {
                gameBoard[i][j] = num
                num += 1
            }
        }
        setupBoard(moves: randMoves)
        //If we happen to get a solved board, reshuffle
        while (checkBoard())
        {
            print("Reconfiguring Board...")
            setupBoard(moves: randMoves)

        }
    }
    
    // Print board to stdout
    func printBoard()
    {
        for i in 0..<size
        {
            for j in 0..<size
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

    // Do a specified # of random moves
    func setupBoard(moves: Int)
    {
        for _ in 0..<moves
        {
            randMove()
        }
    }
    
    //Do the random moves, ignore them if they're illegal
    func randMove()
    {
        move(loc: (Int(arc4random_uniform(UInt32(size))),Int(arc4random_uniform(UInt32(size)))), entryMode: "random")
    }
    
    
    func move(loc: (Int,Int), entryMode: String)
    {
        if(legalMove(loc: loc))
        {
            let tmp = gameBoard[blankLoc.0][blankLoc.1]
            gameBoard[blankLoc.0][blankLoc.1] = gameBoard[loc.0][loc.1]
            gameBoard[loc.0][loc.1] = tmp
            blankLoc = loc
            
            //Print board for user playing on command line
            if(entryMode == "user")
            {
                print()
                printBoard()
            }
            //Report solved board to command line
            if(entryMode == "user" || entryMode == "search")
            {
                if(checkBoard())
                {
                    print("BOARD SOLVED!")
                    //Only exit on command line
                    //exit(1)
                }
            }
            
        }
        else
        {
            //Will print to stdout, but no action on
            //wrong square click
            if(entryMode == "user")
            {
                print()
                print("Not a valid move!")
                print()
                printBoard()
            }
        }
        
        
    }
    
    //If square is one away from blank in x OR y direction, but not both
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
            return true
        }
        else
        {
            return false
        }
        
    }
    
    //See if the board is solved, either with the blank at the beginning
    //or with the blank at the end
    func checkBoard() -> Bool
    {
        var checkNumFirst = 0
        var checkNumLast = 1
        
        for i in 0..<size
        {
            for j in 0..<size
            {
                // Case where the blank is at the end
                // 1 is first
                if(i == (size - 1) && j == (size - 1))
                {
                    checkNumLast = 0
                }
                
                if(gameBoard[i][j] != checkNumFirst && gameBoard[i][j] != checkNumLast)
                {
                    return false
                }
                checkNumFirst += 1
                checkNumLast += 1
                
                
            }
        }
        
//      print("BOARD SOLVED")
        return true
    }
    
    // Return the (x,y) position of a certain numbered square
    func getLoc(value: Int) -> (Int, Int)
    {
        for i in 0..<size
        {
            for j in 0..<size
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

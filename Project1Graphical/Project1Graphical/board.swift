//
//  board.swift
//  Project1
//
//  Created by Matt Daniel on 1/30/17.
//

import Foundation

class Board
{
    var size : Int
    var gameBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 5), count: 5)
    var startingBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 5), count: 5)
    var tmpBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 5), count: 5)
    var blankLoc = (0,0)
    var moveCount = 0
    var hashVal: Int

    // Optional parent of type board (doesn't need initalized)
    var parent: Board?
    
    public init(givenSize: Int)
    {
        var num = 0
        hashVal = 0
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
        startingBoard = gameBoard
        printBoard()
       
    }
    public init(gb: [[Int]], p: Board)
    {
        hashVal = 0
        gameBoard = gb
        parent = p
        size = p.size
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
        moveCount = 0
    }
    
    //Do the random moves, ignore them if they're illegal
    func randMove()
    {
        move(loc: (Int(arc4random_uniform(UInt32(size))),Int(arc4random_uniform(UInt32(size)))), entryMode: "random")
    }
    
    // Get a temporary board corresponding to a move in a certain direction
    // Otherwise return false
    func moveDirection(dir: String) -> Bool
    {
        var retVal = true
        var loc: (Int, Int)
        tmpBoard = gameBoard
        blankLoc = getLoc(value: 0)
        switch dir
        {
        case "north":
            if(blankLoc.0 < size - 1)
            {
                loc = (blankLoc.0 + 1, blankLoc.1)
                if(legalMove(loc: loc))
                {
                    move(loc: loc, entryMode:"search")
                }
                else
                {
                    retVal =  false;
                }
            }
            else
            {
                retVal = false
            }
            break
        case "east":
            if(blankLoc.1 > 0)
            {
                loc = (blankLoc.0, blankLoc.1 - 1)
                if(legalMove(loc: loc))
                {
                    move(loc: loc, entryMode:"search")
                }
                else
                {
                    retVal = false;
                }
            }
            else
            {
                retVal = false
            }
            break
        case "south":
            if(blankLoc.0 > 0)
            {
                loc = (blankLoc.0 - 1, blankLoc.1)
                if(legalMove(loc: loc))
                {
                    move(loc: loc, entryMode:"search")
                }
                else
                {
                    retVal = false;
                }
            }
            else
            {
                retVal = false
            }
            break
        case "west":
            if(blankLoc.1 < size - 1)
            {
                loc = (blankLoc.0, blankLoc.1 + 1)
                if(legalMove(loc: loc))
                {
                    move(loc: loc, entryMode:"search")
                }
                else
                {
                    retVal =  false;
                }
            }
            else
            {
                retVal = false
            }
            break
        default:
            retVal = false
            break
        }
        return retVal
    }
    
    
    
    
    func move(loc: (Int,Int), entryMode: String)
    {
        if(legalMove(loc: loc) && entryMode != "search")
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
                moveCount += 1;
            }
            
        }
            
        // If we're returning a board for a BFS, DFS, etc.
        // DON'T change the game board, change a temp board instead
        else if(legalMove(loc: loc) && entryMode == "search")
        {
            let tmpBlankLoc = getLoc(value: 0)
            let tmp = tmpBoard[tmpBlankLoc.0][tmpBlankLoc.1]
            tmpBoard[tmpBlankLoc.0][tmpBlankLoc.1] = tmpBoard[loc.0][loc.1]
            tmpBoard[loc.0][loc.1] = tmp
        }
        else
        {
            // Will print to stdout, but no action on
            // wrong square click
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
  
//     See if two boards are equal
    func checkBoardsEqual(cl: [[[Int]]]) -> Bool
    {
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
//                    print("\(gameBoard[j][k]), \(closedList[i][j][k])")
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
//            print("Equal Boards")
        }
        return flag
    }
    
    // Returns true if parent == tmp boards
    func checkEqualToParent() -> Bool
    {
        if(parent == nil)
        {
            return false
        }
        
        var flag = true
        for i in 0..<size
        {
            for j in 0..<size
            {
                if(tmpBoard[i][j] != parent?.gameBoard[i][j])
                {
                    flag = false
                }
                
            }
        }
        if(flag)
        {
//            print("Same as Parent!")
        }
        return flag
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
        
        //Handles case of numbers outside of 1..n*n range
        //Will return blank location and not make a move
        return blankLoc
    }
    
    func getMoveCount() -> Int
    {
        return moveCount
    }
    
    
//    //Creates a value based on the board for a 3x3
//    func hashThree(hashVals: [Int]) -> Bool
//    {
//        hashVal = 0
//        var count = 0
//        for i in 0..<size
//        {
//            for j in 0..<size
//            {
//                hashVal += gameBoard[i][j] * Int(pow(Double(10), Double(count)))
//                count += 1
//            }
//        }
////        printBoard()
////        print(hashVal)
////        if(hashVals.contains(hashVal))
////        {
////            return true
////        }
////        else
////        {
////            return false
////        }
//        if(hashVals[hashVal] == 1)
//        {
//            return true
//        }
//        else
//        {
//            return false
//        }
//        
//    }
    
    func hash(hashVals: [[[[Int]]]], modSize: Int) -> Bool
    {
        hashVal = 0
        var count = 0
        
        //Include only the 3x3 values in the hash function
        // Speeds up the 4x4 hashing considerably
        for i in 0..<3
        {
            for j in 0..<3
            {
                hashVal += gameBoard[i][j] * Int(pow(Double(10), Double(count)))
                count += 1
            }
        }
        hashVal = hashVal % modSize
        //        printBoard()
        //        print(hashVal)
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
}

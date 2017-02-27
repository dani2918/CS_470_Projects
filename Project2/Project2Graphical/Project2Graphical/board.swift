//
//  board.swift
//  Project2Graphical
//
//  Created by Matt Daniel on 2/23/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Foundation

class Board
{
    var gameState = Array(repeating: Array(repeating: 0, count: 7), count: 6)
    
    // Array to hold solns for each of the four winning directions
    var solvedArray = Array(repeating: Array(repeating: (Int(), Int()), count: 1), count: 4)
    var soln = [(Int, Int)]()
    
    enum Direction {
        case n
        case s
        case e
        case w
        case ne
        case nw
        case se
        case sw
        
    }
    init(b: [[Int]])
    {
        gameState = b
    
    }
    
    func checkBoard(row: Int, col: Int, checkVal: Int) -> Int
    {
        var found = 0
        solvedArray = Array(repeating: Array(repeating: (Int(), Int()), count: 1), count: 6)
//        print(solvedArray)
        for i in 0..<4
        {
            solvedArray[i].append(row,col)
        }
        let vertCorrect = checkBoardHelper(row: row + 1, col: col, dir: .n, checkVal: checkVal) + 1 + checkBoardHelper(row: row - 1, col: col, dir: .s, checkVal: checkVal)
        let horizCorrect = checkBoardHelper(row: row, col: col + 1, dir: .e, checkVal: checkVal) + 1 + checkBoardHelper(row: row, col: col - 1, dir: .w, checkVal: checkVal)
        let leftToRightDiagCorrect = checkBoardHelper(row: row + 1, col: col + 1, dir: .ne, checkVal: checkVal) + 1 + checkBoardHelper(row: row - 1, col: col - 1, dir: .sw, checkVal: checkVal)
        let rightToLeftDiagCorrect = checkBoardHelper(row: row + 1, col: col - 1, dir: .nw, checkVal: checkVal) + 1 + checkBoardHelper(row: row - 1, col: col + 1, dir: .se, checkVal: checkVal)
//        print("vert correct",vertCorrect)
//        print("horiz correct",horizCorrect)
//        print("LR Diag correct",leftToRightDiagCorrect)
//        print("RL Diag correct",rightToLeftDiagCorrect)
//        print()
        if(vertCorrect >= 4)
        {
            found = 1
        }
        else if(horizCorrect >= 4)
        {
            found = 2
        }
        else if(leftToRightDiagCorrect >= 4)
        {
            found = 3
        }
        else if(rightToLeftDiagCorrect >= 4)
        {
            found = 4
        }
        if(found != 0)
        {
            setSoln(s: solvedArray[found-1])
        }
        return found
    }
    
    
    func checkBoardHelper(row: Int, col: Int, dir: Direction, checkVal: Int) -> Int
    {
//        print("checking row:", row, "col:", col, "val:", checkVal)
        switch dir
        {
        case .n:
            if(row < 6)
            {
                if(gameState[row][col] == checkVal)
                {
//                    print("Found north")
                    solvedArray[0].append(row,col)
                    return checkBoardHelper(row: row + 1, col: col, dir: .n, checkVal: checkVal) + 1
                }
            }
            return 0
        case .s:
            if(row >= 0)
            {
                if(gameState[row][col] == checkVal)
                {
//                    print("found south")
                    solvedArray[0].append(row,col)
                    return checkBoardHelper(row: row - 1, col: col, dir: .s, checkVal: checkVal) + 1
                }
            }
            return 0
        case .e:
            if(col < 7)
            {
                if(gameState[row][col] == checkVal)
                {
//                    print("Found east")
                    solvedArray[1].append(row,col)
                    return checkBoardHelper(row: row, col: col + 1, dir: .e, checkVal: checkVal) + 1
                }
            }
            return 0
        case .w:
            if(col >= 0)
            {
                if(gameState[row][col] == checkVal)
                {
//                    print("found west")
                    solvedArray[1].append(row,col)
                    return checkBoardHelper(row: row, col: col - 1, dir: .w, checkVal: checkVal) + 1
                }
            }
            return 0
        case .ne:
            if(row < 6 && col < 7)
            {
                if(gameState[row][col] == checkVal)
                {
//                    print("Found north east")
                    solvedArray[2].append(row,col)
                    return checkBoardHelper(row: row + 1, col: col + 1, dir: .ne, checkVal: checkVal) + 1
                }
            }
            return 0
        case .sw:
            if(row >= 0 && col >= 0)
            {
                if(gameState[row][col] == checkVal)
                {
//                    print("found south west")
                    solvedArray[2].append(row,col)
                    return checkBoardHelper(row: row - 1, col: col - 1, dir: .sw, checkVal: checkVal) + 1
                }
            }
            return 0
        case .nw:
            if(row < 6 && col >= 0)
            {
                if(gameState[row][col] == checkVal)
                {
//                    print("Found north west")
                    solvedArray[3].append(row,col)
                    return checkBoardHelper(row: row + 1, col: col - 1, dir: .nw, checkVal: checkVal) + 1
                }
            }
            return 0
        case .se:
            if(row >= 0 && col < 7)
            {
                if(gameState[row][col] == checkVal)
                {
//                    print("found south east")
                    solvedArray[3].append(row,col)
                    return checkBoardHelper(row: row - 1, col: col + 1, dir: .se, checkVal: checkVal) + 1
                }
            }
            return 0
        }
    }
    
    func setSoln(s: [(Int,Int)])
    {
        soln = s
        soln.removeFirst()
    }
    func getSoln() -> [(Int,Int)]
    {
        return soln
    }
    
}

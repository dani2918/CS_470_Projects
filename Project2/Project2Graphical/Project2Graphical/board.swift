//
//  board.swift
//  Project2Graphical
//
//  Created by Matt Daniel on 2/23/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Foundation
var counter = 0
var open = 0
var closed = 0
class Board : Hashable
{
    weak var parent: Board?
    var child: [Board?]
    var heuristic = 0
    var gameState = Array(repeating: Array(repeating: 0, count: 7), count: 6)
    // Array to hold solns for each of the four winning directions
    var solvedArray = Array(repeating: Array(repeating: (Int(), Int()), count: 1), count: 4)
    var soln = [(Int, Int)]()
    var vertCorrect = 0, horizCorrect = 0, leftToRightDiagCorrect = 0, rightToLeftDiagCorrect = 0, maxCorrect = 0
    var redScore: Int
    var blueScore: Int
    var openSpaces: Int
    var solved = false
    
    
    public var hashValue: Int
    {
        return ObjectIdentifier(self).hashValue
    }
    
    static func ==(lhs: Board, rhs: Board) -> Bool
    {
        var test = true
        for i in 0..<6
        {
            for j in 0..<7
            {
                if (lhs.gameState[i][j] != rhs.gameState[i][j])
                {
                    test = false
                }
            }
        }
        return test
    }
    
    enum Direction
    {
        case n
        case s
        case e
        case w
        case ne
        case nw
        case se
        case sw
        
    }
    init()
    {
        redScore = 0
        blueScore = 0
        child = [Board]()
        openSpaces = 6 * 7
        
        open += 1
    }
    init(b: [[Int]])
    {
        gameState = b
        redScore = 0
        blueScore = 0
        child = [Board]()
        openSpaces = 6 * 7
        
        open += 1
    }
    
    init(b: [[Int]], par: Board)
    {
        gameState = b
        parent = par
        redScore = parent!.redScore
        blueScore = parent!.blueScore
        child = [Board]()
        openSpaces = par.openSpaces - 1
        
        open += 1
    }
    
    deinit {
        closed += 1
    }

    func checkBoard(row: Int, col: Int, checkVal: Int) -> Int
    {
        var found = 0
        solvedArray = Array(repeating: Array(repeating: (Int(), Int()), count: 1), count: 6)
        for i in 0..<4
        {
            solvedArray[i].append(row,col)
        }
        vertCorrect = checkBoardHelper(row: row + 1, col: col, dir: .n, checkVal: checkVal) + 1 + checkBoardHelper(row: row - 1, col: col, dir: .s, checkVal: checkVal)
        horizCorrect = checkBoardHelper(row: row, col: col + 1, dir: .e, checkVal: checkVal) + 1 + checkBoardHelper(row: row, col: col - 1, dir: .w, checkVal: checkVal)
        leftToRightDiagCorrect = checkBoardHelper(row: row + 1, col: col + 1, dir: .ne, checkVal: checkVal) + 1 + checkBoardHelper(row: row - 1, col: col - 1, dir: .sw, checkVal: checkVal)
        rightToLeftDiagCorrect = checkBoardHelper(row: row + 1, col: col - 1, dir: .nw, checkVal: checkVal) + 1 + checkBoardHelper(row: row - 1, col: col + 1, dir: .se, checkVal: checkVal)
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

        maxCorrect = max(vertCorrect, horizCorrect, leftToRightDiagCorrect, rightToLeftDiagCorrect)
        if (maxCorrect >= 4)
        {
            maxCorrect = Int.max
        }
        // Red check
        if(checkVal == 1)
        {
            redScore = max(redScore, maxCorrect)
        }
        else
        {
            blueScore = max(blueScore, maxCorrect)
        }
        return found
    }
    
    func checkBoardHelper(row: Int, col: Int, dir: Direction, checkVal: Int) -> Int
    {
        switch dir
        {
        case .n:
            if(row < 6)
            {
                if(gameState[row][col] == checkVal)
                {
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
    
    func printBoard()
    {
        for i in 0..<6
        {
            for j in 0..<7
            {
                print(gameState[i][j], terminator: " ")
            }
            print()
        }
        print()
    }
    
//    func calcMaxCorrect() -> Int
//    {
//        maxCorrect = max(vertCorrect, horizCorrect, leftToRightDiagCorrect, rightToLeftDiagCorrect)
//        return maxCorrect
//    }
//    
    
}

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
var gaussianDist = [[3,4,5,7,5,4,3],
                    [4,6,8,10,8,6,4],
                    [5,8,11,13,11,8,5],
                    [5,8,11,13,11,8,5],
                    [4,6,8,10,8,6,4],
                    [3,4,5,7,5,4,3]]

var mainW = 3.0
var gausW = 150.0

class Board
{
    weak var parent: Board?
    var child: [Board?]
    var heuristic = 0.0
    var gameState = Array(repeating: Array(repeating: 0, count: 7), count: 6)
    // Array to hold solns for each of the four winning directions
    var solvedArray = Array(repeating: Array(repeating: (Int(), Int()), count: 1), count: 7)
    var soln = [(Int, Int)]()
    var vertCorrect = 0, horizCorrect = 0, leftToRightDiagCorrect = 0, rightToLeftDiagCorrect = 0, maxCorrect = 0
    var vExtra = 0,  hExtra = 0,  lrExtra = 0,  rlExtra = 0
    var redScore = 0.0
    var blueScore = 0.0
    var openSpaces: Int
    var solved = false
    var increasing = true
    var decreasing = true
    
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
    
    init(b: [[Int]], os: Int)
    {
        gameState = b
        redScore = 0
        blueScore = 0
        child = [Board]()
        openSpaces = os - 1
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
    
//    deinit {
//        closed += 1
//    }
    
    func checkBoard(row: Int, col: Int, checkVal: Int) -> Int
    {
        var found = 0
        solvedArray = Array(repeating: Array(repeating: (Int(), Int()), count: 1), count: 6)
        for i in 0..<4
        {
            solvedArray[i].append(row,col)
        }
        
        increasing = true; decreasing = true
        vertCorrect = checkBoardHelper(row: row + 1, col: col, dir: .n, checkVal: checkVal, depth: 1) + 1 +  checkBoardHelper(row: row - 1, col: col, dir: .s, checkVal: checkVal, depth: 1)
        increasing = true; decreasing = true
        horizCorrect = checkBoardHelper(row: row, col: col + 1, dir: .e, checkVal: checkVal, depth: 1) + 1 + checkBoardHelper(row: row, col: col - 1, dir: .w, checkVal: checkVal, depth: 1)
        increasing = true; decreasing = true
        leftToRightDiagCorrect = checkBoardHelper(row: row + 1, col: col + 1, dir: .ne, checkVal: checkVal, depth: 1) + 1 + checkBoardHelper(row: row - 1, col: col - 1, dir: .sw, checkVal: checkVal, depth: 1)
        increasing = true; decreasing = true
        rightToLeftDiagCorrect = checkBoardHelper(row: row + 1, col: col - 1, dir: .nw, checkVal: checkVal, depth: 1) + 1 + checkBoardHelper(row: row - 1, col: col + 1, dir: .se, checkVal: checkVal, depth: 1)
        
//        print("\n")
//        print(vertCorrect, horizCorrect, leftToRightDiagCorrect, rightToLeftDiagCorrect)
//        print(vExtra, hExtra, lrExtra, rlExtra)
        
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
        
        var score = 0.0
        
        maxCorrect = max(vertCorrect, horizCorrect, leftToRightDiagCorrect, rightToLeftDiagCorrect)
        if (maxCorrect >= 4)
        {
            score = Double(Int.max)
        }
        else
        {
            score = scrub(correct: vertCorrect, extra: vExtra) + scrub(correct: horizCorrect, extra: hExtra) + scrub(correct: leftToRightDiagCorrect, extra: lrExtra) + scrub(correct: rightToLeftDiagCorrect, extra: rlExtra)
            score += (Double(gaussianDist[row][col]) * gausW)
        }

        if(checkVal == 1)
        {
            if(score == Double(Int.max))
            {
                redScore = Double(Int.max)
            }

            else
            {
                redScore += score
            }
        }
        else
        {
            if(score == Double(Int.max))
            {
                blueScore = Double(Int.max)
            }
            else
            {
                blueScore += score
            }
        }
        
        return found
    }
    
    func checkBoardHelper(row: Int, col: Int, dir: Direction, checkVal: Int, depth: Int) -> Int
    {
        if(depth > 4)
        {
            return 0
        }
        switch dir
        {
        case .n:
            if(row < 6)
            {
                if(gameState[row][col] == checkVal && increasing)
                {
                    solvedArray[0].append(row,col)
                    return checkBoardHelper(row: row + 1, col: col, dir: .n, checkVal: checkVal, depth: depth + 1) + 1
                }
                if(gameState[row][col] == 0 || (gameState[row][col] == checkVal && !increasing))
                {
                    vExtra += 1
                    increasing = false
                    return checkBoardHelper(row: row + 1, col: col, dir: .n, checkVal: checkVal, depth: depth + 1)
                }
            }
            return 0
        case .s:
            if(row >= 0)
            {
                if(gameState[row][col] == checkVal && decreasing)
                {
                    solvedArray[0].append(row,col)
                    return checkBoardHelper(row: row - 1, col: col, dir: .s, checkVal: checkVal, depth: depth + 1) + 1
                }
                if(gameState[row][col] == 0 || (gameState[row][col] == checkVal && !decreasing))
                {
                    vExtra += 1
                    decreasing = false
                    return checkBoardHelper(row: row - 1, col: col, dir: .s, checkVal: checkVal, depth: depth + 1)
                }
            }
            return 0
        case .e:
            if(col < 7)
            {
                if(gameState[row][col] == checkVal && increasing)
                {
                    solvedArray[1].append(row,col)
                    return checkBoardHelper(row: row, col: col + 1, dir: .e, checkVal: checkVal, depth: depth + 1) + 1
                }
                if(gameState[row][col] == 0 || (gameState[row][col] == checkVal && !increasing))
                {
                    hExtra += 1
                    increasing = false
                    return checkBoardHelper(row: row, col: col + 1, dir: .e, checkVal: checkVal, depth: depth + 1)
                }
            }
            return 0
        case .w:
            if(col >= 0)
            {
                if(gameState[row][col] == checkVal && decreasing)
                {
                    solvedArray[1].append(row,col)
                    return checkBoardHelper(row: row, col: col - 1, dir: .w, checkVal: checkVal, depth: depth + 1) + 1
                }
                if(gameState[row][col] == 0 || (gameState[row][col] == checkVal && !decreasing))
                {
                    hExtra += 1
                    decreasing = false
                    return checkBoardHelper(row: row, col: col - 1, dir: .w, checkVal: checkVal, depth: depth + 1)
                }
            }
            return 0
        case .ne:
            if(row < 6 && col < 7)
            {
                if(gameState[row][col] == checkVal && increasing)
                {
                    solvedArray[2].append(row,col)
                    return checkBoardHelper(row: row + 1, col: col + 1, dir: .ne, checkVal: checkVal, depth: depth + 1) + 1
                }
                if(gameState[row][col] == 0 || (gameState[row][col] == checkVal && !increasing))
                {
                    lrExtra += 1
                    increasing = false
                    return checkBoardHelper(row: row + 1, col: col + 1, dir: .ne, checkVal: checkVal, depth: depth + 1)
                }
            }
            return 0
        case .sw:
            if(row >= 0 && col >= 0)
            {
                if(gameState[row][col] == checkVal && decreasing)
                {
                    solvedArray[2].append(row,col)
                    return checkBoardHelper(row: row - 1, col: col - 1, dir: .sw, checkVal: checkVal, depth: depth + 1) + 1
                }
                if(gameState[row][col] == 0 || (gameState[row][col] == checkVal && !decreasing))
                {
                    lrExtra += 1
                    decreasing = false
                    return checkBoardHelper(row: row - 1, col: col - 1, dir: .sw, checkVal: checkVal, depth: depth + 1)
                }
            }
            return 0
        case .nw:
            if(row < 6 && col >= 0)
            {
                if(gameState[row][col] == checkVal && increasing)
                {
                    solvedArray[3].append(row,col)
                    return checkBoardHelper(row: row + 1, col: col - 1, dir: .nw, checkVal: checkVal, depth: depth + 1) + 1
                }
                if(gameState[row][col] == 0 || (gameState[row][col] == checkVal && !increasing))
                {
                    rlExtra += 1
                    increasing = false
                    return checkBoardHelper(row: row + 1, col: col - 1, dir: .nw, checkVal: checkVal, depth: depth + 1)
                }
            }
            return 0
        case .se:
            if(row >= 0 && col < 7)
            {
                if(gameState[row][col] == checkVal && decreasing)
                {
                    solvedArray[3].append(row,col)
                    return checkBoardHelper(row: row - 1, col: col + 1, dir: .se, checkVal: checkVal, depth: depth + 1) + 1
                }
                if(gameState[row][col] == 0 || (gameState[row][col] == checkVal && !decreasing))
                {
                    rlExtra += 1
                    decreasing = false
                    return checkBoardHelper(row: row - 1, col: col + 1, dir: .se, checkVal: checkVal, depth: depth + 1)
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
    
    func scrub(correct: Int, extra: Int) -> Double// Int
    {
        if(correct + extra < 4)
        {
//            print("0", terminator: " ")
            return 0
        }
        else
        {
//            let r = Int(pow(Double(mainW), Double(correct - 1))) + extra
            let r = pow(Double(mainW), Double(correct - 1)) + Double(extra)
//            print("\(r)", terminator: " ")
            return r
        }
    }
}

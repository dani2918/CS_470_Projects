import Foundation
var maxDepth = 11



func negaMaxInit(b: Board?, color: Int) -> Int
{
//    print("color is \(color)")
    let start = NSDate()
    //let n = negaMax(b: b!, depth: maxDepth, color: color)
    let nArr = negaMaxFirstChildren(b: b!, depth: maxDepth, color: color)
    let n = nArr.max()!
    
    b!.heuristic = n
    print("N is: ", n)
    var index = [Int]()
    for i in 0..<7
    {
//        if(b!.child.isEmpty)
//        {
//            
//        }
//        if(b!.child[i] != nil)
//        {
//            print( i, ": b!.heuristic", b!.heuristic, "child H: ", b!.child[i]!.heuristic)
//            if (b!.heuristic ==   b!.child[i]!.heuristic)
//            {
//                index.append(i)
//            }
//        }
        if (nArr[i] == n)
        {
            index.append(i)
        }
    }
    var minDist = [Int]()
    for i in 0..<index.count
    {
        minDist.append(abs(index[i] - 3))
    }
    let bestIndex = minDist.index(of: minDist.min()!)!
    let bestBoard = index[bestIndex]
//    print("max Board is", bestBoard, "index array:", bestIndex)
//    b!.child[bestBoard]?.printBoard()
    //return n
    let end = NSDate()
    let timeSince: Double = end.timeIntervalSince(start as Date)
    let time = String(format: "%.02f", timeSince)
    b!.child.removeAll()
    print("\(time) seconds\n")
    
    
//    let _ = negaMaxFirstChildren(b: b!, depth: maxDepth, color: color)
    
    return bestBoard
}


func negaMaxFirstChildren(b: Board?, depth: Int, color: Int) -> [Int]
{
    var n = Array(repeating: Int(), count: 7)
    for _ in 0..<7
    {
        b!.child.append(Board())
    }
    
    let queue = DispatchQueue(label: "test", qos: .userInitiated, attributes: .concurrent)
    let group = DispatchGroup()

    
    for i in 0..<7
    {
        queue.async(group: group)
        {
            //        b!.child.append(move(b: b!, col: i, turn: color))
            b!.child[i] = move(b: b!, col: i, turn: color)
            if((b!.child[i]) != nil)
            {
                n[i] = -1 * negaMax(b: b!.child[i]!, depth: depth - 1, color: -1 * color)
                b!.child[i]!.heuristic = n[i]
            }
            else
            {
                n[i] = Int.min
            }
        }
    }
    group.notify(queue: queue)
    {
//        print("done")
    }
    
    let _ = group.wait()
    print("N arr is:",n)
    return n
}



func negaMax(b: Board?, depth: Int, color: Int) -> Int
{
    if(b!.openSpaces == 0)
    {
        b!.heuristic = b!.redScore - b!.blueScore
        //        print("score is: \(color * b!.heuristic)")
        return color * b!.heuristic
    }
    if(depth == 0 || b!.solved)
    {
//        print("redscore is: \(b!.redScore), blue: \(b!.blueScore), color: \(color)")
//        b!.printBoard()
        b!.heuristic = b!.redScore - b!.blueScore
//        print("score is: \(color * b!.heuristic)")
        return color * b!.heuristic
    }
    
    var bestValue = Int.min
    var bestArr = [Int]()
   
    
    for i in 0..<7
    {
        b!.child.append(move(b: b!, col: i, turn: color))
        // color 1: red move, color -1: blue move
        //let child = move(b: b, col: i, turn: color)
        var v = Int.min
        if((b!.child[i]) != nil)
        {
            v = -1 * negaMax(b: b!.child[i]!, depth: depth - 1, color: -1 * color)
            bestValue = max(v, bestValue)
            bestArr.append(v)
        }
        else
        {
            bestArr.append(Int.min)
        }
        
    }
    
    
    b!.heuristic = bestValue
//    print("BEST ARRAY: ", bestArr, "DEPTH: ", depth)
    if(depth == maxDepth)
    {
        for i in 0..<bestArr.count
        {
            if(b!.child[i] != nil)
            {
                print("BEST ARRAY: ", bestArr, "DEPTH: ", depth)
                b!.child[i]!.heuristic = bestArr[i]
            }
            else
            {
                
            }
        }
    }
    return bestValue
}

func move(b: Board?, col: Int, turn: Int) -> Board?
{
    var firstOpen = 6
    for i in 0..<6
    {
        if(b!.gameState[i][col] == 0)
        {
            firstOpen = i
            break
        }
    }
//    if(b!.openSpaces == 0)
//    {
//        let _ = 3
//        //FULL BOARD
//    }
//    if(firstOpen > 5 && col == 6)
//    {
//        let _ = 3
//        return nil
//    }
    if(firstOpen > 5)
    {
        // Error function
        return nil
    }
    // Red/p1 turn
    var newBoard: Board?
    newBoard = Board(b: b!.gameState, par: b!)
    if (turn == 1)
    {
        newBoard!.gameState[firstOpen][col] = 1
    }
        // Blue/p2 turn
    else
    {
        newBoard!.gameState[firstOpen][col] = 2
    }
    
    let winCond = newBoard!.checkBoard(row: firstOpen, col: col, checkVal: newBoard!.gameState[firstOpen][col])
    if winCond != 0
    {
        newBoard!.solved = true
    }
    
    return newBoard
}

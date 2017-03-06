import Foundation
var maxDepth = 10


// For reordering
let order = [5,3,1,0,2,4,6]

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
    let end = NSDate()
    let timeSince: Double = end.timeIntervalSince(start as Date)
    let time = String(format: "%.02f", timeSince)
    
    let queue = DispatchQueue(label: "remove", qos: .userInitiated, attributes: .concurrent)
    let workItem = DispatchWorkItem(qos: .userInitiated)
    {
        b!.child.removeAll()
    }
    queue.async(execute: workItem)
    print("\(time) seconds\n")
    
    return bestBoard
}



func negaMaxFirstChildren(b: Board?, depth: Int, color: Int) -> [Int]
{
    var n = Array(repeating: Int(), count: 7)
    for _ in 0..<7
    {
        b!.child.append(Board())
    }
    
    let queue = DispatchQueue(label: "run", qos: .userInitiated, attributes: .concurrent)
    let group = DispatchGroup()
    
    for i in 0..<7
    {
        queue.async(group: group)
        {
            b!.child[i] = move(b: b!, col: i, turn: color)
            if((b!.child[i]) != nil)
            {
                n[i] = -1 * negaMax(b: b!.child[i]!,  depth: depth - 1, alp: Int.min + 1, bet: Int.max, color: -1 * color)
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



func negaMax(b: Board?, depth: Int, alp: Int, bet: Int, color: Int) -> Int
{
    if(b!.openSpaces == 0)
    {
        b!.heuristic = b!.redScore - b!.blueScore
        return color * b!.heuristic
    }
    if(depth == 0 || b!.solved)
    {
        b!.heuristic = b!.redScore - b!.blueScore
        return color * b!.heuristic
    }
    
    var bestValue = Int.min
    var bestArr = [Int]()
    for _ in 0..<7
    {
        b!.child.append(nil)
    }
   
    var newalpha = alp
    for i in 0..<7
    {
        let orderi = order[i]
//        b!.child.insert(move(b: b!, col: orderi, turn: color), at: orderi)
//        b!.child[i] = move(b: b!, col: i, turn: color)
        b!.child[orderi] = move(b: b!, col: orderi, turn: color)

        var v = Int.min
        
//        if((b!.child[i]) != nil)
        if((b!.child[orderi]) != nil)
        {
            
//            v = -1 * negaMax(b: b!.child[i]!, depth: depth - 1, alp: -1 * bet, bet: -1 * newalpha, color: -1 * color)
            v = -1 * negaMax(b: b!.child[orderi]!, depth: depth - 1, alp: -1 * bet, bet: -1 * newalpha, color: -1 * color)
            bestValue = max(v, bestValue)
            newalpha = max(alp, v)
            if(newalpha >= bet)
            {
                break
            }
            bestArr.append(v)
        }
        else
        {
            bestArr.append(Int.min)
        }
        
    }
    
    b!.heuristic = bestValue
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

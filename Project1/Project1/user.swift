//
//  user.swift
//  Project1
//
//  Created by Matt Daniel on 1/30/17.
//

import Foundation

class User
{
 
    var board: Board
    public init(sendBoard: Board)
    {
        board = sendBoard
    }
    
    func promptUser()
    {
        print("Enter a tile to move, or 'q' to quit")
        var usrStr = readLine()
        if(usrStr == "q")
        {
            print("Goodbye")
            exit(1)
        }
        
        else
        {
            if let usrNum = Int(usrStr!)
            {
                board.move(loc: board.getLoc(value: usrNum), entryMode: "user")
            }
            else
            {
                print("Invalid Input")
            }

            
//            if usrNum is Int
//            {
//                print(usrNum)
//            }
        }
        
    }
}

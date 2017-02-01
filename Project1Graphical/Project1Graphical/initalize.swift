////
////  main.swift
////  Project1
////
////  Created by Matt Daniel on 1/30/17.
////
//
//import Foundation
//
//
//


let board = Board()

let user = User(sendBoard: board)


func getBoard() -> Board
{
    return board;
}

func getUser() -> User
{
    return user
}

//
//print("Enter u for user mode; enter q to quit at any time")
//print("Enter Mode: ")
//let mode = readLine()
//print()
//
//
//board.printBoard()
//
//if(mode == "u")
//{
//    while(true)
//    {
//        user.promptUser()
//    }
//}
//
//
//
////board.checkBoard()
////board.printBoard()

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


var board = Board(givenSize: size)
let user = User(sendBoard: board)
let bfs = BFS(start: board)
var size = 3


func setSize(sentSize: Int)
{
    size = sentSize
    //print(size)
}

func getBoard() -> Board
{
    board = Board(givenSize: size)
    return board;
}

func getUser() -> User
{
    return user
}

func getBFS() -> BFS
{
    return bfs
}

// Prompts for command line
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

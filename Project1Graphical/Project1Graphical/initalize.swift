////
////  main.swift
////  Project1
////
////  Created by Matt Daniel on 1/30/17.
////

var board = Board(givenSize: size)
let user = User(sendBoard: board)
let bfs = BFS(start: board)
var size = 3


func setSize(sentSize: Int)
{
    size = sentSize
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


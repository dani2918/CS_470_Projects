//
//  changeboard.swift
//  Project1Graphical
//
//  Created by Matt Daniel on 1/31/17.
//  May expand for animations

import Foundation
import Cocoa



func updateTiles(board: Board, labelArray : [[NSButton]], size: Int)
{

    for i in 0..<size
    {
        for j in 0..<size
        {
            //Fill a blank for 0
            if(board.gameBoard[i][j] == 0)
            {
                labelArray[i][j].title = "⬛️"
            }
            //Fill numbers
            else
            {
                labelArray[i][j].title = "\(board.gameBoard[i][j])"
            }
        }
    }
}

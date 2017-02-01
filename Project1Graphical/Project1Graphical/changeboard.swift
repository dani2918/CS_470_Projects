//
//  changeboard.swift
//  Project1Graphical
//
//  Created by Matt Daniel on 1/31/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Foundation
import Cocoa



func updateTiles(board: Board, labelArray : [[NSButton]])
{
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.alignment = .center

    for i in 0..<3
    {
        for j in 0..<3
        {
            if(board.gameBoard[i][j] == 0)
            {
                labelArray[i][j].title = ""
                //labelArray[i][j].color = NSColor.lightGray
            }
            else
            {
                labelArray[i][j].title = "\(board.gameBoard[i][j])"
//                labelArray[i][j].backgroundColor = NSColor.white
            }
        }
    }
}

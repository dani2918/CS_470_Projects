//
//  ViewController.swift
//  Project1Graphical
//
//  Created by Matt Daniel on 1/30/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Cocoa

class ViewController: NSViewController
{
    @IBOutlet weak var gridView: NSCollectionView!
    var labelArray = Array(repeating: Array(repeating: NSButton(), count: 3), count: 3)
    
    @IBOutlet weak var winText: NSTextField!
    var board = getBoard()
    var user = getUser()
    
    @IBAction func resetBoard(_ sender: Any)
    {
        board.setupBoard(moves: 1000)
        updateTiles(board: board, labelArray: labelArray)
        winText.isHidden = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGrid()
        winText.isHidden = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setupGrid()
    {
        let width = gridView.bounds.width
        let height = gridView.bounds.height

        for i in 0..<3
        {
            for j in 0..<3
            {
                let label = NSButton(frame: NSMakeRect(width/3.0 * CGFloat(j), height/3.0 * CGFloat(i), width/3, height/3 ))
                label.title = "\(i) , \(j)"
                label.alignment = NSTextAlignment.center
                label.font = NSFont(name: "Helvetica", size: 50)
                
                label.target = self
                label.action = #selector(ViewController.clickOnTile(sender:))
                
                gridView.addSubview(label)
                labelArray[i][j] = label
            }
        }
       
        updateTiles(board: board, labelArray: labelArray)
    }
    

    func clickOnTile(sender: NSButton)
    {
        board.move(loc: board.getLoc(value: (Int(sender.title) ?? 0)), entryMode: "user")
        updateTiles(board: board, labelArray: labelArray)
        if(board.checkBoard())
        {
            winText.isHidden = false
        }
    }


}


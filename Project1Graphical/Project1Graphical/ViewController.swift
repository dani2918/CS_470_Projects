//
//  ViewController.swift
//  Project1Graphical
//
//  Created by Matt Daniel on 1/30/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Cocoa
import Darwin

class ViewController: NSViewController
{
    //Default starting size
    var size = 3
    //Container for buttons
    @IBOutlet weak var gridView: NSCollectionView!
    var labelArray = Array(repeating: Array(repeating: NSButton(), count: 5), count: 5)
    @IBOutlet weak var winText: NSTextField!
    @IBOutlet weak var sizeText: NSTextField!
    @IBOutlet weak var moveCounter: NSTextField!

   
    var board = getBoard()
    var user = getUser()

    
    
   
    
    
    @IBAction func newGame(_ sender: Any)
    {

        board.setupBoard(moves: 1000*size)
        updateTiles(board: board, labelArray: labelArray, size: size)
        winText.isHidden = true
        let mc = board.getMoveCount()
        moveCounter.stringValue = String(mc)

    }

    
    // Set up board with new dimensions between 3x3 and 5x5
    @IBAction func sizeCount(_ sender: Any)
    {
        if let testSize = Int(sizeText.stringValue)
        {
            if(testSize >= 3 && testSize <= 5)
            {
                size = testSize
                setSize(sentSize: size)
                board = getBoard()
                setupGrid()
                newGame(Any.self)
            }
            else
            {
                size = 3
            }
        }
        else
        {
            size = 3
        }
    }
    
    @IBAction func breadthFirstSearch(_ sender: Any)
    {
        let bfs = BFS(start: board)
        board = bfs.board
        updateTiles(board: board, labelArray: labelArray, size: size)
        bfs.solve()
        board = bfs.getBoard()
        updateTiles(board: board, labelArray: labelArray, size: size)
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
    
    // Called when setting up an initial board or board w new dimensions
    func setupGrid()
    {
        let width = gridView.bounds.width
        let height = gridView.bounds.height

        for i in 0..<size
        {
            for j in 0..<size
            {
                let floatSize = CGFloat(size)
                let label = NSButton(frame: NSMakeRect(width/floatSize * CGFloat(j), height/floatSize * CGFloat(i), width/floatSize, height/floatSize ))
                
                // Scale font size based on board dimsension
                let textSize = CGFloat((size * -1 + 9) * 10)
                // Default labels for debugging (x,y)
                label.title = "\(i) , \(j)"
                label.alignment = NSTextAlignment.center
                label.font = NSFont(name: "Helvetica", size: textSize)
                
                // Add click action
                label.target = self
                label.action = #selector(ViewController.clickOnTile(sender:))
                
                //Add buttons to array of buttons
                gridView.addSubview(label)
                labelArray[i][j] = label
            }
        }
        // Display information on board
        updateTiles(board: board, labelArray: labelArray, size: size)
    }
    
    
    func clickOnTile(sender: NSButton)
    {
//        board.boardList.append(board.gameBoard)
//        print(board.boardList[0])
        
        if(!board.checkBoard())
        {
            // Get tile value or '0' if blank
            board.move(loc: board.getLoc(value: (Int(sender.title) ?? 0)), entryMode: "user")
//            board.moveDirection(dir: "east")
            updateTiles(board: board, labelArray: labelArray, size: size)
        }
        // If user wins, display winning text
        if(board.checkBoard())
        {
            winText.isHidden = false
        }
        let mc = board.getMoveCount()
        moveCounter.stringValue = String(mc)
        
//        if(board.checkBoardsEqual())
//        {
//            print("EQUAL")
//        }
    }
    

}


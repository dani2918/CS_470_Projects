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
    @IBOutlet weak var newButton: NSButton!
    @IBOutlet weak var bfsButton: NSButton!
    @IBOutlet weak var closedList: NSButton!

   
    var board = getBoard()
    var user = getUser()

    
    // Delay function from: http://stackoverflow.com/questions/39787319/add-a-delay-to-a-for-loop-in-swift
    func delay(_ delay:Double, closure:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
   
    // Begin a new game
    @IBAction func newGame(_ sender: NSButton)
    {
        board = Board(givenSize: size)
        bfsButton.isEnabled = true
        board.setupBoard(moves: 1000*size)
        updateTiles(board: board, labelArray: labelArray, size: size)
        winText.isHidden = true
        board.moveCount = 0
        let mc = board.getMoveCount()
        moveCounter.stringValue = String(mc)
    }
    
    


    
    // Set up board with new dimensions between 3x3 and 5x5
    @IBAction func sizeCount(_ sender: NSButton)
    {
        if let testSize = Int(sizeText.stringValue)
        {
            if(testSize >= 3 && testSize <= 5)
            {
                size = testSize
                setSize(sentSize: size)
                board = getBoard()
                setupGrid()
                newButton.performClick(nil)
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
   
    
    // Initiate a BFS
    @IBAction func breadthFirstSearch(_ sender: Any)
    {
        bfsButton.isEnabled = false
        let bfs = BFS(start: board)
        board = bfs.board
        print("size is \(size)")
        updateTiles(board: board, labelArray: labelArray, size: size)
        var movesList = [Board]()
        movesList = bfs.solve(useClosedList: closedList.state == NSOnState)
        print("SOLVED")
        for i in 0..<movesList.count
        {
            // Delay for animated board 
            // Show the moves on the console and application
            let delayTime = Double(i) + 1.0
            delay(delayTime)
            {
                updateTiles(board: movesList[i], labelArray: self.labelArray, size: self.size)
                movesList[i].printBoard()
                
                self.moveCounter.stringValue = String(i+1)
                if(i == movesList.count - 1)
                {
                    self.board = movesList[movesList.endIndex-1]
                    if(self.board.checkBoard())
                    {
                        self.winText.isHidden = false
                    }
                    
                }
            }
            
        }
    }
   
    
    override func viewDidLoad()
    {
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
        
        if(!board.checkBoard())
        {
            // Get tile value or '0' if blank
            board.move(loc: board.getLoc(value: (Int(sender.title) ?? 0)), entryMode: "user")
            updateTiles(board: board, labelArray: labelArray, size: size)
        }
        // If user wins, display winning text
        if(board.checkBoard())
        {
            winText.isHidden = false
        }
        // Show the number of moves used
        let mc = board.getMoveCount()
        moveCounter.stringValue = String(mc)
        

    }
    

}


//
//  ViewController.swift
//  Project2Graphical
//
//  Created by Matt Daniel on 2/22/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Cocoa
import Darwin

class ViewController: NSViewController {

    @IBOutlet var mainView: NSView!
    @IBOutlet weak var boardSpace: NSScrollView!
    var buttonArray = Array(repeating: NSButton(), count: 7)
    var circleArray  = Array(repeating: Array(repeating: NSButton(), count: 7), count: 6)
    var storedBoard = Array(repeating: Array(repeating: 0, count: 7), count: 6)
    var winCondition = false
    var drawCondition = false
    var par: Board? = nil
    var firstPlaythrough = true
    
    // Coloring vars
    @IBOutlet weak var moveCounter: NSTextField!
    @IBOutlet weak var currentTurn: NSColorWell!
    @IBOutlet weak var errText: NSTextField!
    @IBOutlet weak var winText: NSTextField!
    @IBOutlet weak var redAIButton: NSButton!
    @IBOutlet weak var blueAIButton: NSButton!
    @IBOutlet weak var noAIButton: NSButton!
    @IBOutlet weak var bothAIButton: NSButton!
    let blueCol = NSColor.init(red: 55.0/255.0, green: 18.0/255.0, blue: 201.0/255.0, alpha: 1.0)
    let redCol = NSColor.init(red: 214.0/255.0, green: 6.0/255.0, blue: 41.0/255.0, alpha: 1.0)
    var greenCol = NSColor.init(red: 0.0, green: 180.0/255.0, blue: 0.0, alpha: 1.0)
    var curColor = NSColor()
    var turn = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("mainW", mainW, "Gaussw", gausW)
        setupButtons()
        setupBoard()
        setupColors()
        moveCounter.stringValue = ("\(1)")
        turn = 1
        //blueAIButton.state = NSOnState
        par = Board(b: storedBoard)
        if(firstPlaythrough)
        {
            NSEvent.addLocalMonitorForEvents(matching: NSEventMask.keyDown, handler: keyDownEvent)
            firstPlaythrough = false
        }
    }
    
    func keyDownEvent(event: NSEvent) -> NSEvent
    {
        if let x = event.characters
        {
            let button = NSButton()
            button.title = x
            switch(x)
            {
            case "`", "0":
                button.title = "0"
                clickOnButton(sender: button)
                break;
            case "1","2","3","4","5","6":
                clickOnButton(sender: button)
                break;
            default:
                break;
            }
        }
        
        return event
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func reset(_ sender: NSButton)
    {
        buttonArray = Array(repeating: NSButton(), count: 7)
        circleArray  = Array(repeating: Array(repeating: NSButton(), count: 7), count: 6)
        storedBoard = Array(repeating: Array(repeating: 0, count: 7), count: 6)
        winCondition = false
        drawCondition = false
        viewDidLoad()
    }
    
    func setupButtons()
    {
        let width = boardSpace.bounds.width
        let height = boardSpace.bounds.height
        let ymin = boardSpace.frame.minY
        let xmin = boardSpace.frame.minX
        
        for i in 0..<buttonArray.count
        {
            let floatSize = CGFloat(buttonArray.count)
            let label = NSButton(frame: NSMakeRect(width/floatSize * CGFloat(i) + xmin, ymin - 5 - height/floatSize, width/floatSize, height/floatSize ))
            
            let textSize = CGFloat((buttonArray.count * -1 + 9) * 10)
            label.title = "\(i)"
            label.alignment = NSTextAlignment.center
            label.font = NSFont(name: "Helvetica", size: textSize)
            
            // Add click action
            label.target = self
            label.action = #selector(ViewController.clickOnButton(sender:))
            
            //Add buttons to array of buttons
            mainView.addSubview(label)
            buttonArray[i] = label
        }
    }
    
    func setupBoard()
    {
        let width = boardSpace.bounds.width
        let height = boardSpace.bounds.height - 20
        errText.isHidden = true
        winText.isHidden = true
        for i in 0..<6
        {
            for j in 0..<7
            {
                let xSize = CGFloat(7)
                let ySize = CGFloat(6)
                let rect = NSMakeRect(width/xSize * CGFloat(j) + 5.0, height/ySize * CGFloat(i) + 10.0, width/xSize - 10.0 , height/ySize - 5.0 )
                let circButton = Button(frame: rect)
                circButton.tag = i*10+j + 1
                boardSpace.addSubview(circButton)
                circleArray[i][j] = circButton
            }
        }
    }
    
    func setupColors()
    {
        curColor = redCol
        currentTurn.isEnabled = false
        currentTurn.color = curColor
    }
    
    @IBAction func startAIRed(_ sender: NSButton)
    {
        if(redAIButton.state == NSOnState || bothAIButton.state == NSOnState)
        {
            let button = NSButton()
            button.title = "3"
            clickOnButton(sender: button)
        }
    }
    
    func redrawCirc(row: Int, col: Int, nscol: NSColor)
    {
        let width = boardSpace.bounds.width
        let height = boardSpace.bounds.height - 20
        let color = nscol
        let newRow = 5 - row
        let xSize = CGFloat(7)
        let ySize = CGFloat(6)
        let rect = NSMakeRect(width/xSize * CGFloat(col) + 5.0, height/ySize * CGFloat(newRow) + 10.0, width/xSize - 10.0 , height/ySize - 5.0 )
        
        let newCircButton = Button(frame: rect, col: color)
        
        if let taggedView = boardSpace.viewWithTag(newRow*10+col + 1)
        {
            if(!winCondition)
            {
                taggedView.removeFromSuperview()
            }
            circleArray[newRow][col] = NSButton()
        }
        else {  print("No such tag") }
        newCircButton.tag = newRow*10+col + 1
//        let textSize = CGFloat((buttonArray.count * -1 + 9) * 10)
//        newCircButton.title = "\(turn)"
//        newCircButton.alignment = NSTextAlignment.center
//        newCircButton.font = NSFont(name: "Helvetica", size: textSize)
        boardSpace.addSubview(newCircButton)
        circleArray[newRow][col] = newCircButton
        
    }
    
    func clickOnButton(sender: NSButton)
    {
        if (winCondition || drawCondition)
        {
            return
        }
        errText.isHidden = true
        let sentInt = Int(sender.title)!
        var firstOpen = 6
        for i in 0..<6
        {
            if(storedBoard[i][sentInt] == 0)
            {
                firstOpen = i
                break
            }
        }
        if(firstOpen > 5)
        {
            // Error function
            errText.isHidden = false
            return
        }
        redrawCirc(row: firstOpen, col: sentInt, nscol: curColor)
        
        // Red/p1 turn
        if (turn % 2 == 1)
        {
            storedBoard[firstOpen][sentInt] = 1
        }
        // Blue/p2 turn
        else
        {
            storedBoard[firstOpen][sentInt] = 2
        }
        var board: Board?
        board = Board(b: storedBoard, os: 6*7+1 - turn)
//        print(board!.eval)
        if(board!.openSpaces == 0)
        {
//            print("BOARD FULL")
            drawCondition = true
            winText.stringValue = "DRAW"
            winText.textColor = greenCol
            winText.isHidden = false
            return
        }
        
        let winCond = board!.checkBoard(row: firstOpen, col: sentInt, checkVal: storedBoard[firstOpen][sentInt])
        
//        print("Max is: ", board.maxCorrect)
        
        if(winCond != 0)
        {
            // Red/p1 turn
            if (turn % 2 == 1)
            {
                winText.stringValue = "Red Wins"
                winText.textColor = redCol
            }
                // Blue/p2 turn
            else
            {
                winText.stringValue = "Blue Wins"
                winText.textColor = blueCol
            }
            winText.isHidden = false
            winCondition = true
            
            let b = board!.getSoln()
            let yellowColor = NSColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
            var found = false
            for i in 0..<6
            {
                for j in 0..<7
                {
                    for k in 0..<b.count
                    {
                        if((b[k].0 == i && b[k].1 == j))
                        {
                            found = true
                        }
//                print(b[i].0)
                    }
                    if(!found)
                    {
                        redrawCirc(row: i, col: j, nscol: yellowColor)
                    }
                    found = false
                }
            }
        }
        else
        {
            moveCounter.stringValue = ("\(((turn+2)/2))")
            turn += 1
            changeCol()
            
//             Starting negamax
            var color: Int
            if(curColor == blueCol && (blueAIButton.state == NSOnState || bothAIButton.state == NSOnState))
            {
                color = -1
                let n = negaMaxInit(b: board, color: color)
                let button = NSButton()
                button.title = String(n)
                clickOnButton(sender: button)
                
            }
            else if(curColor == redCol && (redAIButton.state == NSOnState || bothAIButton.state == NSOnState))
            {
                color = 1
                let n = negaMaxInit(b: board, color: color)
                let button = NSButton()
                button.title = String(n)
                clickOnButton(sender: button)
//                print("n is: \(n), board is:")
//                b.printBoard()
            }

    
        }
        board = nil
        par = nil
//        print("open is:", open)
//        print("closed is:", closed)
//        print("diff IS:",open-closed)
//        
//        open = open - closed
//        closed = 0
//        counter = 0
    }
    
    func changeCol()
    {
        if curColor == redCol
        {
            curColor = blueCol
        }
        else
        {
            curColor = redCol
        }
        currentTurn.color = curColor
    }
    
    @IBAction func aiRadioButtons(_ sender: NSButton)
    {
        // Connects radio buttons
        
    }
    
    

}


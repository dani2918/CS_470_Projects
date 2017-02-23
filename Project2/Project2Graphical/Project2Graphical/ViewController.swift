//
//  ViewController.swift
//  Project2Graphical
//
//  Created by Matt Daniel on 2/22/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var mainView: NSView!
    @IBOutlet weak var boardSpace: NSScrollView!
    
    var buttonArray = Array(repeating: NSButton(), count: 7)
    var circleArray  = Array(repeating: Array(repeating: NSButton(), count: 7), count: 6)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupBoard()
        
        
        redrawCirc(row: 1, col: 0, nscol: NSColor.red)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    
    func setupButtons()
    {
        let width = boardSpace.bounds.width
        let height = boardSpace.bounds.height
        let ymin = boardSpace.frame.minY
        let xmin = boardSpace.frame.minX
//        print(ymin,ymax)
        
        for i in 0..<buttonArray.count
        {
            let floatSize = CGFloat(buttonArray.count)
            let label = NSButton(frame: NSMakeRect(width/floatSize * CGFloat(i) + xmin, ymin - 5 - height/floatSize, width/floatSize, height/floatSize ))
            
            let textSize = CGFloat((buttonArray.count * -1 + 9) * 10)
            // Default labels for debugging (x,y)
            label.title = "\(i)"
            label.alignment = NSTextAlignment.center
            label.font = NSFont(name: "Helvetica", size: textSize)
            
            // Add click action
            label.target = self
//            label.action = #selector(ViewController.clickOnTile(sender:))
            
            //Add buttons to array of buttons
            mainView.addSubview(label)
            buttonArray[i] = label
        }
        
    }
    
    func setupBoard()
    {
        let width = boardSpace.bounds.width
        let height = boardSpace.bounds.height - 20
        
        for i in 0..<6
        {
            for j in 0..<7
            {
                let xSize = CGFloat(7)
                let ySize = CGFloat(6)
                let rect = NSMakeRect(width/xSize * CGFloat(j) + 5.0, height/ySize * CGFloat(i) + 10.0, width/xSize - 10.0 , height/ySize - 5.0 )
                let circButton = Button(frame: rect)
                circButton.tag = i*10+j
                boardSpace.addSubview(circButton)
                circleArray[i][j] = circButton
                
            }
        }

    }
    
    
    func redrawCirc(row: Int, col: Int, nscol: NSColor)
    {
        let width = boardSpace.bounds.width
        let height = boardSpace.bounds.height - 20
        let color = nscol
        let newRow = 6 - row
  
        let xSize = CGFloat(7)
        let ySize = CGFloat(6)
        let rect = NSMakeRect(width/xSize * CGFloat(col) + 5.0, height/ySize * CGFloat(newRow) + 10.0, width/xSize - 10.0 , height/ySize - 5.0 )
        
        let newCircButton = Button(frame: rect, col: color)
        
        if let taggedView = boardSpace.viewWithTag(newRow*10+col)
        {
            taggedView.removeFromSuperview()
            circleArray[newRow][col] = NSButton()
        }
        else {   }
        newCircButton.tag = newRow*10+col
        boardSpace.addSubview(newCircButton)
        circleArray[newRow][col] = newCircButton
        
    }


}


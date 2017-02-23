//
//  button.swift
//  Project2Graphical
//
//  Created by Matt Daniel on 2/22/17.
//  Copyright © 2017 Matthew Daniel. All rights reserved.
//

import Foundation
import Cocoa

class Button: NSButton
{
    var color = NSColor.clear
    
    init(frame: NSRect, col: NSColor)
    {
        super.init(frame: frame)
        self.color = col
    }
    
    override init(frame: NSRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)
        
        NSColor.clear.setFill()
        NSRectFill(dirtyRect)
//        self.layer?.backgroundColor = CGColor.black
        var path = NSBezierPath(ovalIn: dirtyRect)
        color.setFill()
        path.fill()
        NSColor.black.setStroke()
        path.stroke()
    }
}

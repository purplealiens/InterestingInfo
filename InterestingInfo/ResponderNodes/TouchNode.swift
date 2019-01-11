//
//  TouchNode.swift
//  InterestingInfo
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//


// Present either photo, textual info, or table detail button

import UIKit
import SpriteKit


extension Notification.Name {
    public static let TapToShowTable = NSNotification.Name("TapToShowTable")
    public static let TapToOpenClose = NSNotification.Name("TapToOpenClose")
}


enum NodeType {
    case photonode
    case textnode
    case tablenode
}


struct Rect {
    var origin = CGPoint(x: 0.0, y: 0.0)
    var size = CGSize(width: 0.0, height: 0.0)
}


extension CGRect {
    init(center: CGPoint, size: CGSize){
        let xOrigin = center.x - (size.width / 2.0)
        let yOrigin = center.y - (size.height / 2.0)
        
        self.init(origin:CGPoint(x: xOrigin, y: yOrigin), size: size)
    }
}


class TouchNode : SKShapeNode {
    
    var photo:UIImage?
    var textName:String?
    var type:NodeType = .photonode
    var height:CGFloat = 160.0
    var width:CGFloat{
        get {
            return height/2.0
        }
    }
    
    
    // MARK: - Sprite Constructions
    
    func addOverlayColors(node: SKShapeNode, type:NodeType) {
        
        switch type {
            case .photonode:
                self.name = "photo"
                node.strokeColor = SKColor.red
                node.fillColor = SKColor.red
            case .textnode:
                self.name = "text"
                node.strokeColor = SKColor.white
                node.fillColor = SKColor.white
            case .tablenode:
                self.name = "button"
                node.strokeColor = SKColor.gray
                node.fillColor = SKColor.gray
        }
    }
    
    
    func addPhoto() {
        let person = SKSpriteNode(imageNamed: "person.png")
        person.position = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
        person.alpha = 0.8
        person.isUserInteractionEnabled = false
        person.zPosition = 10.0
        self.zPosition = 9.0
        self.addChild(person)
    }
    
    
    func addText() {
        let titleNode = SKLabelNode(fontNamed: "Helvetica Neue")
        titleNode.text = textName
        titleNode.fontSize = 26.0
        titleNode.fontColor = SKColor.green
        titleNode.position = CGPoint(x: self.frame.width/2.0, y:self.frame.height/2.0 )
        titleNode.isUserInteractionEnabled = false
        self.zPosition = 200
        self.addChild(titleNode)
    }
    
    
    func addTextImage() {
        let notes = SKSpriteNode(imageNamed: "notes.png")
        notes.position = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
        notes.alpha = 1.0
        notes.zPosition = 2.0
        self.zPosition = -5.0
        self.addChild(notes)
        
        let titleNode = SKLabelNode(fontNamed: "Helvetica Neue")
        titleNode.text = textName
        titleNode.fontSize = 26.0
        titleNode.fontColor = SKColor.green
        titleNode.position = CGPoint(x: self.frame.width/2.0, y:self.frame.height/2.0 )
        titleNode.isUserInteractionEnabled = false
        //self.zPosition = 200
        self.addChild(titleNode)
    }
    
    
    func addButtonArrow() {
        let titleNode = SKLabelNode(fontNamed: "Helvetica Neue")
        titleNode.text = ">"
        titleNode.fontSize = 26.0
        titleNode.fontColor = SKColor.darkGray
        titleNode.position = CGPoint(x: 0.0, y: self.frame.height/2.0)
        titleNode.isUserInteractionEnabled = false
        self.zPosition = 50.0
        self.addChild(titleNode)
    }
    
    
    func addOverlayFeatures(node: SKShapeNode, type:NodeType) {
  
        switch type {
            case .photonode:
                addPhoto()
            case .textnode:
                addText()
                addTextImage()
            case .tablenode:
                addText()
                //addButtonArrow()
        }
    }
    
    
    func buildSpriteOverlay(type:NodeType, name:String? = nil) {

        if name != nil {
            textName = name
        }
        self.isUserInteractionEnabled = true
        
        let rect = CGRect(x:self.frame.origin.x,
                         y:self.frame.origin.y,
                         width: self.frame.width,
                         height: self.frame.height)
        
        let node = SKShapeNode(rect: rect, cornerRadius: 5.0)
        node.lineWidth = 1.5
        node.alpha = 1.0
        
        // SKShapeNode are for appearance, let parent TouchNode respond to touch
        node.isUserInteractionEnabled = false
        
        addOverlayColors(node: node, type:type)
        addOverlayFeatures(node: node, type:type)
        
        self.addChild(node)
    }
    
    
     // MARK: - Post Notifications
    func postOpenDoorMessage() {
        NotificationCenter.default.post(name: .TapToOpenClose,
                                        object: self,
                                        userInfo: nil)
    }
    
    
    func postShowTableMessage() {
        NotificationCenter.default.post(name: .TapToShowTable,
                                        object: self,
                                        userInfo: nil)
    }
    
    
    // MARK: - Touch
    func touchDown(atPoint pos : CGPoint) {
        
        if self.name == "photo"  {
            postOpenDoorMessage()
        }
        else if self.name == "button" {
            postShowTableMessage()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self.scene!)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
}

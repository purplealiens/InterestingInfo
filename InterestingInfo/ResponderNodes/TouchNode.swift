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
    case photonodetesttext

    case textnode
    case tablenode
}


class TouchNode : SKShapeNode {
    
    var photo:UIImage?
    var text:String?
    var type:NodeType
    var width = 160.0
    var height = 170.0
    var buttonThickness: Double {
        get {
            return width/3.0
        }
    }

     init(type: NodeType) {
        self.type = type
        self.type = type
        super.init()
        
        buildSprite()
    }
    
    convenience init(photo: String, type: NodeType) {
        self.init(type:type)
        self.text = photo
    }
    
    convenience init(photo: UIImage, type: NodeType) {
        self.init(type:type)
        self.photo = photo
    }
    
    convenience init(text: String, type: NodeType) {
        self.init(type:type)
        self.text = text
    }
    
    convenience init(withType: NodeType = .tablenode) {
        self.init(type:withType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Sprite Construction

    func buildSprite() {
        
        if type == .tablenode {
            // 3rd panel is button to table
            width = buttonThickness
        }
        
        let rect = CGRect(x:0, y:0, width: width, height: height)
        let node = SKShapeNode(rect: rect, cornerRadius: 5.0)
        
        //let node = SKShapeNode.init(circleOfRadius: 50.0)
        node.lineWidth = 1.5
        node.alpha = 1.0
        
        node.isUserInteractionEnabled = true
        
        switch type {
            case .photonodetesttext:
                // display photograph
                node.name = "photo"
                node.strokeColor = SKColor.red
                node.fillColor = SKColor.red
            case .photonode:
                node.name = "photo"
                node.strokeColor = SKColor.red
                node.fillColor = SKColor.red
            case .textnode:
                node.name = "text"
                node.strokeColor = SKColor.white
                node.fillColor = SKColor.white
            case .tablenode:
                node.name = "button"
                node.strokeColor = SKColor.gray
                node.fillColor = SKColor.gray
        }
        
        node.position = CGPoint(x: 0.0, y: 0.0)
        
        self.addChild(node)
    }
    
    
    func openDoor() {
        
        NotificationCenter.default.post(name: .TapToOpenClose,
                                        object: self,
                                        userInfo: nil)
        
    }
    
    
    func showTable() {
        
        NotificationCenter.default.post(name: .TapToShowTable,
                                        object: self,
                                        userInfo: nil)
    }
    
    
    // MARK: - Touch
    func touchDown(atPoint pos : CGPoint) {
        
        if self.name == "photo"  {
            openDoor()
        }
        else if self.name == "button" {
            showTable()
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

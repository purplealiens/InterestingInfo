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
    var type:NodeType = .photonode
    var height:CGFloat = 160.0
    var width:CGFloat{
        get {
            return height/2.0
        }
    }
    
    // MARK: - Sprite Construction
    func buildSpriteOverlay(type:NodeType) {

        self.isUserInteractionEnabled = true
        
        let rect = CGRect(x:0, y:0, width: width, height: height)
        
        let node = SKShapeNode(rect: rect, cornerRadius: 5.0)
        node.lineWidth = 1.5
        node.alpha = 1.0
        
        // SKShapeNode are for appearance, let parent TouchNode respond to touch
        node.isUserInteractionEnabled = false
        
        switch type {
            case .photonodetesttext:
                // display photograph
                self.name = "photo"
                node.strokeColor = SKColor.red
                node.fillColor = SKColor.clear
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
        node.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(node)
    }
    
    
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

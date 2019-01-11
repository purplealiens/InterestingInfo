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
    var text:String?
    var type:NodeType = .photonode
    var height:CGFloat = 160.0
    var width:CGFloat{
        get {
            return height/2.0
        }
    }
    
    
    // MARK: - Sprite Construction
    
    func addOverlayColors(node: SKShapeNode, type:NodeType) {
        
        switch type {
            case .photonodetesttext:
                // display photograph
                self.name = "photo"
                node.strokeColor = SKColor.red
                node.fillColor = SKColor.red
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
    
    
    func addOverlayFeatures(node: SKShapeNode, type:NodeType) {
  /*
        switch type {
            case .photonodetesttext:
      
            case .photonode:

            case .textnode:

            case .tablenode:
        }
 */
    }
    
    
    func buildSpriteOverlay(type:NodeType) {

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
        node.position = CGPoint(x: 0.0, y: 0.0)
        
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

//
//  TouchNodeBundle.swift
//  InterestingInfo
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//

// groups a photo, textual info, or table detail button
// establishes location of group
// ignores touch eventa

import UIKit
import SpriteKit

class TouchNodeBundle : SKShapeNode{
    
    private (set) var photoNode: TouchNode?
    private (set) var textNode: TouchNode?
    private (set) var tableButtonNode: TouchNode?
    private (set) var bookIsOpen: Bool?
    
    
    var nodeOnePosition:CGPoint{
        get {
            return CGPoint(x: 0.0, y: 0.0)
        }
    }
    var nodeTwoPosition:CGPoint{
        get {
            return CGPoint(x: 80.0, y: 0.0)
        }
    }
    var nodeThreePosition:CGPoint{
        get {
            return CGPoint(x: 160.0, y: 0.0)
        }
    }
    
    var height:CGFloat = 160.0
    var width:CGFloat{
        get {
            return height/2.0
        }
    }
    
    
    func positionNodes() {
 
        self.isUserInteractionEnabled = true
        
        let rect1 = CGRect(x:0, y:0, width: 2.0 * width, height: height)
        let rect2 = CGRect(x:0, y:0, width: 2.0 * width, height: height)
        let rect3 = CGRect(x:0, y:0, width: width, height: 0.75*height)
        
        let photoInfoTouchNode = TouchNode(rect: rect1, cornerRadius: 5.0)
        let textInfoTouchNode = TouchNode(rect: rect2, cornerRadius: 5.0)
        let tableButtonTouchNode = TouchNode(rect: rect3, cornerRadius: 5.0)
        
        photoInfoTouchNode.strokeColor = SKColor.blue
        photoInfoTouchNode.fillColor = SKColor.blue
    
        
        photoInfoTouchNode.buildSpriteOverlay(type: .photonodetesttext)
        textInfoTouchNode.buildSpriteOverlay(type: .textnode)
        tableButtonTouchNode.buildSpriteOverlay(type: .tablenode)
        
        self.addChild(photoInfoTouchNode)
        self.addChild(textInfoTouchNode)
        self.addChild(tableButtonTouchNode)
        
        self.photoNode = photoInfoTouchNode
        self.textNode = textInfoTouchNode
        self.tableButtonNode = tableButtonTouchNode
        
        self.bookIsOpen = false

        photoNode!.position = nodeOnePosition
        textNode!.position = nodeTwoPosition
        tableButtonNode!.position = nodeThreePosition
        
        createSpriteInfoNotifications()
    }
    
    
    func toggleBookOpen() {
        // when user taps "photo" book
        if bookIsOpen == true {
            bookIsOpen = false
            
            // close book
            textNode!.run(SKAction.moveBy(x: -160.0/2.0, y: 0.0, duration: 1.0))
            tableButtonNode!.run(SKAction.sequence([SKAction.wait(forDuration: 0.2),
                                        SKAction.moveBy(x: -160.0/2.0 - 160.0/3.0 , y: 0.0, duration: 1.0)]))
        }
        else {
            bookIsOpen = true
            // open book
            tableButtonNode!.run(SKAction.moveBy(x: 160.0/2.0 + 160.0/3.0, y: 0.0, duration: 1.0))
            textNode!.run(SKAction.sequence([SKAction.wait(forDuration: 0.2),
                                                   SKAction.moveBy(x: 160.0/2.0 , y: 0.0, duration: 1.0)]))
        }
    }
    
    
    // MARK: - Notifications
    
    func createSpriteInfoNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doorOpenCloseTapped(_:)),
                                               name: .TapToOpenClose,
                                               object: photoNode)
        
    }
    
    
    func unsubscribe() {
        NotificationCenter.default.removeObserver(self, name: .TapToOpenClose, object: nil)
        
    }
    
    
    deinit {
        unsubscribe()
    }
    
    
    @objc
    func doorOpenCloseTapped(_ notification: Notification) {
        
        toggleBookOpen()
        // get info from notification and build dict to pass to tableview
        // if let shapeInfoNode = notification.object as? ResponderShapeAlertNode {//
        // popup dialog
        // performSegue(withIdentifier:"showMeDue", sender:shapeInfoNode)
        //}
    }
    
}

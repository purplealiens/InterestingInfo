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
    private (set) var textNode: TouchNode
    private (set) var tableButtonNode: TouchNode
    private (set) var bookIsOpen: Bool
    
    var r: Double
    var theta: Double
    var width: Double
    var height: Double

    init(photo: UIImage, text: String, rect: CGRect, cornerRadius: CGFloat) {

        let photoInfoTouchNode = TouchNode(photo: photo, type: .photonode)
        let textInfoTouchNode = TouchNode(text: text, type: .textnode)
        let tableButtonTouchNode = TouchNode()
    
        self.photoNode = photoInfoTouchNode
        self.textNode = textInfoTouchNode
        self.tableButtonNode = tableButtonTouchNode
        
        self.bookIsOpen = false
        
        self.r = 0.0
        self.theta = 0.0
        
        self.width = 640.0
        self.height = 170.0
        
        //self.init(rect: rect, cornerRadius: cornerRadius)
    }
    
    
    // tester
    init(photo: String, text: String, rect: CGRect, cornerRadius: CGFloat) {
        
        let photoInfoTouchNode = TouchNode(photo: photo, type: .photonodetesttext)
        let textInfoTouchNode = TouchNode(text: text, type: .textnode)
        let tableButtonTouchNode = TouchNode()
        
        self.photoNode = photoInfoTouchNode
        self.textNode = textInfoTouchNode
        self.tableButtonNode = tableButtonTouchNode
        
        self.bookIsOpen = false
        
        self.r = 0.0
        self.theta = 0.0
        
        self.width = 640.0
        self.height = 170.0
        
        //super.init(rect: rect, cornerRadius: cornerRadius)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func positionNodes() {
        
 
        infoBack.lineWidth = 1.5
        infoBack.alpha = 0.0
        infoBack.setScale(0.1)
        infoBack.name = "X"
        infoBack.isUserInteractionEnabled = true
        infoBack.strokeColor = SKColor.black
        infoBack.fillColor = SKColor.black
        infoBack.position = CGPoint(x: 0.0, y: 0.0)
        
        self.scene!.addChild(infoBack)
        
        infoBack.addChild(photoNode!)
        infoBack.addChild(textNode)
        infoBack.addChild(tableButtonNode)
        
        let node1 = CGPoint(x: -160.0, y: 0.0)
        let node2 = CGPoint(x: 0.0, y: 0.0)
        let node3 = CGPoint(x: 160.0, y: 0.0)
        photoNode?.position = node1
        textNode.position = node2
        tableButtonNode.position = node3
        
        createSpriteInfoNotifications()
    }
    
    
    func toggleBookOpem() {
        // when user taps book
        if bookIsOpen == true {
            bookIsOpen = false
            
            //let negDelta = CGVector(dx: -deltaX, dy: -deltaY)
            //let action = SKAction.moveBy(x: -deltaX, y: -deltaX, duration: sec)
            
            // close book
            textNode.run(SKAction.moveBy(x: -160.0/2.0, y: 0.0, duration: 1.0))
            tableButtonNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.2),
                                        SKAction.moveBy(x: -160.0/2.0 - 160.0/3.0 , y: 0.0, duration: 1.0)]))
        }
        else {
            bookIsOpen = true
            // open book
            tableButtonNode.run(SKAction.moveBy(x: 160.0/2.0 + 160.0/3.0, y: 0.0, duration: 1.0))
            textNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.2),
                                                   SKAction.moveBy(x: 160.0/2.0 , y: 0.0, duration: 1.0)]))
        }
    }
    
    
    // MARK: - Notifications
    
    func createSpriteInfoNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doorOpenCloseTapped(_:)),
                                               name: .TapToOpenClose,
                                               object: nil)
        
    }
    
    
    func unsubscribe() {
        NotificationCenter.default.removeObserver(self, name: .TapToOpenClose, object: nil)
        
    }
    
    
    deinit {
        unsubscribe()
    }
    
    
    @objc
    func doorOpenCloseTapped(_ notification: Notification) {
        
        toggleBookOpem()
        // get info from notification and build dict to pass to tableview
        // if let shapeInfoNode = notification.object as? ResponderShapeAlertNode {//
        // popup dialog
        // performSegue(withIdentifier:"showMeDue", sender:shapeInfoNode)
        //}
    }
    
    
    
    
}

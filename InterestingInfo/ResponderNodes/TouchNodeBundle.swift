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
    
    var height:CGFloat = 160.0
    var width:CGFloat{
        get {
            return height/2.0
        }
    }
    
    
    func buildNodes(withName: String) {
 
        self.isUserInteractionEnabled = true
        self.strokeColor = SKColor.clear
        
        let bw = self.frame.width
        let bh = self.frame.height
        
        // base all dimensions pn width/height of bundle
        let center1 = CGPoint(x: bw * (9.0/40.0), y: bh/2.0)
        let center2 = CGPoint(x: 0.5*bw * (27.0/40.0), y: bh/2.0)
        let center3 = CGPoint(x: 0.6*bw * (19.0/20.0), y: bh/2.0)
        
        let size1 = CGSize(width: bw * (9.0/20.0), height: bh)
        let size2 = CGSize(width: bw * (9.0/20.0), height: bh)
        let size3 = CGSize(width: bw/10.0, height: bh/3.0)
        
        let rect1 = CGRect(center: center1, size: size1)
        let rect2 = CGRect(center: center2, size: size2)
        let rect3 = CGRect(center: center3, size: size3)
        
        let photoInfoTouchNode = TouchNode(rect: rect1, cornerRadius: 5.0)
        let textInfoTouchNode = TouchNode(rect: rect2, cornerRadius: 5.0)
        let tableButtonTouchNode = TouchNode(rect: rect3, cornerRadius: 5.0)
        
        // The parents are outlines that respond to touch, the children paint the picture
        photoInfoTouchNode.strokeColor = SKColor.blue
        textInfoTouchNode.strokeColor = SKColor.white
        tableButtonTouchNode.strokeColor = SKColor.gray
        
        photoInfoTouchNode.buildSpriteOverlay(type: .photonode)             // On touch opens "note detail"
        textInfoTouchNode.buildSpriteOverlay(type: .textnode, name: withName)  
        tableButtonTouchNode.buildSpriteOverlay(type: .tablenode)           // On touch segues to table
        
        self.addChild(textInfoTouchNode)
        self.addChild(photoInfoTouchNode)
        self.addChild(tableButtonTouchNode)
        
        self.photoNode = photoInfoTouchNode
        self.textNode = textInfoTouchNode
        self.tableButtonNode = tableButtonTouchNode
        
        self.bookIsOpen = false

        createSpriteInfoNotifications()
    }
    
    
    func openBook() {
        guard bookIsOpen == false else { return }

        tableButtonNode!.run(SKAction.moveBy(x: 180.0/2.0, y: 0.0, duration: 0.9))
        textNode!.run(SKAction.moveBy(x: 180.0/2.0, y: 0.0, duration: 0.9))
        bookIsOpen = true
    }
    
    
    func closeBook() {
        guard bookIsOpen == true else { return }

        textNode!.run(SKAction.moveBy(x: -180.0/2.0, y: 0.0, duration: 0.9))
        tableButtonNode!.run(SKAction.moveBy(x: -180.0/2.0, y: 0.0, duration: 0.9))
        bookIsOpen = false
    }
    
    
    func toggleBookOpen() {
        // when user taps "photo" book
        if bookIsOpen == true {
            closeBook()
        }
        else {
            openBook()
        }
    }
    
    
    // MARK: - Observe Notifications
    
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
    }
    
}

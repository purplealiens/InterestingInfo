//
//  NodeBundleListBuilder.swift
//  InterestingInfo
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//

//  Reteieves data from either file or thorugh RESTful data
// builds list and hands off to positioner for placement

import UIKit
import SpriteKit

class  NodeBundleListBuilder {
    var touchNodeBundleList = [TouchNodeBundle]()
    
    var stringData = [String]()  // get from files or REST Data
    var imageData = [UIImage]()   // get from files or REST Data
    var width:CGFloat
    var height:CGFloat
    
    init() {
        self.width = 360.0
        self.height = 170.0
    }
    
    
    func getData(strings: [String], images: [UIImage], toScene:SKScene) {
        
        var indx = 0
        for _ in strings {
            addNodeBundle(photo: images[indx], text: strings[indx], toScene:toScene)
            indx += 1
        }
    }
    
    
    func getDataTest(toScene:SKScene) {
        
        let strings = ["Tim S.", "Chetan R.", "Jan L.", "Dexter H.", "Kim Y."]
        let stringsImages = ["image 1", "image 2", "image 3", "image 4", "image 5"]
        var indx = 0
        for _ in strings {
            addNodeBundle(photo: strings[indx], text: stringsImages[indx], toScene:toScene)
            indx += 1
        }
    }
    
    
    func addNodeBundle(photo: UIImage, text: String, toScene:SKScene) {
        
        let rect = CGRect(x:0, y:0, width:360.0 , height: 170.0)
        let newItem = TouchNodeBundle.init(rect: rect, cornerRadius: 5.0)
        toScene.addChild(newItem)
        
        touchNodeBundleList.append(newItem)
    }
    
    
    func addNodeBundle(photo: String, text: String, toScene:SKScene) {
        
        let rect = CGRect(x:0.0, y: 0.0, width: width, height: height)
        let newItem = TouchNodeBundle.init(rect: rect, cornerRadius: 5.0)
        
        newItem.positionNodes()
        newItem.strokeColor = SKColor.clear
        
        toScene.addChild(newItem)
        
        touchNodeBundleList.append(newItem)
    }
    
    
    func getNodeBundleList() -> [TouchNodeBundle]{
    
        return touchNodeBundleList
    }
    
}

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
    
    
    
    func getData(strings: [String], images: [UIImage], toScene:SKScene) {
        
        var indx = 0
        for _ in strings {
            addNodeBundle(photo: images[indx], text: strings[indx], toScene:toScene)
            indx += 1
        }
    }
    
    
    func getDataTest(toScene:SKScene) {
        
        let strings = ["text 1", "text 2", "text 3", "text 4", "text 5" ]
        let stringsImages = ["image 1", "image 2", "image 3", "image 4", "image 5" ]
        var indx = 0
        for _ in strings {
            addNodeBundleTest(photo: strings[indx], text: stringsImages[indx], toScene:toScene)
            // addNodeBundle(photo: string[indx], text: stringsImages[indx])
            indx += 1
        }
    }
    
    
    func addNodeBundle(photo: UIImage, text: String, toScene:SKScene) {
        
        let rect = CGRect(x:0, y:0, width:360.0 , height: 170.0)
        let newItem = TouchNodeBundle.init(rect: rect, cornerRadius: 5.0)
        toScene.addChild(newItem)
        
        touchNodeBundleList.append(newItem)
    }
    
    /*
 
 func addNodeBundle(photo: UIImage, text: String, toScene:SKScene) {
 

 let newItem = TouchNodeBundle.init(photo: photo, text: text)
 
 touchNodeBundleList.append(newItem)
 }*/
    
    
    func addNodeBundleTest(photo: String, text: String, toScene:SKScene) {
        
        let rect = CGRect(x:0 , y: 0, width: 360.0, height: 170.0)
        let newItem = TouchNodeBundle.init(rect: rect, cornerRadius: 5.0)
        
        newItem.positionNodes()
        
        toScene.addChild(newItem)
        
        touchNodeBundleList.append(newItem)
    }
    
    
    func getNodeBundleList() -> [TouchNodeBundle]{
    
        return touchNodeBundleList
    }
    
}

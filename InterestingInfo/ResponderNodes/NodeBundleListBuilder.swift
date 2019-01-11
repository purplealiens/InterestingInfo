//
//  NodeBundleListBuilder.swift
//  InterestingInfo
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//

//  Reteieves data from either file or through RESTful API
//  builds list and hands off to positioner for placement

import UIKit
import SpriteKit

class  NodeBundleListBuilder {
    
    private (set) var touchNodeBundleList = [TouchNodeBundle]()
    private (set) var stringData: [String] = ["Tim S.", "Chetan R.", "Jan L.", "Dexter H.", "Kim Y."]  // single source of data used throughout
    private (set) var width: CGFloat
    private (set) var height: CGFloat
    let scene: SKScene
    
    
    init(scene: SKScene) {
        self.width = 360.0
        self.height = 170.0
        self.scene = scene
    }
    
    
    func processData() {
        
        for item in stringData {
            addNodeBundle(text: item)
        }
    }
    
    
    func addNodeBundle(text: String) {
        
        let rect = CGRect(x:0.0, y: 0.0, width: width, height: height)
        let newItem = TouchNodeBundle.init(rect: rect, cornerRadius: 5.0)
        
        newItem.positionNodes(text: text)
        
        scene.addChild(newItem)
        
        touchNodeBundleList.append(newItem)
    }
    
    
    func getNodeBundleList() -> [TouchNodeBundle]{
    
        return touchNodeBundleList
    }
    
    
    func getNodeBundleListData() -> [String]{
        
        return stringData
    }
    
}

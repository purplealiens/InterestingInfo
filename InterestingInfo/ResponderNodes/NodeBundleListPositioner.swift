//
//  NodeBundleListPositioner.swift
//  InterestingInfo
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//

import UIKit
import SpriteKit

class NodeBundleListPositioner {
    
    var touchNodeBundleList:[TouchNodeBundle]?
    
    var randomRadius: Double {
        get {
            return Double.random(in: 50.0 ..< 400.0)
        }
    }
    
    
    var randomTheta: Double {
        get {
            return Double.random(in: 0.0..<360.0)*Double.pi/180.0
        }
    }
    
    
    init(bundleList: [TouchNodeBundle]){
        self.touchNodeBundleList = bundleList
    }
    
    
    func positionLinaer() {
        var yshift = -480.0
        for item in touchNodeBundleList! {
            let x = -205.0
            let y = yshift
            yshift += 200.0
            item.position = CGPoint(x: x, y: y)
        }
    }
    
    
    func positionRandomCircle() {
        for item in touchNodeBundleList! {
            let x = randomRadius * cos(randomTheta)
            let y = randomRadius * sin(randomTheta)
            
            item.position = CGPoint(x: x, y: y)
        }
    }
    
    
    func positionCircle() {
        let radius = 280.0
        var randomTheta = 0.0
        
        for item in touchNodeBundleList! {
            let x = radius * cos(randomTheta*Double.pi/180.0)
            let y = radius * sin(randomTheta*Double.pi/180.0)
            
            item.position = CGPoint(x: x, y: y)
            
            randomTheta += 72.0
        }
    }
    
}



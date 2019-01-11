//
//  GameViewController.swift
//  InterestingInfo
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    
                    let nodeBundleListBuilder = NodeBundleListBuilder()
                    
                    //nodeBundleListBuilder.getData(strings: [String], images: [UIImage])
                    nodeBundleListBuilder.getDataTest(toScene:sceneNode)
                    let nodeBundleListPositioner = NodeBundleListPositioner(bundleList:nodeBundleListBuilder.getNodeBundleList())
                    nodeBundleListPositioner.positionLinaer()
                    
                    createSpriteNotifications()
                }
            }
        }
    }
    

    
    @objc
    func tableShowTapped(_ notification: Notification) {
        
        // get info from notification and build dict to pass to tableview
        // if let shapeInfoNode = notification.object as? ResponderShapeAlertNode {//
        // popup dialog
        // performSegue(withIdentifier:"showMeDue", sender:shapeInfoNode)
        //}
        if let touchInfoNode = notification.object as? TouchNode {
            // popup dialog
            performSegue(withIdentifier:"infoTableSegue", sender:touchInfoNode)
        }
        
    }
    
    
    func createSpriteNotifications() {

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(tableShowTapped(_:)),
                                               name: .TapToShowTable,
                                               object: nil)
    }
    
    
    func unsubscribe() {
        
        NotificationCenter.default.removeObserver(self, name: .TapToShowTable, object: nil)
    }
    
    
    deinit {
        unsubscribe()
    }
    
    // MARK:- Segue actinos
    @IBAction func unwindCancelAction(unwindSegue: UIStoryboardSegue){
        
        //showHideCompletedControl()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // "segue" source, destination, idetifier
        // sender, object that initiated the segue,
        

    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

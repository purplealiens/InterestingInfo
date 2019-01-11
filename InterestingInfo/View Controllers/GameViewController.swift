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
    @IBOutlet var dblTapGestureRecognizer: UITapGestureRecognizer!
    
    var nodeBundleListBuilder: NodeBundleListBuilder?
    
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
                    //view.ignoresSiblingOrder = true
                    
                    let aNodeBundleListBuilder = NodeBundleListBuilder(scene:sceneNode)
                    
                    nodeBundleListBuilder = aNodeBundleListBuilder
                    
                    nodeBundleListBuilder!.processData()
                    
                    let nodeBundleListPositioner = NodeBundleListPositioner(bundleList: nodeBundleListBuilder!.getNodeBundleList())
                    nodeBundleListPositioner.positionLinaer()
                    
                    createSpriteNotifications()
                }
            }
        }
    }
    

    @IBAction func dblTapGesture(_ sender: Any) {
        nodeBundleListBuilder!.getNodeBundleListCloseAllDoors() 
    }
    
    @objc
    func tableShowTapped(_ notification: Notification) {
        // load tableVIew when small gray button is selected
        if let touchInfoNode = notification.object as? TouchNode {
            performSegue(withIdentifier:"infoTableSegue", sender:touchInfoNode)
        }
    }
    
    
    // MARK:- Notification observers
    
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
    
    // MARK:- Segue actions
    
    @IBAction func unwindCancelAction(unwindSegue: UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (sender as? TouchNode) != nil {
            let nVc:UINavigationController = segue.destination as! UINavigationController
            let vc:InfoTableViewController = nVc.topViewController as! InfoTableViewController
            vc.tableData = nodeBundleListBuilder!.getNodeBundleListData()
        }
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

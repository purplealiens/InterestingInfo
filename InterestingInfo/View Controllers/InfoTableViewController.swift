//
//  InfoTableViewController.swift
//  InterestingInfo
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//

import UIKit


class InfoTableViewController: UITableViewController {
    
    // MARK:- Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    // MARK:- TableView Datasource and delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        }
        
       // let object = repeatingArray[indexPath.row]
        
       // if(object == mainRepeat){
       //     cell.accessoryType = .checkmark
        //}
        
        //cell.textLabel!.text = object
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*
        let indexPath = self.tableView.indexPathForSelectedRow
        let selectedRepeat = repeatingArray[(indexPath?.row)!]
        let adnVC:AddTableViewController = segue.destination as! AddTableViewController
        mainRepeat = selectedRepeat
        adnVC.mainRepeatingIndex = (indexPath?.row)!
 */
    }
}

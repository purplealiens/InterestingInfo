//
//  InfoTableViewController.swift
//  InterestingInfo
//
//  Created by O W Williams on 1/9/19.
//  Copyright © 2019 Onomaly LLC. All rights reserved.
//

import UIKit

class DepartmentStaffTabelCell : UITableViewCell {
//    @IBOutlet weak var personImageView: UIImageView!//
//    @IBOutlet weak var notesImageView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notesImageView: UIImageView!
    
}

var data:[String] = ["Tim S.", "Chetan R.", "Jan L.", "Dexter H.", "Kim Y."]
let stringsImages:[String] = ["image 1", "image 2", "image 3", "image 4", "image 5"]
class InfoTableViewController: UITableViewController {
    
    // MARK:- Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 150.0
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
        
        return data.count
        
    }
    
    
    // MARK:- TableView Datasource and delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell:DepartmentStaffTabelCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DepartmentStaffTabelCell
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        }
        
       // let object = repeatingArray[indexPath.row]
        
       // if(object == mainRepeat){
       //     cell.accessoryType = .checkmark
        //}
        
        //cell.textLabel!.text = object
        
        cell.nameLabel.text = data[indexPath.row]
        
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

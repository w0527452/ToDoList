//
//  AddToDoViewController.swift
//  ToDoList
//
//  Created by Mark Chouinard on 12/13/21.
//

import UIKit

class AddToDoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      navigationItem.largeTitleDisplayMode = .never
    }


  // MARK: - Actions
  @IBAction func cancel() {
    navigationController?.popViewController(animated: true)
  }

  @IBAction func done() {
    navigationController?.popViewController(animated: true)
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

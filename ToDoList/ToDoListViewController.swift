//
//  ViewController.swift
//  ToDoList
//
//  Created by Mark Chouinard on 12/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController {
  var row0checked = false
  var row1checked = false
  var row2checked = false
  var row3checked = false
  var row4checked = false

  let row0text = "Walk"
  let row1text = "Run"
  let row2text = "Swim"
  let row3text = "Bike"
  let row4text = "Ski"

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  // MARK: - TableView data source
  override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
    print("section: \(section)")
    return 5
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)

    let label = cell.viewWithTag(50) as! UILabel

    switch (indexPath.row) {
    case 0:
      label.text = row0text
    case 1:
      label.text = row1text
    case 2:
      label.text = row2text
    case 3:
      label.text = row3text
    case 4:
      label.text = row4text
    default:
      label.text = "Sleep"
    }

    configureCheckmark(for: cell, at: indexPath)

    return cell
  }

  // MARK: - Table View Delegate
  override func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      if indexPath.row == 0 {
        row0checked.toggle()
      } else if indexPath.row == 1 {
        row1checked.toggle()
      } else if indexPath.row == 2 {
        row2checked.toggle()
      } else if indexPath.row == 3 {
        row3checked.toggle()
      } else if indexPath.row == 4 {
        row4checked.toggle()
      }
      configureCheckmark(for: cell, at: indexPath)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func configureCheckmark( for cell: UITableViewCell, at indexPath: IndexPath ) {
    var isChecked = false

    switch ( indexPath.row) {
    case 0:
      isChecked = row0checked
    case 1:
      isChecked = row1checked
    case 2:
      isChecked = row2checked
    case 3:
      isChecked = row3checked
    case 4:
      isChecked = row4checked
    default:
      isChecked = false
    }

    cell.accessoryType = isChecked ? .checkmark : .none
  }

}


//
//  ViewController.swift
//  ToDoList
//
//  Created by Mark Chouinard on 12/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController {
  var row0item = ToDoItem()
  var row1item = ToDoItem()
  var row2item = ToDoItem()
  var row3item = ToDoItem()
  var row4item = ToDoItem()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    row0item.text = "walk"
    row1item.text = "run"
    row2item.text = "fly"
    row2item.checked = true
    row3item.text = "sail"
    row4item.text = "drive"
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
      label.text = row0item.text
    case 1:
      label.text = row1item.text
    case 2:
      label.text = row2item.text
    case 3:
      label.text = row3item.text
    case 4:
      label.text = row4item.text
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
        row0item.checked.toggle()
      } else if indexPath.row == 1 {
        row1item.checked.toggle()
      } else if indexPath.row == 2 {
        row2item.checked.toggle()
      } else if indexPath.row == 3 {
        row3item.checked.toggle()
      } else if indexPath.row == 4 {
        row4item.checked.toggle()
      }
      configureCheckmark(for: cell, at: indexPath)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func configureCheckmark( for cell: UITableViewCell, at indexPath: IndexPath ) {
    var isChecked = false

    switch ( indexPath.row) {
    case 0:
      isChecked = row0item.checked
    case 1:
      isChecked = row1item.checked
    case 2:
      isChecked = row2item.checked
    case 3:
      isChecked = row3item.checked
    case 4:
      isChecked = row4item.checked
    default:
      isChecked = false
    }

    cell.accessoryType = isChecked ? .checkmark : .none
  }

}


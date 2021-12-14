//
//  ViewController.swift
//  ToDoList
//
//  Created by Mark Chouinard on 12/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController {
  var things = [ToDoItem]()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let todo1 = ToDoItem()
    todo1.text = "walk"
    things.append(todo1)
    let todo2 = ToDoItem()
    todo2.text = "run"
    things.append(todo2)
    let todo3 = ToDoItem()
    things.append(todo3)
    todo3.text = "fly"
    todo3.checked = true
  }

  // MARK: - TableView data source
  override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
    print("section: \(section)")
    return 3
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)

    let shit = indexPath.row

    let thing = things[indexPath.row]
    let label = cell.viewWithTag(50) as! UILabel
    label.text = thing.text

    configureCheckmark(for: cell, at: indexPath)

    return cell
  }

  // MARK: - Table View Delegate
  override func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {

      let thing = things[indexPath.row]
      thing.checked.toggle()

      configureCheckmark(for: cell, at: indexPath)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func configureCheckmark( for cell: UITableViewCell, at indexPath: IndexPath ) {

    cell.accessoryType = things[indexPath.row].checked ? .checkmark : .none
  }

}


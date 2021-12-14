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
    navigationController?.navigationBar.prefersLargeTitles = true

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
    return things.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)

    let thing = things[indexPath.row]

    configureText(for: cell, with: thing)
    configureCheckmark(for: cell, with: thing)

    return cell
  }

  // MARK: - Table View Delegate
  override func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {

      let thing = things[indexPath.row]

      thing.checked.toggle()

      configureCheckmark(for: cell, with: thing)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func configureCheckmark( for cell: UITableViewCell, with thing: ToDoItem ) {

    cell.accessoryType = thing.checked ? .checkmark : .none
  }

  func configureText( for cell: UITableViewCell, with thing: ToDoItem ) {
    let label = cell.viewWithTag(50) as! UILabel
    label.text = thing.text
  }

  // MARK: - Actions
  @IBAction func addThing(_ sender: Any) {
    let newRowIndex = things.count
    let thing = ToDoItem()
    thing.text = "New thing"
    things.append(thing)
    let thing2 = ToDoItem()
    thing2.text = "New thing 2"
    things.append(thing2)

    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPath2 = IndexPath(row: newRowIndex + 1, section: 0)
    tableView.insertRows(at: [indexPath, indexPath2], with: .automatic)
  }

}


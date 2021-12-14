//
//  ViewController.swift
//  ToDoList
//
//  Created by Mark Chouinard on 12/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController, AddToDoViewControllerDelegate {

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

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // data model
    things.remove(at: indexPath.row)
    // table view
    tableView.deleteRows(at: [indexPath], with: .automatic)
  }

  func configureCheckmark( for cell: UITableViewCell, with thing: ToDoItem ) {

    let label = cell.viewWithTag(55) as! UILabel
    label.text = thing.checked ? "√" : ""
  }

  func configureText( for cell: UITableViewCell, with thing: ToDoItem ) {
    let label = cell.viewWithTag(50) as! UILabel
    label.text = thing.text
  }

  // MARK: - AddToDo Delegates
  func addToDoViewControllerDidCancel(_ controller: AddToDoViewController) {
    navigationController?.popViewController(animated: true)
  }

  func addToDoViewController(_ controller: AddToDoViewController, didFinishAdding thing: ToDoItem) {
    navigationController?.popViewController(animated: true)
    let newIndex = things.count
    things.append(thing)

    let indexPath = IndexPath(row: newIndex, section: 0 )
    tableView.insertRows(at: [indexPath], with: .automatic)
  }

  func addToDoViewController(_ controller: AddToDoViewController, didFinishEditing thing: ToDoItem) {
    navigationController?.popViewController(animated: true)
    // get index thing element in things
    if let index = things.firstIndex(of: thing) {
      let indexPath = IndexPath(row: index, section: 0)
      // try to get corresponding cell and set its text
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: thing)
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddToDo" {
      // cast segue.dest as specific controller
      let controller = segue.destination as! AddToDoViewController
      // set AddToDoVC's delegate to this VC
      controller.delegate = self
    } else if segue.identifier == "EditToDo" {
      let controller = segue.destination as! AddToDoViewController
      // hnadle cancle and done
      controller.delegate = self
      // pass thing to edit
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell ) {
        controller.thingToEdit = things[indexPath.row]
      }
    }
  }

}


//
//  ViewController.swift
//  ToDoList
//
//  Created by Mark Chouinard on 12/4/21.
//

import UIKit

class ToDoListViewController: UITableViewController, ToDoDetailViewControllerDelegate, UITableViewDragDelegate {

  var things = [ToDoItem]()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    navigationController?.navigationBar.prefersLargeTitles = true
    tableView.dragInteractionEnabled = true
    tableView.dragDelegate = self
  }

  // MARK: - TableView data source
  override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
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
  func toDoDetailViewControllerDidCancel(_ controller: ToDoDetailViewController) {
    navigationController?.popViewController(animated: true)
  }

  func toDoDetailViewController(_ controller: ToDoDetailViewController, didFinishAdding thing: ToDoItem) {
    navigationController?.popViewController(animated: true)
    let newIndex = things.count
    things.append(thing)

    let indexPath = IndexPath(row: newIndex, section: 0 )
    tableView.insertRows(at: [indexPath], with: .automatic)
  }

  func toDoDetailViewController(_ controller: ToDoDetailViewController, didFinishEditing thing: ToDoItem) {
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

  // MARK: - Drag Delegate
  func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let dragItem = UIDragItem(itemProvider: NSItemProvider())
    dragItem.localObject = things[indexPath.row]
    return [dragItem]
  }

  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let mover = things.remove(at: sourceIndexPath.row)
    things.insert(mover, at: destinationIndexPath.row)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddToDo" {
      // cast segue.dest as specific controller
      let controller = segue.destination as! ToDoDetailViewController
      // set AddToDoVC's delegate to this VC
      controller.delegate = self
    } else if segue.identifier == "EditToDo" {
      let controller = segue.destination as! ToDoDetailViewController
      // hnadle cancle and done
      controller.delegate = self
      controller.placeHolder = "Edit Todo"
      // pass thing to edit
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell ) {
        controller.thingToEdit = things[indexPath.row]
      }
    }
  }

}


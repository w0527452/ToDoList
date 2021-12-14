//
//  AddToDoViewController.swift
//  ToDoList
//
//  Created by Mark Chouinard on 12/13/21.
//

import UIKit

protocol AddToDoViewControllerDelegate: AnyObject {
  func addToDoViewControllerDidCancel(_ controller: AddToDoViewController )
  func addToDoViewController(_ controller: AddToDoViewController, didFinishAdding thing: ToDoItem )
  func addToDoViewController(_ controller: AddToDoViewController, didFinishEditing thing: ToDoItem )
}

class AddToDoViewController: UITableViewController, UITextFieldDelegate {

  @IBOutlet weak var doneButton: UIBarButtonItem!
  @IBOutlet weak var textField: UITextField!

  weak var delegate: AddToDoViewControllerDelegate?
  var thingToEdit: ToDoItem?

  override func viewDidLoad() {
        super.viewDidLoad()

      navigationItem.largeTitleDisplayMode = .never
      doneButton.isEnabled = false
      if let thingToEdit = thingToEdit {
        title = "Edit ToDo"
        textField.text = thingToEdit.text
        doneButton.isEnabled = true
      }
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }

  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }


  // MARK: - Actions
  @IBAction func cancel() {
//    navigationController?.popViewController(animated: true)
    delegate?.addToDoViewControllerDidCancel(self)
  }

  @IBAction func done() {

    // Use correct delegate method depending on thingToEdit
    if let thingToEdit = thingToEdit {
      thingToEdit.text = textField.text!
      delegate?.addToDoViewController(self, didFinishEditing: thingToEdit)
    } else {
      let thing = ToDoItem()
      thing.text = textField.text!
      delegate?.addToDoViewController(self, didFinishAdding: thing)
    }

  }

  // MARK: - Delegates
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    let oldRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: oldRange, with: string)

    doneButton.isEnabled = newText.isEmpty ? false : true

    return true
  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    doneButton.isEnabled = false

    return true
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

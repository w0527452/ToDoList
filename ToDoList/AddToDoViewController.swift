//
//  AddToDoViewController.swift
//  ToDoList
//
//  Created by Mark Chouinard on 12/13/21.
//

import UIKit

class AddToDoViewController: UITableViewController, UITextFieldDelegate {


  @IBOutlet weak var doneButton: UIBarButtonItem!
  @IBOutlet weak var textField: UITextField!

  override func viewDidLoad() {
        super.viewDidLoad()

      navigationItem.largeTitleDisplayMode = .never
      doneButton.isEnabled = false
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
    navigationController?.popViewController(animated: true)
  }

  @IBAction func done() {

    navigationController?.popViewController(animated: true)
  }

  // MARK: - Delegates
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    let oldRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(in: oldRange, with: string)

    doneButton.isEnabled = newText.isEmpty ? false : true

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

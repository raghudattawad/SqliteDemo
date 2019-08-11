//
//  ViewController.swift
//  SqliteDemo
//
//  Created by Raghavendra on 11/08/19.
//  Copyright © 2019 To Be Success echnology. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var contactsTableView: UITableView!

    private var contacts = [Contact]()
    private var selectedContact: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        //// get data from db /////////
        contacts = StephencelisDB.instance.getContacts()

    }


    @IBAction func addAction(_ sender: Any) {
   
        
        
        
        
        let name = nameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let address = addressTextField.text ?? ""
        
        
        if let id = StephencelisDB.instance.addContact(cname: name, cphone: phone, caddress: address){
            
            
            let contact = Contact(id: id, name: name, phone: phone, address: address)
            contacts.append(contact)
            contactsTableView.insertRows(at: [NSIndexPath(row: contacts.count-1, section: 0) as IndexPath], with: .fade)
        }
      
    
    }


    @IBAction func updateAction(_ sender: Any) {
   

        if selectedContact != nil {
            let id = contacts[selectedContact!].id!
            let contact = Contact(
                id: id,
                name: nameTextField.text ?? "",
                phone: phoneTextField.text ?? "",
                address: addressTextField.text ?? "")
          
            StephencelisDB.instance.updateContact(cid: id, newContact: contact)

           // contacts.removeAtIndex(selectedContact!)
            contacts.remove(at: selectedContact!)
            contacts.insert(contact, at: selectedContact!)
            
            contactsTableView.reloadData()
        } else {
            print("No item selected")
        }
        
    }

    @IBAction func deleteAction(_ sender: Any) {
    
    
        if selectedContact != nil {
            contacts.remove(at: selectedContact!)
            
            contactsTableView.deleteRows(at: [NSIndexPath(row: selectedContact!, section: 0) as IndexPath], with: .fade)
            
            StephencelisDB.instance.deleteContact(cid: contacts[selectedContact!].id!)

        } else {
            print("No item selected")
        }
    }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
             return contacts.count

    }
    
    
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
//        var label: UILabel
//        label = cell.viewWithTag(1) as! UILabel // Name label
        cell.textLabel?.text = contacts[indexPath.row].name
        
       // label = cell.viewWithTag(2) as! UILabel // Phone label
        cell.detailTextLabel?.text = contacts[indexPath.row].phone
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        nameTextField.text = contacts[indexPath.row].name
        phoneTextField.text = contacts[indexPath.row].phone
        addressTextField.text = contacts[indexPath.row].address
        
        selectedContact = indexPath.row
    
    }
}

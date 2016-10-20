//
//  ViewController.swift
//  LogInDemo
//
//  Created by Felicia Weathers on 10/14/16.
//  Copyright © 2016 Felicia Weathers. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var isLoggedIn = false
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    context.delete(result)
                    
                    do {
                        
                        try context.save()
                        
                    } catch {
                        
                        print("Individual delete failed")
                        
                    }
                }
                
                label.alpha = 0
                
                logoutButton.alpha = 0
                
                logInButton.setTitle("Log in", for: [])
                
                textField.alpha = 1
                
                isLoggedIn = false
                
            }
            
        } catch {
            
            print("Delete failed")
            
        }
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        if isLoggedIn {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            do {
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        setValue(textField.text, forKey: "name")
                        
                        do {
                            
                            try context.save()
                            
                        } catch {
                            
                            print("Update username save failed")
                            
                        }
                        
                    }
                    
                    label.text = "Hi there" + textField.text! + "!"
                }
                
            } catch {
                
                print("Update username failed")
                
            }
        } else {
            
            // Save a new item in an entity
            
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            
            newValue.setValue(textField.text, forKey: "name")
            
            do {
                
                try context.save()
                
                logInButton.setTitle("Update username", for: [])
                
                logoutButton.alpha = 1
                
                label.alpha = 1
                
                label.text = "Hi there " + textField.text! + "!"
                
                isLoggedIn = true
                
                
            } catch {
                
                print("Failed to save")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        // Set up a request to bring the data from that item back
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                                        
                    logoutButton.alpha = 1
                    
                    logInButton.setTitle("Update username", for: [])
                    
                    label.alpha = 1
                    
                    label.text = "Hi there " + username + "!"
                }
                
            }
            
        } catch {
            
            print("Request failed")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


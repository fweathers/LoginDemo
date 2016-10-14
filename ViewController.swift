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

    @IBOutlet var textField: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    
                    textField.alpha = 0
                    
                    logInButton.alpha = 0
                    
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


//
//  MainMenu.swift
//  FINAL-LITTLE-MONSTER
//
//  Created by Martin Matějka on 24.07.16.
//  Copyright © 2016 Martin Matějka. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {

    @IBOutlet weak var restartBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func restartGame(_ sender: AnyObject) {
        performSegue(withIdentifier: "goToGame", sender: nil)
        
            }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "goToGame" {

     }
 }
}

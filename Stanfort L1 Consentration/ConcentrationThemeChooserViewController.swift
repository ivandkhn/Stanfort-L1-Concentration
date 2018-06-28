//
//  ConcentrationThemeChooserViewController.swift
//  Stanfort L1 Consentration
//
//  Created by Иван Дахненко on 28.06.2018.
//  Copyright © 2018 John Dahrah. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    
    
    // MARK: - Navigation
    
    let themes = ["Theme 1", "Theme 2", "Theme 3"]
    
    
    @IBAction func changeTheme(_ sender: Any) {
        performSegue(withIdentifier: "Choose theme", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose theme" {
            if let themeName = (sender as? UIButton)?.currentTitle {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.selectedTheme = themes.index(of: themeName)!
                }
            }
        }
    }
}

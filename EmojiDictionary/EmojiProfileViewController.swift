//
//  EmojiProfileViewController.swift
//  EmojiDictionary
//
//  Created by Fabio Quintanilha on 12/17/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//

import UIKit

class EmojiProfileViewController: UIViewController {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usageLabel: UILabel!
    
    var emoji: Emoji?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let emoji = emoji {
//             emojiLabel.text = emoji.symbol
//             descriptionLabel.text = emoji.description
//             usageLabel.text = emoji.usage
//        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

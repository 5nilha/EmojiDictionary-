//
//  EmojiTableViewCell.swift
//  EmojiDictionary
//
//  Created by Fabio Quintanilha on 12/18/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func update(with emoji: Emoji) {

        symbolLabel.text = emoji.symbol
        nameLabel.text = emoji.name
        descriptionLabel.text = emoji.description
    }

    @IBAction func detailButtonTapped(_ sender: UIButton) {
        
        
    }
    
}

//
//  IngredientListCustomTableViewCell.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/7/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class IngredientListCustomTableViewCell: UITableViewCell {
    var message: String?
    var number: String?

    var messageView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 5
        return textView
    }()

    var numberView: UITextView = {
        var numberView = UITextView()
        numberView.translatesAutoresizingMaskIntoConstraints = false
        numberView.layer.cornerRadius = 5
        return numberView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(messageView)
        self.addSubview(numberView)

        numberView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        numberView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        numberView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        numberView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true

        messageView.leftAnchor.constraint(equalTo: self.numberView.rightAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = message {
            messageView.text = message
        }
        if let number = number {
            numberView.text = number
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

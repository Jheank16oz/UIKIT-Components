//
//  DynamicStackViewController.swift
//  UIKit-components
//
//  Created by jpineros on 30/03/22.
//

import Foundation
import UIKit

class DynamicStackViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Next, override the viewDidLoad method to set the scroll view’s initial position. You want the scroll view’s content to start below the status bar.
        let insets = UIEdgeInsets.init(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView?.contentInset = insets
        scrollView?.scrollIndicatorInsets = insets
        
     
        
    }
    
    // MARK: Action Methods
    
    
    /*
     Now, add an action method for the add item button.
     This method calculates a new offset for the scroll view, then creates a new entry view. The entry view is
     hidden, and added to the stack. Hidden views do not affect the appearance or layout of a stack—so the
     stack’s appearance remains unchanged. Then, in an animation block, the view is revealed and the scroll
     offset is updated, animating the view’s appearance.
     
     This method hides the view in an animation block. After the animation completes, it removes the view from
     the view hierarchy. This automatically removes the view from the stack’s list of arranged views.
     */
    @IBAction func addEntry(_ sender: Any) {
        let stack = stackView!
        
        let index = stack.arrangedSubviews.count - 1
        let addView = stack.arrangedSubviews[index]
        
        let scroll = scrollView!
        let offset = CGPoint(x: scroll.contentOffset.x,
                             y: scroll.contentOffset.y + addView.frame.size.height)
        
        let newView = createEntry()
        newView.isHidden = true
        stack.insertArrangedSubview(newView, at: index)
        
        UIView.animate(withDuration: 0.25) { () -> Void in
            newView.isHidden = false
            scroll.contentOffset = offset
        }
    }
    
    @objc func deleteStackView(sender: UIButton) {
        if let view = sender.superview {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                view.isHidden = true
            }, completion: { (success) -> Void in
                view.removeFromSuperview()
            })
        }
    }
    
    // MARK: - Private Methods
    
    /*
     Although the entry view could be any view, this example uses a stack view that contains a date label, a
     label containing a random hex string, and a delete button.
     */
    private func createEntry() -> UIView {
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let number = "\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())"
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.distribution = .fill
        stack.spacing = 8
        
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        let deleteButton = UIButton(type: .roundedRect)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteStackView(sender:)), for: .touchUpInside)
        
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(deleteButton)
        
        return stack
    }
     
    private func randomHexQuad() -> String {
        return NSString(format: "%X%X%X%X",
                        arc4random() % 16,
                        arc4random() % 16,
                        arc4random() % 16,
                        arc4random() % 16
            ) as String
    }
    
}

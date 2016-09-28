//
//  YYNoDataView.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/27.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - Public

extension YYNoDataView {
    
    @discardableResult static public func show(inView superView: UIView, image: UIImage? = nil, text: String? = nil, buttonText: String? = nil, buttonAction: ((UIButton) -> Void)? = nil) -> YYNoDataView {
        let view = YYNoDataView.instanceFromNib() as! YYNoDataView
        view.update(image: image ?? view.defaultImage, text: text ?? view.defaultText, buttonText: buttonText ?? view.defaultButtonText, buttonAction: buttonAction)
        superView.addSubview(view)
        return view
    }
    
    public func update(image: UIImage? = nil, text: String? = nil, buttonText: String? = nil, buttonAction: ((UIButton) -> Void)? = nil) {
        imageView.image = image
        textLabel.text = text
        button.setTitle(buttonText, for: .normal)
        self.buttonAction = buttonAction
    }
}

public class YYNoDataView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // MARK: - Public Property
    
    public var buttonAction: ((UIButton) -> Void)? = nil
    
    // MARK: - Initialization
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setContext()
    }
    
    func setContext() {
        defaultImage = imageView.image
        defaultText = textLabel.text
        defaultButtonText = button.title(for: .normal)
    }
    
    // MARK: - Private Property
    
    var defaultImage: UIImage?
    var defaultText: String?
    var defaultButtonText: String?
}

// MARK: - Override

extension YYNoDataView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        if let superview = superview {
            frame = superview.bounds
        }
    }
}

// MARK: - Private

extension YYNoDataView {

}



//
//  LargeButton.swift
//  Surveyer
//
//  Created by Pisit W on 10/6/2563 BE.
//  Copyright © 2563 blyscuit. All rights reserved.
//

import UIKit

class LargeButton: UIControl {

    public var dimmColor : UIColor? = UIColor.black

    @IBInspectable
    var title: String = "" {
        didSet {
            setTitle()
        }
    }

    lazy var titleLabel: UILabel = {
        let l = UILabel(frame: CGRect.zero)
        l.numberOfLines = 1
        l.textAlignment = NSTextAlignment.center
        l.translatesAutoresizingMaskIntoConstraints = false
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.2
        l.numberOfLines = 1
        l.textColor = .white
        l.font = .Body_NotoRegular_16
        return l
    }()
    
    private var overlayAlpha: Float = 0.3
    private var textColor: UIColor = .white
    
    private var isWorking: Bool = true

    func setEnable(_ enable: Bool, animate: Bool) {
        if enable == self.isWorking { return }
        isWorking = enable
    }

    lazy var dimmer: UIView = {
        let v = UIView(frame: self.frame)
        v.backgroundColor = self.dimmColor
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alpha = 0
        return v
    }()

    fileprivate var animator :  UIViewPropertyAnimator?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitilization()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitilization()
    }
    
    var labelLeftConstraint: NSLayoutConstraint!
    var labelRightConstraint: NSLayoutConstraint!

    func setTitle() {
        titleLabel.text = self.title
    }

    func sharedInitilization()  {
        
        addTapGestureRecognizer()
        addSubview(dimmer)
        dimmer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dimmer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dimmer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dimmer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true

        titleLabel.font = .Button_NotoBold_16
        backgroundColor = .mainRed
        
        self.addDropShadow(color: .black, opacity: 0.4, offSetX: 0, offSetY: 8, radius: 24)
    }

    
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        dimmer.layer.cornerRadius = radius
    }

    func addTapGestureRecognizer() {
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tapGestureRecogniser)
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius(self.frame.size.height/2)
    }
}

extension LargeButton {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if isWorking == false { return }
        sendActions(for: .touchUpInside)
    }
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isWorking == false { return }
        animateTintAdjustmentMode(.dimmed)
    }
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isWorking == false { return }
        animateTintAdjustmentMode(.normal)
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isWorking == false { return }
        animateTintAdjustmentMode(.normal)
    }
    fileprivate func animateTintAdjustmentMode(_ mode: UIView.TintAdjustmentMode , completion : (()->Void)? = nil  ) {
        self.dimmer.layer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath:"opacity")
        animation.fromValue = mode == .dimmed ? 0 : self.overlayAlpha
        animation.toValue = mode == .dimmed ? self.overlayAlpha : 0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = mode == .dimmed  ?  (self.overlayAlpha <= 0.5 ? 0.05 : 0.10) : 0.3
        CATransaction.begin()
        self.dimmer.layer.add(animation, forKey: mode == .dimmed ?  "dimm" : "normal" )
        CATransaction.setCompletionBlock {
            self.dimmer.layer.opacity = mode == .dimmed ? self.overlayAlpha : 0
        }
        CATransaction.commit()
    }
}

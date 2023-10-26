//
//  WhatsappStatusRingBar.swift
//  WhatsappStatusRingBar
//
//  Created by iMac on 26/10/23.
//

import Foundation
import UIKit

@IBDesignable
open class WhatsappStatusRingBar: UIView {
    
    // MARK: - Variables
    
    @IBInspectable open var progressImageView = UIImageView(frame: .zero)
    
    // Profile ImageView
    @IBInspectable open var image: UIImage? = nil {
        didSet {
            progressImageView.image = image
        }
    }
    
    @IBInspectable open var imageContentMode: UIView.ContentMode = .scaleAspectFill {
        didSet {
            progressImageView.contentMode = imageContentMode
        }
    }
    
    // Image Inset
    @IBInspectable open var imageInset: CGFloat = 2.0 {
        didSet {
            updateShapes()
        }
    }
    
    // ClockWise Round Setup
    @IBInspectable open var clockwise: Bool = true {
        didSet {
            layoutSubviews()
        }
    }
    
    // Seen Progress stroke color
    @IBInspectable open var seenProgressColor: UIColor   = .blue {
        didSet {
            updateShapes()
        }
    }
    
    // Unseen Progress stroke color
    @IBInspectable open var unseenProgressColor: UIColor = .gray {
        didSet {
            updateShapes()
        }
    }
        
    // Line width
    @IBInspectable open var lineWidth: CGFloat = 2.0 {
        didSet {
            updateShapes()
        }
    }
    // Returns the total Items
    private var _total: Int = 1
    @IBInspectable open var total: Int {
        set {
            self._total = newValue
            self.addProgressShapes()
        }
        get {
            return self._total
        }
    }
    // Returns the current progress.
    private var _progress: CGFloat = 0.0
    @IBInspectable open private(set) var progress: CGFloat {
        set {
            self._progress = newValue
            self.updateShapes()
        }
        get {
            return self._progress
        }
    }
    // Duration for a complete animation from 0.0 to 1.0.
    open var completeDuration: Double = 1.0
    private var progressShapes: [CAShapeLayer]!
    
    // MARK: - Init -
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // Setup Progress View
    private func setup() {
        progressImageView.frame = CGRect(
            x: (lineWidth + imageInset),
            y: (lineWidth + imageInset),
            width: self.bounds.width - ((lineWidth + imageInset) * 2),
            height: self.bounds.height - ((lineWidth + imageInset) * 2)
        )
        progressImageView.contentMode = imageContentMode
        progressImageView.layer.cornerRadius = progressImageView.bounds.height / 2
        progressImageView.clipsToBounds = true
        self.addSubview(progressImageView)
        self.progressImageView.image = self.image
    }
    
    // MARK: - Progress Animation -
    private func addProgressShapes() {
        for subLayer in self.layer.sublayers ?? [] {
            if subLayer is CAShapeLayer {
                subLayer.removeFromSuperlayer()
            }
        }
        self.progressShapes = []
        if self.total == 1 {
            let progressShape: CAShapeLayer!
            progressShape = CAShapeLayer()
            progressShape.fillColor = nil
            progressShape.strokeStart = 0.0
            progressShape.strokeEnd = 1.0
            layer.addSublayer(progressShape)
            self.progressShapes.append(progressShape)
        } else {
            let progressSize = 1.0
            var size: CGFloat = CGFloat(progressSize / Double(self.total))
            let padingPercent = 0.2
            let pading: Double = padingPercent * Double(self.total) / 10 * Double(progressSize / Double(self.total - 1))
            size = size - CGFloat(pading)
            print("")
            print("size: \(size) | pading: \(pading)")
            print("------------------------")
            var start: CGFloat = 0.0
            var end: CGFloat = size
            print("start: \(start) | end: \(end) ")
            print("------------------------")
            let progressShape: CAShapeLayer!
            progressShape = CAShapeLayer()
            progressShape.fillColor = nil
            progressShape.strokeStart = start
            progressShape.strokeEnd = end
            layer.addSublayer(progressShape)
            self.progressShapes.append(progressShape)
            for _ in 1..<self._total {
                start = CGFloat(end +  CGFloat(pading))
                end = CGFloat(Double(start + size))
                print("------------------------")
                print("start: \(start) | end: \(end) ")
                let progressShape: CAShapeLayer!
                progressShape = CAShapeLayer()
                progressShape.fillColor = nil
                progressShape.strokeStart = start
                progressShape.strokeEnd = end
                layer.addSublayer(progressShape)
                self.progressShapes.append(progressShape)
            }
        }
    }
    
    // Setup Progress Shape Frame
    private func setProgressShapeFrame() {
        guard self.progressShapes != nil else { return }
        for shape in self.progressShapes {
            shape.frame = bounds
            let rect = rectForShape()
            shape.path = pathForShape(rect: rect).cgPath
        }
    }
    
    // Update Progress Shape With
    private func updateShapesWidth() {
        guard self.progressShapes != nil else { return }
        for i in 0..<self._total {
            let shape = self.progressShapes[i]
            let color = CGFloat(i) >= self.progress ? unseenProgressColor.cgColor : seenProgressColor.cgColor
            shape.strokeColor = color
            shape.lineWidth = lineWidth
            shape.lineCap = .round
        }
    }
    
    // Setup Progress Shape Tranform
    private func transformShapes(_ transform: CATransform3D) {
        guard self.progressShapes != nil else { return }
        for shape in self.progressShapes {
            shape.transform = transform
        }
    }
    
    // Set Progress Current Count
    public func setProgress(progress: CGFloat, animated: Bool = true) {
        self.progress = progress
    }
    
    // MARK: - Layout -
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        setProgressShapeFrame()
        updateShapes()
        progressImageView.frame = CGRect(
            x: (lineWidth + imageInset),
            y: (lineWidth + imageInset),
            width: self.bounds.width - ((lineWidth + imageInset) * 2),
            height: self.bounds.height - ((lineWidth + imageInset) * 2)
        )
    }
    
    // Update Shapes
    private func updateShapes() {
        self.updateShapesWidth()
        progressImageView.frame = CGRect(
            x: (lineWidth + imageInset),
            y: (lineWidth + imageInset),
            width: self.bounds.width - ((lineWidth + imageInset) * 2),
            height: self.bounds.height - ((lineWidth + imageInset) * 2)
        )
        progressImageView.layer.cornerRadius = progressImageView.bounds.height / 2
        self.transformShapes(CATransform3DMakeRotation( CGFloat.pi, 0, 0, 1.0))
    }
    
    // MARK: - Helper -
    private func rectForShape() -> CGRect {
        return bounds.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
    }
    
    private func pathForShape(rect: CGRect) -> UIBezierPath {
        let startAngle: CGFloat!
        let endAngle: CGFloat!
        if clockwise {
            startAngle = CGFloat(0.5 * .pi)
            endAngle = CGFloat(360.0 * (.pi / 180.0)) + (0.5 * .pi)
        } else {
            startAngle = CGFloat(360.0 * (.pi / 180.0)) + (0.5 * .pi)
            endAngle = CGFloat(0.5 * .pi)
        }
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: rect.size.width / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
    
}

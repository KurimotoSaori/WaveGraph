//
//  ViewController.swift
//  wave
//
//  Created by saori on 2019/01/26.
//  Copyright © 2019年 saori. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var baseView: GraphBaseView!

    let animator = UIViewPropertyAnimator(duration: 30.0, timingParameters: UICubicTimingParameters(animationCurve: .linear))

    var count : CGFloat = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0

        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }

    @IBAction func tappedStartButton(_ sender: Any) {
        animator.addAnimations {
            self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentSize.width, y: 0)
        }

        animator.startAnimation()

        let step = CGFloat(self.baseView.frame.width / 600)
        //timer処理
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.count += 1
            self.baseView.append(toX: Int(step * self.count))
        })
    }

    @IBAction func tappedStopButton(_ sender: Any) {
        animator.pauseAnimation()
    }

    @IBAction func tappedExtensionButton(_ sender: Any) {

        let _animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: UICubicTimingParameters(animationCurve: .linear))
        _animator.addAnimations {
            self.baseView.transform = CGAffineTransform(scaleX: 2,y: 1)
        }
        _animator.startAnimation()

        self.baseView.frame.size = CGSize(width: 600, height: 300)
        self.baseView.layoutIfNeeded()
    }
}

class GraphBaseView: UIView {
    var lastPoint: CGPoint!
    let columnXPoint = { (column:Int) -> CGFloat in
        let spacer = 20
        var x:CGFloat = CGFloat(column) * CGFloat(spacer)
        x += CGFloat(spacer)
        return UIScreen.main.bounds.width / 2 + x
    }

    override func draw(_ rect: CGRect) {
        let lineLayer = CAShapeLayer()
        let path = UIBezierPath()

        let nextPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: CGFloat(10))
        path.move(to: nextPoint)
        lastPoint = nextPoint
        path.lineWidth = 20.0

        self.layer.addSublayer(lineLayer)
    }

    func append(toX: Int) {
        let path = UIBezierPath()
        path.move(to: lastPoint)

        let nextPoint = CGPoint(x: self.columnXPoint(toX), y: CGFloat(Int.random(in: 1 ... 250)))
        lastPoint = nextPoint
        path.addLine(to: nextPoint)
        path.lineWidth = 20.0

        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.red.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.lineWidth = 1.0
        lineLayer.path = path.cgPath

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false

        self.layer.addSublayer(lineLayer)
        lineLayer.add(animation, forKey: nil)
    }
}

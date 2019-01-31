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

    var count : CGFloat = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0

        self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        baseView.frame.size = CGSize(width: baseView.frame.width * 1.5, height: baseView.frame.width / 1.5)
        baseView.layoutIfNeeded()
    }

    @IBAction func tappedButtomn(_ sender: Any) {
        UIView.animate(withDuration: 20) {
            self.scrollView.contentOffset = CGPoint(x: self.baseView.frame.width, y: 0)
        }

        let step = CGFloat(self.baseView.frame.width / 100)
        //timer処理
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.count += 1
            self.baseView.append(toX: Int(step * self.count))
        })
    }

    @IBAction func tappedStartButton(_ sender: Any) {
        baseView.timeStart()
    }
    @IBAction func tappedStopButton(_ sender: Any) {
        baseView.timeStop()
    }

    @IBAction func append(_ sender: Any) {
//        baseView.append()
    }
}

class GraphBaseView: UIView {
    var lastPoint: CGPoint!
    let columnXPoint = { (column:Int) -> CGFloat in
        let spacer = 5
        var x:CGFloat = CGFloat(column) * CGFloat(spacer)
        x += 5 + 2
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

    func timeStop() {
//        let pausedTime = lineLayer.convertTime(CACurrentMediaTime(), from: nil)
//        lineLayer.speed = 0
//        lineLayer.timeOffset = pausedTime
    }

    func timeStart() {
//        let pausedTime = lineLayer.timeOffset
//        lineLayer.speed = 1
//        lineLayer.timeOffset = 0
//        lineLayer.beginTime = 0
//        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//        lineLayer.beginTime = timeSincePause
        }
}

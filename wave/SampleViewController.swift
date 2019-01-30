//
//  SampleViewController.swift
//  wave
//
//  Created by saori on 2019/01/28.
//  Copyright © 2019年 saori. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    @IBOutlet weak var baseView: PlotView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: 50, y: 200))
//        path.addLine(to: CGPoint(x: 100, y: 100))
//        path.addLine(to: CGPoint(x: 150, y: 250))

        path.lineWidth = 20.0 // 線の太さ

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

        view.layer.addSublayer(lineLayer)
        lineLayer.add(animation, forKey: nil)
    }

    @IBAction func tappedButton(_ sender: Any) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 50, y: 200))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.lineWidth = 20.0 // 線の太さ

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

        view.layer.addSublayer(lineLayer)
        lineLayer.add(animation, forKey: nil)
    }
}

class PlotView: UIView {

    override func draw(_ rect: CGRect) {
        let context :CGContext! = UIGraphicsGetCurrentContext()
        context.setLineWidth(2.0)

        // 設定開始
        context.beginPath()
        // グラフ上の座標を設定する
        context.move(to: CGPoint(x: 0, y: 100))
        context.addLine(to: CGPoint(x: 0, y: 100))
        context.addLine(to: CGPoint(x: 100, y: 120))
        // 描画
        context.strokePath()

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: 0, y: 100))

        let shapeLary = CAShapeLayer()
        shapeLary.path = path.cgPath
        self.layer.addSublayer(shapeLary)
    }
}

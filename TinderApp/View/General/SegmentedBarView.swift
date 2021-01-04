//
//  SegmentedBarView.swift
//  TinderApp
//
//  Created by Jesus Barragan  on 18/12/20.
//

import UIKit
class SegmentedBarView: UIStackView {
    init(numberOfSegments: Int) {
        super.init(frame: .zero)
        (0..<numberOfSegments).forEach { _ in
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            addArrangedSubview(barView)
        }
        spacing = 4
        distribution = .fillEqually
        arrangedSubviews.first?.backgroundColor = .white
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) no pudo ser implementado en SegmentedBarView")
    }
    
    func setHighlighted(index: Int) {
        arrangedSubviews.forEach({ $0.backgroundColor = .barDeselectedColor})
        arrangedSubviews[index].backgroundColor = .white
    }
}

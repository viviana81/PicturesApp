//
//  FiltersView.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 22/03/21.
//

import UIKit
import Anchorage

class FiltersView: UIView {
    
    var onTap: ((Filter) -> Void)?
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
    
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .horizontal
        view.spacing = 20
        view.backgroundColor = .clear
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureConstraints()
        configureButtons()
    }
    
    func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func configureConstraints() {
        scrollView.edgeAnchors == edgeAnchors
        stackView.edgeAnchors == scrollView.edgeAnchors
    }
    
    func configureButtons() {
        let filters = Filter.allCases
        for (index, filter) in filters.enumerated() {
           let button = UIButton()
            button.setTitle(filter.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.heightAnchor == 60
            button.widthAnchor == 150
            button.tag = index
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // TODO: change button color
            button.backgroundColor = .white //#colorLiteral(red: 0.848020494, green: 0.8161743879, blue: 0.9997846484, alpha: 1)
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(searchJob), for: .touchUpInside)
        }
    }
    
    @objc
    func searchJob(_ sender: UIButton) {
        let filter = Filter.allCases[sender.tag]
        //let filter = filters[sender.tag]
        onTap?(filter)
    }
}

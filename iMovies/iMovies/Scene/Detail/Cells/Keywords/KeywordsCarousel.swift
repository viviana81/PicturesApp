//
//  KeywordsCarousel.swift
//  iMovies
//
//  Created by Viviana Capolvenere on 01/03/21.
//

import UIKit
import Anchorage

class KeywordsCarousel: UIView {
    
    var onTap: ((Keyword) -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    var keywords: [Keyword] = [] {
        didSet {
            configureButtons()
        }
    }
    // se la instanzio via codice
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    // se la instanzio da xib
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureConstraints()
    }
    
    func configureUI() {
        backgroundColor = .clear
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func configureConstraints() {
        scrollView.edgeAnchors == edgeAnchors
        stackView.edgeAnchors == scrollView.edgeAnchors
    }
    
    func configureButtons() {
        
        for (index, keyword) in keywords.enumerated() {
            
            let button = UIButton()
            button.setTitle(keyword.name, for: .normal)
            button.setImage(UIImage(named: "arrow-right"), for: .normal)
            button.tintColor = .black
            button.semanticContentAttribute = .forceRightToLeft
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 12
            button.layer.masksToBounds = true
            button.heightAnchor == 24
            button.tag = index
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.backgroundColor = .systemGray5
            button.setInsets(forContentPadding: .init(top: 4, left: 8, bottom: 4, right: 8), imageTitlePadding: -2)
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(openDetail), for: .touchUpInside)
        }
    }
    
    @objc
    func openDetail(_ sender: UIButton) {
        let keyword = keywords[sender.tag]
        onTap?(keyword)
        
    }
}

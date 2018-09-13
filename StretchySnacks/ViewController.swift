//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Wiljay Flores on 2018-09-13.
//  Copyright © 2018 wiljay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var navBar: UIView!
    
    var snack1 = UIImageView(image: UIImage(named: "oreos"))
    var snack2 = UIImageView(image: UIImage(named: "pizza_pockets"))
    var snack3 = UIImageView(image: UIImage(named: "pop_tarts"))
    var snack4 = UIImageView(image: UIImage(named: "popsicle"))
    var snack5 = UIImageView(image: UIImage(named: "ramen"))
    var snacksTitle = UILabel()
    var stackView = UIStackView()
    var tableView = UITableView()
    
  //  let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
    
    
    var snacks = [String?]()
    
    enum Expanded: CGFloat {
        case yes = 200.0
        case no = 64.0
    }
    
    var isExpanded = Expanded.no

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupViews()

    }


    @IBAction func expandPressed(_ sender: UIButton) {
        isExpanded = isExpanded == .no ? .yes : .no
        
        if isExpanded == .yes {
            UIView.animate(withDuration:0.5,delay: 0,usingSpringWithDamping: 0.3, initialSpringVelocity: 0.025, animations: ({
            sender.transform = CGAffineTransform(rotationAngle: 0.25*CGFloat.pi)
            self.stackView.isHidden = false
            self.snacksTitle.text = "Add Snacks"
        }))
        } else {
            UIView.animate(withDuration:0.5,delay: 0,usingSpringWithDamping: 0.3, initialSpringVelocity: 0.025, animations: ({
                sender.transform = CGAffineTransform(rotationAngle: 0)
                self.stackView.isHidden = true
                self.snacksTitle.text = "Snacks"
            }))
        }
        updateView()
    }
    
    func addGestureToImageView(imageView: UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
    
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        switch (sender.view?.tag) {
        case 1:
           snacks.append("Oreo")
        case 2:
           snacks.append("Pizza Pocket")
        case 3:
            snacks.append("Pop Tart")
        case 4:
            snacks.append("Popsicle")
        case 5:
            snacks.append("Ramen")
        default:
            print("error")
        }
        tableView.reloadData()

    }
    
    private func updateView() {
        let height = self.isExpanded.rawValue
        navHeight.constant = height
        UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func setupViews() {
        
        let width = navBar.frame.width
        
        snack1.translatesAutoresizingMaskIntoConstraints = false
        snack2.translatesAutoresizingMaskIntoConstraints = false
        snack3.translatesAutoresizingMaskIntoConstraints = false
        snack4.translatesAutoresizingMaskIntoConstraints = false
        snack5.translatesAutoresizingMaskIntoConstraints = false
        snacksTitle.translatesAutoresizingMaskIntoConstraints = false
        navBar.addSubview(snacksTitle)
        
        snack1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        snack1.widthAnchor.constraint(equalToConstant: width/5).isActive = true
        
        snack2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        snack2.widthAnchor.constraint(equalToConstant: width/5).isActive = true
  
        snack3.heightAnchor.constraint(equalToConstant: 100).isActive = true
        snack3.widthAnchor.constraint(equalToConstant: width/5).isActive = true
        
  
        snack4.heightAnchor.constraint(equalToConstant: 100).isActive = true
        snack4.widthAnchor.constraint(equalToConstant: width/5).isActive = true
        
        snack5.heightAnchor.constraint(equalToConstant: 100).isActive = true
        snack5.widthAnchor.constraint(equalToConstant: width/5).isActive = true
        
        snacksTitle.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        snacksTitle.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
        snacksTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        snacksTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        snacksTitle.text = "Snacks"
        snacksTitle.textAlignment = NSTextAlignment.center
        
        stackView.addArrangedSubview(snack1)
        stackView.addArrangedSubview(snack2)
        stackView.addArrangedSubview(snack3)
        stackView.addArrangedSubview(snack4)
        stackView.addArrangedSubview(snack5)
        
        navBar.addSubview(stackView)
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalToConstant: view.frame.height-navBar.frame.height).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: width).isActive = true
        tableView.topAnchor.constraintEqualToSystemSpacingBelow(navBar.bottomAnchor, multiplier: 1.0).isActive = true
        
        snack1.tag = 1
        snack2.tag = 2
        snack3.tag = 3
        snack4.tag = 4
        snack5.tag = 5
        
        addGestureToImageView(imageView: snack1)
        addGestureToImageView(imageView: snack2)
        addGestureToImageView(imageView: snack3)
        addGestureToImageView(imageView: snack4)
        addGestureToImageView(imageView: snack5)
    }

    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = snacks[indexPath.row]
        return cell!
    }
}


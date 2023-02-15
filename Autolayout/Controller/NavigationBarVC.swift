//
//  ViewController.swift
//  Autolayout
//
//  Created by Алина Власенко on 10.02.2023.
//


//Завдання:
//Проект iOS додатку з адаптивним користувацьким інтерфейсом
//Побудувати користувацький інтерфейс згідно доданого style guide. Інтерфейс складатиметься з 3-х скрінів:

//Task 1:
//Початковий скрін програми. Містить Navigation Bar, текстове поле Label, контейнер для кнопок та 2 кнопки. По натисненню на кнопку відкривається новий скрін (скрін 2 або скрін 3 відповідно).

import UIKit

class NavigationBarVC: UIViewController {
    
    //MARK: - UI objects
    
    private let titleLbl: UILabel = {
        let label = UILabel()
        label.text = "This is task 1"
        //шрифт і розмір, які потребувало завдання
        label.font = UIFont(name: "Avenir-Medium", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let task2Btn: UIButton = {
        let button = UIButton()
        button.setTitle("Task2", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray4, for: .highlighted)
        button.backgroundColor = UIColor(named: "ButtonColor")
        //button.frame = CGRect(x: 40, y: 50, width: 90, height: 40)
        button.layer.cornerRadius = 8
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(goToTask2VC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let task3Btn: UIButton = {
        let button = UIButton()
        button.setTitle("Task3", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray4, for: .highlighted)
        button.backgroundColor = UIColor(named: "ButtonColor")
        //button.frame = CGRect(x: 230, y: 50, width: 90, height: 40)
        button.layer.cornerRadius = 8
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(goToTask3VC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return button
    }()
    
    private let container: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.alignment = .center
        container.spacing = 360 - (40 + 90) * 2
        container.isLayoutMarginsRelativeArrangement = true //Якщо true то елементи залежать в вказаних границь, Якщо false (по дефолту) - То вирівнюється по границі самого стeка
        //І потім вказуємо кастомні марджини в .layoutMargins
        container.layoutMargins = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        //container.distribution = .equalCentering
        container.backgroundColor = UIColor(named: "ContainerBackground")
        container.translatesAutoresizingMaskIntoConstraints = false
        //[self.task2Btn, self.task3Btn].forEach { container.addArrangedSubview($0) }
        return container
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ViewBackground")
        
        configureNavigationBar()
        addSubviews()
        applyConstraints()
    }

    //MARK: - Add subviews
    
    private func addSubviews() {
        view.addSubview(titleLbl)
        view.addSubview(container)
        //додаю елементи у контейнер
        container.addArrangedSubview(task2Btn)
        container.addArrangedSubview(task3Btn)
    }
    
    //MARK: - Configure NavBar
    
    private func configureNavigationBar() {
        title = "Autolayout"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "NavBackground")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.tintColor = .white

//        navigationController?.popToRootViewController(animated: true)
   }
    
    //MARK: - Actions for Buttons //It work like TabBar

    @objc func goToTask2VC() {
        let vc = Task2VC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToTask3VC() {
        let vc = Task3VC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Apply constraints
    
    private func applyConstraints() {
        let titleLblConstraints = [
            titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLbl.topAnchor.constraint(equalTo: container.topAnchor, constant: -70)
        ]
        
        let containerConstraints = [
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 360),
            container.heightAnchor.constraint(equalToConstant: 140)
        ]
        
        let task2BtnConstraints = [
            task2Btn.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            //task2Btn.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 40),
            task2Btn.widthAnchor.constraint(equalToConstant: 90),
            task2Btn.heightAnchor.constraint(equalToConstant: 40)
        ]

        let task3BtnConstraints = [
//!!!       //не працює відступ від краю контейнера для правої кнопки..
            //task3Btn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 40),
            task3Btn.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            task3Btn.widthAnchor.constraint(equalToConstant: 90),
            task3Btn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(titleLblConstraints)
        NSLayoutConstraint.activate(containerConstraints)
        NSLayoutConstraint.activate(task2BtnConstraints)
        NSLayoutConstraint.activate(task3BtnConstraints)
    }
}

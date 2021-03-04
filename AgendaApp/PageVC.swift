//
//  ViewController.swift
//  AgendaApp
//
//  Created by Apps2t on 04/03/2021.
//  Copyright © 2021 Apps2t. All rights reserved.
//

import Foundation
import UIKit

class PageVC: UIViewController{
    
    private var pageController: UIPageViewController?
    var currentIndex: Int = 0
    
    var vistas: [UIViewController]?

    @IBOutlet weak var pageDots: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Buscar las vistas desde el storyboard
        vistas = [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC"),
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC")]
        
        setupPageController()
    }
    
    //Iniciar el Page View Controller con los puntos identificativos
    func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
          
        let initialVC = vistas![0]
        
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        self.view.addSubview(self.pageController!.view)
        
        self.view.bringSubviewToFront(pageDots)
        self.pageDots.numberOfPages = vistas!.count
        self.pageDots.currentPage = 0

    }
}

extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //Desplazamiento entre pantallas
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = self.vistas!.firstIndex(of: viewController)!
        
        if (index <= 0){
            return nil
        } else {
            index -= 1
        }
        
        return self.vistas![index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = self.vistas!.firstIndex(of: viewController)!
        
        if (index >= 1){
            return nil
        } else {
            index += 1
        }
        
        return self.vistas![index]
    }
    
    //Actualización de los puntos indicativos
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        self.currentIndex = self.vistas!.firstIndex(of: pendingViewControllers.first!)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        self.pageDots.currentPage = self.currentIndex
    }

}


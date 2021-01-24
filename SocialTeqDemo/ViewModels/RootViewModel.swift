//
//  RootViewModel.swift
//  SocialTeqDemo
//
//  Created by Farshad Mousalou on 1/22/21.
//

import Foundation
import Combine

final class RootViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case error(Error)
    }
    
    enum Event {
        case didSelectTabBar(atIndex: Int)
    }
    
}

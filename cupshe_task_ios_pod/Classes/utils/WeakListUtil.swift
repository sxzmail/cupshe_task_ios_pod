//
//  WeakListUtil.swift
//  TaskSDK
//
//  Created by gbl on 2023/10/27.
//

import Foundation

public class WeakArray<T: AnyObject> {
    private var array: [Weak<T>] = []
    
    func append(_ object: T?) {
        if let object = object {
            array.append(Weak(object))
        }
    }
    
    func remove(_ object: T?) {
        if let object = object, let index = array.firstIndex(where: { $0.value === object }) {
            array.remove(at: index)
        }
    }
    
    //清除无效对象
    func compact() {
        array = array.filter { $0.value != nil }
    }
    
    func allObjects() -> [T] {
        return array.compactMap { $0.value }
    }
    
    var count:Int{
        array.count
    }
}

// 定义一个包装弱引用的类
public class Weak<T: AnyObject> {
    weak var value: T?
    
    init(_ value: T?) {
        self.value = value
    }
}

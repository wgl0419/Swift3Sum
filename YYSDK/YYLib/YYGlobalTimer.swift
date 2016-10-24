//
//  YYGlobalTimer.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/23.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

public typealias YYGlobalTimerHandler = () -> Void

// MARK: - 每隔0.1秒执行一次的定时器

/*
 1. 定时器运行在主线程中，滑动时也会运行，没有任务时，不执行
 2. 添加和移除操作是线程安全的
 3. 可以选择任务运行在主线程或Global线程中
 */
open class YYGlobalTimer {
    // MARK: - Public
    
    open static let `default` = YYGlobalTimer()
    
    init() {
        RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
        RunLoop.main.add(timer, forMode: .UITrackingRunLoopMode)
    }
    
    
    /// 添加任务,添加一个任务后timer会自动开始
    ///
    /// - parameter target:      任务的目标对象
    /// - parameter key:         任务的名字
    /// - parameter executedInMainThread: 是否在主线程中执行
    /// - parameter action:      action
    open class func addTask(for target: AnyObject? = nil, key: String, executedInMainThread: Bool = true, action: @escaping YYGlobalTimerHandler) {
        self.default.addTask(for: target, key: key, executedInMainThread: executedInMainThread, action: action)
    }
    
    /**
     移除任务，没有任务的话timer会自动停止
     */
    open class func removeTask(for target: AnyObject? = nil, key: String? = nil) {
        self.default.removeTask(for: target, key: key)
    }
    
    open class func removeAllTask() {
        self.default.removeAllTask()
    }
    
    var running = false
    var serialQueue = DispatchQueue(label: "YYGlobalTimer")
    lazy var timer: Timer = {
        return Timer(fireAt: Date.distantFuture, interval: 0.1, target: self, selector: #selector(timerTask), userInfo: nil, repeats: true)
    }()
    var targetTasksDict = [String: YYGlobalTimerTaskDict]()
}

// MARK: - Private

typealias YYGlobalTimerTaskDict = [String: YYGlobalTimerTask]

extension YYGlobalTimer {
    @objc func timerTask() {
        var hasTask = false
        let targetTasks = targetTasksDict.values
        for targetDict in targetTasks {
            let tasks = targetDict.values
            for task in tasks {
                //目标对象释放掉，删除target上的所有任务
                if task.target == nil {
                    targetTasksDict.removeValue(forKey: task.targetName)
                } else {
                    if task.executedInMainThread {
                        DispatchQueue.main.async {
                            task.task()
                        }
                    } else {
                        DispatchQueue.global().async {
                            task.task()
                        }
                    }
                    
                    hasTask = true
                }
            }
        }
        
        //如果没有任务，停止timer
        if !hasTask {
            pause()
        }
    }
}

// MARK: - Add Remove

extension YYGlobalTimer {
    func addTask(for target: AnyObject? = nil, key: String, executedInMainThread: Bool = true, action: @escaping YYGlobalTimerHandler) {
        let target = target ?? self
        let targetKey = "\(target)"
        let task = YYGlobalTimerTask(target: target, targetName: targetKey, task: action, taskName: key, executedInMainThread: executedInMainThread)
        addTask(task)
    }
    
    func addTask(_ task: YYGlobalTimerTask) {
        serialQueue.async {
            var targetTasksDict = self.targetTasksDict[task.targetName]
            if targetTasksDict != nil {
                //注意，值类型，targetTasksDict是另外一个字典 
                _ = self.targetTasksDict[task.targetName]?.updateValue(task, forKey: task.taskName)
            } else {
                targetTasksDict = [task.taskName: task]
                self.targetTasksDict[task.targetName] = targetTasksDict
            }
            
            self.startIfNeeded()
        }
    }
    
    func removeTask(for target: AnyObject? = nil, key: String? = nil) {
        if target == nil && key == nil {
            return
        }
        
        let targetKey = "\(target ?? self)"
        serialQueue.async {
            if let taskKey = key {
                //删除target上指定任务
                _ = self.targetTasksDict[targetKey]?.removeValue(forKey: taskKey)
            } else {
                //删除target上的所有任务
                self.targetTasksDict.removeValue(forKey: targetKey)
            }
            self.pauseIfNeeded()
        }
    }
    
    func removeAllTask() {
        serialQueue.async {
            self.targetTasksDict.removeAll()
            self.pause()
        }
    }
}

// MARK: - Start Pause

extension YYGlobalTimer {
    func startIfNeeded() {
        if !running && targetTasksDict.values.count > 0 {
            start()
        }
    }
    func pauseIfNeeded() {
        if running && targetTasksDict.values.count == 0 {
            pause()
        }
    }
    
    func start() {
        timer.fireDate = Date()
        running = true
    }
    
    func pause() {
        timer.fireDate = Date.distantFuture
        running = false
    }
}

// MARK: - YYGlobalTimerTask

struct YYGlobalTimerTask {
    weak var target: AnyObject?
    var targetName: String
    
    var task: YYGlobalTimerHandler
    var taskName: String
    
    var executedInMainThread: Bool
}


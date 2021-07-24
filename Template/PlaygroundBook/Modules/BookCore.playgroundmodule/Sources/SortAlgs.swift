import Foundation
import PlaygroundSupport
import SpriteKit
import UIKit
import SwiftUI

private extension Int {
    var parent: Int {
        return (self - 1) / 2
    }
    
    var leftChild: Int {
        return (self * 2) + 1
    }
    
    var rightChild: Int {
        return (self * 2) + 2
    }
}

extension Array where Element: Comparable {
    
    //MARK: Bubble
    public mutating func bubbleSort() {
        for alreadySorted in 1 ... self.count {
            var sorted = true
            for walkerIndex in 0 ..< self.count - alreadySorted {
                if self[walkerIndex] > self[walkerIndex + 1] {
                    swapAt(walkerIndex, walkerIndex + 1)
                    print("Change \(walkerIndex) X \(walkerIndex + 1)")
                    sorted = false
                }
            }
            if sorted {
                break
            }
        }
    }
    
    //MARK: Selection
    public mutating func selectionSort() {
        for iterationIndex in 0 ..< self.count - 1 {
            
            var minIndex = iterationIndex
            
            for compareIndex in iterationIndex + 1 ..< self.count {
                if self[compareIndex] < self[minIndex] {
                    minIndex = compareIndex
                }
            }
            
            swapAt(iterationIndex, minIndex)
        }
    }
    
    //MARK: Inserction
    public mutating func insertionSort() {
        for iterationIndex in 0 ..< self.count {
            
            var swapIndex = iterationIndex
            
            while swapIndex > 0 {
                
                if self[swapIndex] < self[swapIndex - 1] {
                    swapAt(swapIndex, swapIndex - 1)
                    swapIndex -= 1
                } else {
                    break
                }
                
            }
            
        }
        
    }
    
    //MARK: Quick
    public mutating func quickSort() {
        var slice = self[0..<self.endIndex]
        quickSort(&slice)
    }
    
    private func quickSort(_ array: inout ArraySlice<Element>) {
        if array.count < 2 {
            return
        }
        
        sortPivot(in: &array)
        let pivot = partition(&array)
        
        var firstSlice = array[array.startIndex..<pivot]
        var secondSlice = array[pivot + 1..<array.endIndex]
        
        quickSort(&firstSlice)
        quickSort(&secondSlice)
    }
    
    private func partition(_ array: inout ArraySlice<Element>) -> ArraySlice<Element>.Index {
        let midPoint = (array.startIndex + array.endIndex) / 2
        array.swapAt(midPoint, array.startIndex)
        let pivot = array[array.startIndex]
        
        var lower = array.startIndex
        var upper = array.endIndex - 1
        
        repeat {
            while lower < array.endIndex - 1 && array[lower] <= pivot {
                lower += 1
            }
            while array[upper] > pivot {
                upper -= 1
            }
            
            if lower < upper {
                array.swapAt(lower, upper)
            }
        } while lower < upper
        
        array.swapAt(array.startIndex, upper)
        return upper
    }
    
    private func sortPivot(in array: inout ArraySlice<Element>) {
        let startPoint = array.startIndex
        let midPoint = (array.startIndex + array.endIndex) / 2
        let endPoint = array.endIndex - 1
        
        if array[startPoint] > array[midPoint] {
            array.swapAt(startPoint, midPoint)
        }
        if array[midPoint] > array[endPoint] {
            array.swapAt(midPoint, endPoint)
        }
        if array[startPoint] > array[midPoint] {
            array.swapAt(startPoint, midPoint)
        }
    }
    
    //MARK: Heap
    public mutating func heapSort() {
        buildHeap()
        shrinkHeap()
    }
    
    private mutating func buildHeap() {
        for index in 1..<self.count {
            var child = index
            var parent = child.parent
            while child > 0 && self[child] > self[parent] {
                swapAt(child, parent)
                child = parent
                parent = child.parent
            }
        }
    }
    
    private mutating func shrinkHeap() {
        for index in stride(from: self.count - 1, to: 0, by: -1) {
            swapAt(0, index)
            var parent = 0
            var leftChild = parent.leftChild
            var rightChild = parent.rightChild
            while parent < index {
                var maxChild = -1
                if leftChild < index {
                    maxChild = leftChild
                } else {
                    break
                }
                if rightChild < index && self[rightChild] > self[maxChild] {
                    maxChild = rightChild
                }
                guard self[maxChild] > self[parent] else { break }
                
                swapAt(parent, maxChild)
                parent = maxChild
                leftChild = parent.leftChild
                rightChild = parent.rightChild
            }
        }
    }
    
    //MARK: Merge
    public mutating func mergeSort() {
        let startSlice = self[0..<self.count]
        let slice = mergeSort(startSlice)
        let array = Array(slice)
        self = array
    }
    
    public func mergeSorted() -> Array<Element> {
        let startSlice = self[0..<self.count]
        let slice = mergeSort(startSlice)
        let array = Array(slice)
        return array
    }
    
    private func mergeSort(_ array: ArraySlice<Element>) -> ArraySlice<Element> {
        if array.count < 2 {
            return array
        } else {
            let midIndex = (array.endIndex + array.startIndex) / 2
            let slice1 = mergeSort(array[array.startIndex..<midIndex])
            let slice2 = mergeSort(array[midIndex..<array.endIndex])
            return merge(slice1, slice2)
        }
    }
    
    private func merge(_ firstArray: ArraySlice<Element>, _ secondArray: ArraySlice<Element>) -> ArraySlice<Element> {
        var newArray = ArraySlice<Element>()
        newArray.reserveCapacity(firstArray.count + secondArray.count)
        var index1 = firstArray.startIndex
        var index2 = secondArray.startIndex
        
        while index1 < firstArray.endIndex && index2 < secondArray.endIndex {
            if firstArray[index1] < secondArray[index2] {
                newArray.append(firstArray[index1])
                index1 += 1
            } else {
                newArray.append(secondArray[index2])
                index2 += 1
            }
        }
        
        if index1 < firstArray.endIndex {
            let range = index1..<firstArray.endIndex
            let remainingElements = firstArray[range]
            newArray.append(contentsOf: remainingElements)
        }
        if index2 < secondArray.endIndex {
            let range = index2..<secondArray.endIndex
            let remainingElements = secondArray[range]
            newArray.append(contentsOf: remainingElements)
        }
        
        return newArray
    }
    
}

public enum enumSortAlgorithm: String {
    case bubblesort
}

public class SortAlgs {
    
    
    
}

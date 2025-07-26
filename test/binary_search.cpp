#include <iostream>
#include <vector>
#include <cassert>

/**
 * Binary search implementation for finding an element in a sorted array
 * Time Complexity: O(log n)
 * Space Complexity: O(1)
 */
int binarySearch(const std::vector<int>& sortedArray, int target) {
    int left = 0;
    int right = sortedArray.size() - 1;
    
    while (left <= right) {
        // Avoid overflow: (left + right) / 2 could overflow
        int mid = left + (right - left) / 2;
        
        if (sortedArray[mid] == target) {
            return mid;  // Found the target
        } else if (sortedArray[mid] < target) {
            left = mid + 1;  // Search right half
        } else {
            right = mid - 1;  // Search left half
        }
    }
    
    return -1;  // Target not found
}

// Recursive version for comparison
int binarySearchRecursive(const std::vector<int>& arr, int target, 
                         int left, int right) {
    if (left > right) {
        return -1;
    }
    
    int mid = left + (right - left) / 2;
    
    if (arr[mid] == target) {
        return mid;
    } else if (arr[mid] < target) {
        return binarySearchRecursive(arr, target, mid + 1, right);
    } else {
        return binarySearchRecursive(arr, target, left, mid - 1);
    }
}

int main() {
    // Test cases
    std::vector<int> testArray = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19};
    
    // Test 1: Element exists
    int index = binarySearch(testArray, 7);
    assert(index == 3);
    std::cout << "Found 7 at index: " << index << std::endl;
    
    // Test 2: Element doesn't exist
    index = binarySearch(testArray, 6);
    assert(index == -1);
    std::cout << "6 not found, returned: " << index << std::endl;
    
    // Test 3: Edge cases
    assert(binarySearch(testArray, 1) == 0);   // First element
    assert(binarySearch(testArray, 19) == 9);  // Last element
    assert(binarySearch({}, 5) == -1);         // Empty array
    
    std::cout << "All tests passed!" << std::endl;
    
    return 0;
}
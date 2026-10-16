def calculate_statistics(numbers):
    
    if numbers == []:
        return {
            'mean': 0,
            'max': None,
            'min': None,
            'count': 0
        }
    
    return {
        'mean': sum(numbers) / len(numbers),
        'max': max(numbers),
        'min': min(numbers),
        'count': len(numbers)
    }


# Test cases
test_list = [10, 20, 30, 40, 50]
empty_list = []

print(f"[10,20,30,40,50] -> {calculate_statistics(test_list)}")
print(f"[] -> {calculate_statistics(empty_list)}")
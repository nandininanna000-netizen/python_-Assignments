def count_items(items_list):
    count={}
    for item in items_list:
        count[item]=count.get(item,0)+1
    print(count)
list=['apple', 'banana', 'apple', 'orange', 'banana', 'apple']
count_items(list)
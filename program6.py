def seperator_even_odd(num):
    even=[]
    odd=[]
    for i in num:
        if i%2==0:
            even.append(i)
        else:
            odd.append(i)
    print("Even numbers:",even)
    print("Odd numbers:",odd)

seperator_even_odd([1,2,3,4,5,6,7,8,9,10])
def palindrome_check(s):
    s=s.replace(" ", "").lower()
    #print(s)
    if s==s[::-1]:
        print("True")
    else:
        print("False")
        
palindrome_check('level')
palindrome_check('Hello')
palindrome_check('racecar')
palindrome_check('A man a plan a canal Panama')
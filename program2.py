def assign_grade(score):
  if 100>=score>=90:
    print("assign_grade(",score,")-> A")
  elif 89>=score>=80:
    print("assign_grade(",score,")-> B")
  elif 79>=score>=70:
    print("assign_grade(",score,")-> C")
  elif 69>=score>=60:
    print("assign_grade(",score,")-> D")
  elif 59>=score>=0:
    print("assign_grade(",score,")-> F")
  else:
    print("Invalid Score")
assign_grade(95)
assign_grade(85)
assign_grade(75)
assign_grade(65)
assign_grade(55)
assign_grade(105)
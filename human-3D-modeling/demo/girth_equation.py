a = 32 / 2
b = 23 / 2

a_plus_b = a + b
a_plus_b_power_2 = ((a + b) ** 2)
a_minus_b_power_2 =  (3 * ((a - b) ** 2))
root = (4 - ((3 * ((a - b) ** 2)) / ((a + b) ** 2)) ) ** 0.5
pi = 22/7
third_bracket = ((10 + ((4 - ((3 * ((a - b) ** 2)) / ((a + b) ** 2)) ) ** 0.5)) * ((a + b) ** 2))
second_bracket = 1 +( (3 * ((a - b) ** 2)) / ((10 + ((4 - ((3 * ((a - b) ** 2)) / ((a + b) ** 2)) ) ** 0.5)) * ((a + b) ** 2)))

girth = (22/7) * (a + b) * (1 +( (3 * ((a - b) ** 2)) / ((10 + ((4 - ((3 * ((a - b) ** 2)) / ((a + b) ** 2)) ) ** 0.5)) * ((a + b) ** 2))))


# grith = (22/7) * (( a + b ) * (1 + (3 * ((a - b) ** 2)) + ( ( (a + b) ** 2) * (10 + ((4 - (3 * ((a - b) ** 2) ) + ((a + b) ** 2) ) ** 0.5) ) ) ))
print(girth)
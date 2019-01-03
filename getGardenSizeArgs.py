from sys import argv
# Get dimensions of garden from command line
script, width_feet, length_feet = argv

width_feet = int(width_feet)
length_feet = int(length_feet)

print("The script is called:", script)
print("The width of your garden in feet is:", width_feet)
print("The length of your garden in feet is:", length_feet)
print("The size of your garden in sqft is:", width_feet*length_feet)


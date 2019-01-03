from sys import argv
# find cubit yards of soil needed for new garden.

script, width_feet, length_feet = argv

width_feet = int(width_feet)
length_feet = int(length_feet)

depth_inches = input("Desired depth in inches:")
depth_feet = int(depth_inches)/12.
volume_cubic_yards = width_feet*length_feet*depth_feet/9. 

print("Script is:", script)
print("width in feet:", width_feet)
print("length in feet:", length_feet)
print("depth in inches:", depth_inches)
print("Cubit yards of soil needed:",volume_cubic_yards)

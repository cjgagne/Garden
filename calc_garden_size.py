def calc_garden_size(width_feet, length_feet):
    return width_feet * length_feet


width_feet = float(input("Width of garden in feet: "))
length_feet = float(input("Length of garden in feet: "))
print(f"Your garden is {width_feet} ft by {length_feet} ft or {calc_garden_size(width_feet, length_feet)} sqft.")

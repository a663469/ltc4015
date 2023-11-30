print("i2c dump reader")

file1 = open("dump_ltc4015.txt", "r")
Lines = file1.readlines()

file2 = open("conv_dump_ltc4015.txt", "w")

count = 0

for line in Lines:
	words = line.split()
	for word in words:
		if len(word) == 4:
			rc = '0x' + format(count, '02X')
			# word = '0x' + word
			# print("{}: {}".format(rc, word.upper()))
			file2.writelines("{}: {}\n".format(rc, word.upper()))
			count += 1
	# print("Line {}: {}".format(count, line.strip()))


file1.close()
file2.close()
print("i2cdumpconvertor - ok")
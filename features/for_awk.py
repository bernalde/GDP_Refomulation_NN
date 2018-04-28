a = ""
for i in range(17):
	a = a + "$" + str(i+2) + ","
print "awk '{print " + a + "}'"
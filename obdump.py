#!/usr/bin/python
import sys, re

codes =[]

if len(sys.argv) != 2 or sys.argv[1] not in ('-u','-x','-n'):
	print "ERROR. \nUSO: objdump -d -M intel <binario> | obdump.py bin <-x|-u|-n>"
	sys.exit(1)

if __name__ == "__main__":
	for line in sys.stdin:
		try:
			p=re.search(r":[ \t]+([0-9a-f]{2}[ \t])+",line)
			for code in p.group(0).split():
				if code != ":":
					if sys.argv[1] == '-x': 
						codes.append("\\x%s" % code)
					elif sys.argv[1] == '-u':
						unicode=(code*2)
						codes.append("\\u%s" % unicode)
					else:
						codes.append(code*2)
		except:
			pass

print ''.join(codes)


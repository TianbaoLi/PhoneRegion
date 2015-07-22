#!/usr/lob/python# -*- coding:utf-8 -*-  
#!/usr/bin/python
import sys
count={}

for line in sys.stdin:
	line=line.strip()
	province=line.split()
	try:
		count[province[0]]=count.get(province[0],0)+1
	except ValueError:
		pass
	#print "%s\t%d" % (province[0],count[province[0]])

for prov in count:
	print '%s\t%s' % (prov,count[prov])


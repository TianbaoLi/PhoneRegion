#!/usr/lob/python# -*- coding:utf-8 -*-  
#!/usr/bin/python
from operator import itemgetter
import sys
count={}

for line in sys.stdin:
	line=line.strip()
	province=line.split()
	count[province[0]]=count.get(province[0],0)+1
	#print "%s\t%d" % (province[0],count[province[0]])

sorted_count=sorted(count.items(),key=itemgetter(0))
for prov,times in sorted_count:
	print '%s\t%s' % (prov,times)
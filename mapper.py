#!/usr/lob/python# -*- coding:utf-8 -*-  
#!/usr/bin/python
import sys
import normalizer
import json

def collect(dic):
	result={}
	for line in dic.readlines():
		line=line.strip()
		left,right=line.split(':')
		result[left]=right
	return result

file=open("source//area_city","r")
area_city=collect(file)
file=open("source//city_prov","r")
city_prov=collect(file)
mobile={}
index=['130','131','132','133','134','135','136','137','138','139','145','147','150','151','152','153','155','156','157','158','159','170','176','177','178','180','181','182','183','184','185','186','187','188','189']
for i in index:
	path="source//mobile_city//"+i
	file=open(path,"r")
	mobile[i]=collect(file)
	#print json.dumps(mobile[i], encoding='UTF-8', ensure_ascii=False)

#print json.dumps(area_city, encoding='UTF-8', ensure_ascii=False)
#print json.dumps(city_prov, encoding='UTF-8', ensure_ascii=False)
#count=0

#print json.dumps(mobile[186], encoding='UTF-8', ensure_ascii=False)

for line in sys.stdin:
	#count+=1
	line=line.strip()
	if(line==""):
		continue
	id_phone=line.split()
	#print id_phone
	info=normalizer.phone_normalize(id_phone[1])
	if(info[0][0]!=1 or info[0][3]=='13800138000'):
		continue
	if(info[0][2]==None):
		first=info[0][3][0:3]
		#print json.dumps(mobile, encoding='UTF-8', ensure_ascii=False)
		#print info[0][3][0:7]

		if(mobile[first].has_key("%s" % info[0][3][0:7])==False):
			continue
		city=mobile[first]["%s" % info[0][3][0:7]]
		#if(count%100==0):
			#print count
		print city_prov[city]
	else:
		if(area_city.has_key("%s" % info[0][2])==False):
			continue
		city=area_city["%s" % int(info[0][2])]
		print city_prov[city]



# cat batchdata  | python mapper.py | python reducer.py 
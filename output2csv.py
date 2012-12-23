import os, re, csv

# regular expressions for capturing the interesting quantities
lr_pattern = 'array\(\[ (.+?)\]\)'
res_pattern = '^([0-9.]+$)'

output_dir = "output"
results_file = '../results.csv'	# relative to the output_dir

os.chdir( output_dir )
files = filter( os.path.isfile, os.listdir( '.' ))
#files = [ os.path.join( output_dir, f ) for f in files ] # add path to each file
files.sort( key=lambda x: os.path.getmtime( x ))

results = []

for file in files:
	f = open( file )
	contents = f.read()
	
	#print contents
	matches = re.search( lr_pattern, contents )
	try:
		lr = float( matches.group( 1 ))
	except AttributeError:
		print contents
		continue
		
	matches = re.search( res_pattern, contents, re.M )
	try:
		res = matches.group( 1 )
	except AttributeError:
		print contents
		continue
		
	results.append(( lr, res ))
	
writer = csv.writer( open( results_file, 'wb' ))
for result in results:
	writer.writerow( result )
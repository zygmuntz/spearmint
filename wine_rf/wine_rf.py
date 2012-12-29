# python spearmint_sync.py --method=GPEIChooser wine_rf

import sys, subprocess, re
from math import exp

def get_validation_loss( data ):
	pattern = 'rmse: ([0-9.]+)'
	matches = re.search( pattern, data )

	validation_loss = float( matches.group( 1 ))
	return validation_loss

def run_test( params ):

	parameters = []
	for p in ['ntrees', 'mtry']:
		parameter = str( params[p][0] )
		parameters.append( parameter )	
	
	data = subprocess.check_output( ['r', 'run_rf.r'] + parameters )
	validation_loss = get_validation_loss( data )

	print validation_loss
	return validation_loss

def main( job_id, params ):
	print 'Job id:', str( job_id )
	print params
	
	return run_test( params )

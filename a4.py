# python spearmint_sync.py --method=GPEIChooser a4

import sys, subprocess, re
from math import exp

def get_validation_loss( data ):
	pattern = 'For the validation data, the classification cross-entropy loss is ([0-9.]+),'
	matches = re.search( pattern, data )

	validation_loss = float( matches.group( 1 ))
	return validation_loss

def run_test( params ):

	debug_o = open( 'debug', 'wb' )
	print >> debug_o, params
	
	parameters = []
	'''
	for p in ['weight_decay', 'hiddens', 'iterations', 'learning_rate', 'momentum', 'early_stopping', 'batch_size']:
		parameter = str( params[p][0] )
		parameters.append( parameter )	
	'''
	
	log_learning_rate = params['log_rbm_learning_rate'][0]
	learning_rate = exp( log_learning_rate )
	
	parameters.append( str( learning_rate ))
	
	print >> debug_o, parameters

	data = subprocess.check_output( ['octave', '-qf', 'run.m'] + parameters )
	validation_loss = get_validation_loss( data )

	print validation_loss
	return validation_loss

def main( job_id, params ):

	# this will land in output/ files
	print 'Job id:', str( job_id )
	
	return run_test( params )

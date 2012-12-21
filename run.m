args = argv();

# we need numbers
for i = 1:nargin
	args{i} = str2num( args{i} );
end

# init the neural network
a4_init

# if we were optimizing a few params
# a4_main( 300, args{1}, args{2}, args{3}, args{4} )

# learn and validate
a4_main( 300, 0.02, args{1}, 1000 )
